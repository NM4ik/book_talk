import 'dart:io';

import 'package:book_talk/src/common/constants/config.dart';
import 'package:book_talk/src/common/constants/pubspec.yaml.g.dart';
import 'package:book_talk/src/common/model/app_metadata.dart';
import 'package:book_talk/src/common/rest_api/auth/auth_client.dart';
import 'package:book_talk/src/common/rest_api/auth/auth_refresh.dart';
import 'package:book_talk/src/common/rest_api/auth/auth_storage.dart';
import 'package:book_talk/src/common/rest_api/interceptors/log_interceptor.dart';
import 'package:book_talk/src/common/rest_api/rest_api.dart';
import 'package:book_talk/src/common/utils/logger.dart';
import 'package:book_talk/src/common/utils/preferences_storage/preferences_storage.dart';
import 'package:book_talk/src/feature/account/bloc/account_bloc.dart';
import 'package:book_talk/src/feature/account/data/user_datasource.dart';
import 'package:book_talk/src/feature/account/data/user_repository.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/auth/data/auth_datasource.dart';
import 'package:book_talk/src/feature/auth/data/auth_repository.dart';
import 'package:book_talk/src/feature/auth/data/auth_storage.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:book_talk/src/feature/bootstrap/model/dependencies_container.dart';
import 'package:book_talk/src/feature/rooms/bloc/rooms_bloc.dart';
import 'package:book_talk/src/feature/rooms/data/rooms_datasource.dart';
import 'package:book_talk/src/feature/rooms/data/rooms_repository.dart';
import 'package:book_talk/src/feature/settings/bloc/app_settings_bloc.dart';
import 'package:book_talk/src/feature/settings/data/app_settings_datasource.dart';
import 'package:book_talk/src/feature/settings/data/app_settings_repository.dart';
import 'package:clock/clock.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rxdart/transformers.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class CompositionRoot {
  const CompositionRoot(this.config, this.logger);

  final Config config;

  final AppLogger logger;

  /// Composes dependencies and returns result of composition.
  Future<CompositionResult> compose() async {
    final stopwatch = clock.stopwatch()..start();

    logger.logMessage('Initializing dependencies...');
    final dependencies = await createDependenciesContainer(config, logger);
    logger.logMessage('Dependencies initialized');

    stopwatch.stop();

    return CompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );
  }
}

/// Creates an instance of [DependenciesContainer].
Future<DependenciesContainer> createDependenciesContainer(
  Config config,
  AppLogger logger,
) async {
  /// common
  final AppMetadata appMetaData = createAppMetaData(config);

  /// datasource
  final PreferencesStorage sharedPreferences = PreferencesStorage$SharedPref(
    sharedPreferences: SharedPreferencesAsync(),
  );
  final AuthStorage authStorage = await createAuthStorage(sharedPreferences);

  /// Rest API
  final RestClient restClient = createRestClient(authStorage, appLogger);

  /// BLoC
  final AppSettingsBloc settingsBloc = await createAppSettingsBloc(
    sharedPreferences,
  );
  final AuthBloc authBloc = await createAuthBloc(
    sharedPreferences,
    authStorage,
    restClient,
  );
  final AccountBloc accountBloc = createAccountBloc(
    authBloc.stream
        .map((state) => state.authStatus)
        .startWith(authBloc.state.authStatus)
        .distinct(),
    restClient,
  );
  final RoomsBloc roomsBloc = createRoomsBloc(restClient);

  return DependenciesContainer(
    config: config,
    appSettingsBloc: settingsBloc,
    appMetadata: appMetaData,
    authBloc: authBloc,
    accountBloc: accountBloc,
    roomsBloc: roomsBloc,
  );
}

RestClient createRestClient(AuthStorage authStorage, AppLogger appLogger) {
  final RestClient restClient = RestClientDio(
    baseUrl: dotenv.env['API_BASE_URL'] ?? '',
    headers: {},
  );

  // TODO(Mikhailov): separate logic of dio interceptor
  (restClient as RestClientDio).injectAuthenticationInterceptor(
    tokenStorage: RestApiAuthStorage(authStorage: authStorage),
    authorizationClient: RestApiAuthorizationClient(
      authenticationRefreshRepository: AuthenticationRefreshRepositoryImpl(
        restClient: restClient,
      ),
    ),
    excludedPaths: ['auth/login', 'auth/refresh'],
  );

  // TODO(Mikhailov): ifDebug
  restClient.injectInterceptor(
    interceptor: LoggerInterceptor(appLogger: appLogger),
  );

  return restClient;
}

/// Creates and instance of [AuthStorage] and fetch token from storage.
Future<AuthStorage> createAuthStorage(
  PreferencesStorage preferencesStorage,
) async {
  final authStorage = AuthStorageImpl(preferencesStorage: preferencesStorage);
  await authStorage.get();
  return authStorage;
}

/// Creates an instance of [AppSettingsBloc].
Future<AppSettingsBloc> createAppSettingsBloc(
  PreferencesStorage sharedPreferences,
) async {
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

/// Creates an instance of [AppMetadata].
AppMetadata createAppMetaData(Config config) => AppMetadata(
  environment: config.environment.name,
  appVersion: Pubspec.version.canonical,
  operatingSystem: Platform.operatingSystem,
  locale: Platform.localeName,
);

/// Creates an instance of [AuthBloc].
Future<AuthBloc> createAuthBloc(
  PreferencesStorage preferencesStorage,
  AuthStorage authStorage,
  RestClient restClient,
) async {
  final authDatasource = AuthDatasourceImpl(restClient: restClient);
  final authRepository = AuthRepositoryImpl(
    authStorage: authStorage,
    authDatasource: authDatasource,
  );

  return AuthBloc(
    AuthState.idle(
      authStatus: authStorage.isAuth ? AuthStatus.auth : AuthStatus.unAuth,
    ),
    authRepository: authRepository,
  );
}

/// Creates an instance of [RoomsBloc].
RoomsBloc createRoomsBloc(RestClient restClient) => RoomsBloc(
  const RoomsState.idle(rooms: null),
  roomsRepository: RoomsRepositoryImpl(
    roomsDatasource: RoomsDatasourceImpl(restClient: restClient),
  ),
);

/// Creates an instance of [AccountBloc].
AccountBloc createAccountBloc(
  Stream<AuthStatus> authStatusStream,
  RestClient restClient,
) => AccountBloc(
  userRepository: UserRepositoryImpl(
    userDatasource: UserDatasourceImpl(restClient: restClient),
  ),
  authStatusStream: authStatusStream,
);

/// Creates an instance of [UserRepository].
UserRepository createUserRepository(RestClient restClient) =>
    UserRepositoryImpl(
      userDatasource: UserDatasourceImpl(restClient: restClient),
    );

/// {@template composition_result}
/// Result of composition
///
/// {@macro composition_process}
/// {@endtemplate}
final class CompositionResult {
  /// {@macro composition_result}
  const CompositionResult({required this.dependencies, required this.msSpent});

  /// The dependencies container
  final DependenciesContainer dependencies;

  /// The number of milliseconds spent
  final int msSpent;

  @override
  String toString() =>
      '$CompositionResult('
      'dependencies: $dependencies, '
      'msSpent: $msSpent'
      ')';
}
