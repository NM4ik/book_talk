import 'package:book_talk/src/common/constants/config.dart';
import 'package:book_talk/src/common/utils/logger.dart';
import 'package:book_talk/src/common/utils/preferences_storage/preferences_storage.dart';
import 'package:book_talk/src/feature/bootstrap/model/dependencies_container.dart';
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
    final result = CompositionResult(
      dependencies: dependencies,
      msSpent: stopwatch.elapsedMilliseconds,
    );

    return result;
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
    final sharedPreferences = SharedPreferencesStorage(
      sharedPreferences: SharedPreferencesAsync(),
    );
    final settingsBloc = await SettingsBlocFactory(sharedPreferences).create();

    return DependenciesContainer(
      appSettingsBloc: settingsBloc,
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
    final initialState = AppSettingsState.idle(appSettings);

    return AppSettingsBloc(
      appSettingsRepository: appSettingsRepository,
      initialState: initialState,
    );
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
