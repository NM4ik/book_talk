import 'dart:io';

import 'package:book_talk/src/common/constants/config.dart';
import 'package:book_talk/src/common/constants/pubspec.yaml.g.dart';
import 'package:book_talk/src/common/model/app_metadata.dart';
import 'package:book_talk/src/common/utils/logger.dart';
import 'package:book_talk/src/common/utils/preferences_storage/preferences_storage.dart';
import 'package:book_talk/src/feature/account/bloc/account_bloc.dart';
import 'package:book_talk/src/feature/account/data/user_repository.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/auth/data/auth_datasource.dart';
import 'package:book_talk/src/feature/auth/data/auth_repository.dart';
import 'package:book_talk/src/feature/auth/data/auth_storage.dart';
import 'package:book_talk/src/feature/account/data/user_datasource.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:book_talk/src/feature/bootstrap/model/dependencies_container.dart';
import 'package:book_talk/src/feature/rooms/bloc/rooms_bloc.dart';
import 'package:book_talk/src/feature/rooms/data/rooms_datasource.dart';
import 'package:book_talk/src/feature/rooms/data/rooms_repository.dart';
import 'package:book_talk/src/feature/settings/bloc/app_settings_bloc.dart';
import 'package:book_talk/src/feature/settings/data/app_settings_datasource.dart';
import 'package:book_talk/src/feature/settings/data/app_settings_repository.dart';
import 'package:clock/clock.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class CompositionRoot {
  const CompositionRoot(this.config, this.logger);

  final Config config;

  final AppLogger logger;

  /// Composes dependencies and returns result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();

    logger.logMessage('Initializing dependencies...');
    final dependencies = await DependenciesFactory(config, logger).create();
    logger.logMessage('Dependencies initialized');

    stopwatch.stop();

    return CompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
  }
}

/// {@template factory}
/// Factory that creates an instance of [T].
/// {@endtemplate}
abstract class Factory<T> {
  /// Creates an instance of [T].
  T create();
}

/// {@template async_factory}
/// Factory that creates an instance of [T] asynchronously.
/// {@endtemplate}
abstract class AsyncFactory<T> {
  /// Creates an instance of [T].
  Future<T> create();
}

/// {@template dependencies_factory}
/// Factory that creates an instance of [DependenciesContainer].
/// {@endtemplate}
class DependenciesFactory extends AsyncFactory<DependenciesContainer> {
  /// {@macro dependencies_factory}
  DependenciesFactory(this.config, this.logger);

  /// Application configuration
  final Config config;

  /// Logger used to log information during composition process.
  final AppLogger logger;

  @override
  Future<DependenciesContainer> create() async {
    /// common
    final appMetaData = AppMetadataFactory(
      config: config,
    ).create();

    /// datasource
    final sharedPreferences = SharedPreferencesStorage(
      sharedPreferences: SharedPreferencesAsync(),
    );
    final AuthStorage<String> authStorage = AuthStorageImpl(
      preferencesStorage: sharedPreferences,
    );

    /// repositories
    final userRepository = UserRepositoryFactory().create();

    /// BLoC
    final settingsBloc = await SettingsBlocFactory(
      sharedPreferences,
    ).create();
    final authBloc = await AuthBlocFactory(
      preferencesStorage: sharedPreferences,
      authStorage: authStorage,
    ).create();
    final accountBloc = AccountBlocFactory(
      authStorage: authStorage,
      userRepository: userRepository,
    ).create();
    final roomsBloc = RoomsBlocFactory().create();

    return DependenciesContainer(
      appSettingsBloc: settingsBloc,
      appMetadata: appMetaData,
      authBloc: authBloc,
      userRepository: userRepository,
      accountBloc: accountBloc,
      roomsBloc: roomsBloc,
    );
  }
}

/// {@template settings_bloc_factory}
/// Factory that creates an instance of [AppSettingsBloc].
/// {@endtemplate}
class SettingsBlocFactory extends AsyncFactory<AppSettingsBloc> {
  /// {@macro settings_bloc_factory}
  SettingsBlocFactory(this.sharedPreferences);

  /// Shared preferences instance
  final PreferencesStorage sharedPreferences;

  @override
  Future<AppSettingsBloc> create() async {
    final appSettingsRepository = AppSettingsRepositoryImpl(
      appSettingsDatasource: AppSettingsDatasourceImpl(
        preferencesStorage: sharedPreferences,
      ),
    );

    final appSettings = await appSettingsRepository.getAppSettings();
    final initialState = AppSettingsState.idle(appSettings: appSettings);

    return AppSettingsBloc(
      appSettingsRepository: appSettingsRepository,
      initialState: initialState,
    );
  }
}

class AppMetadataFactory extends Factory<AppMetadata> {
  AppMetadataFactory({required this.config});
  final Config config;

  @override
  AppMetadata create() {
    return AppMetadata(
      environment: config.environment.name,
      appVersion: Pubspec.version.canonical,
      operatingSystem: Platform.operatingSystem,
      locale: Platform.localeName,
    );
  }
}

class AuthBlocFactory extends AsyncFactory<AuthBloc> {
  AuthBlocFactory({
    required this.preferencesStorage,
    required this.authStorage,
  });

  final PreferencesStorage preferencesStorage;
  final AuthStorage authStorage;

  @override
  Future<AuthBloc> create() async {
    final AuthDatasource authDatasource = AuthDatasourceTemporaryImpl();
    final AuthRepository authRepository = AuthRepositoryImpl(
      authStorage: authStorage,
      authDatasource: authDatasource,
    );
    final token = await authStorage.get();

    return AuthBloc(
      AuthState.idle(
        authStatus: token != null ? AuthStatus.auth : AuthStatus.unAuth,
      ),
      authRepository: authRepository,
    );
  }
}

class RoomsBlocFactory extends Factory<RoomsBloc> {
  RoomsBlocFactory();

  @override
  RoomsBloc create() {
    return RoomsBloc(
      const RoomsState.idle(rooms: null),
      roomsRepository: RoomsRepositoryImpl(
        roomsDatasource: RoomsDatasourceImpl(),
      ),
    );
  }
}

class AccountBlocFactory extends Factory<AccountBloc> {
  AccountBlocFactory({required this.authStorage, required this.userRepository});
  final AuthStorage authStorage;
  final UserRepository userRepository;

  @override
  AccountBloc create() {
    return AccountBloc(
      authStorage: authStorage,
      userRepository: userRepository,
    );
  }
}

class UserRepositoryFactory extends Factory<UserRepository> {
  @override
  UserRepository create() {
    return UserRepositoryImpl(userDatasource: UserDatasourceImpl());
  }
}

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({
    required this.dependencies,
    required this.msSpent,
  });

  /// The dependencies container
  final DependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() => '$CompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
