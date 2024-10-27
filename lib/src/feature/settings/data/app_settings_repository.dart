import 'package:book_talk/src/feature/settings/data/app_settings_datasource.dart';
import 'package:book_talk/src/feature/settings/model/app_settings.dart';

abstract class AppSettingsRepository {
  const AppSettingsRepository();

  Future<AppSettings?> getAppSettings();

  Future<void> setAppSettings(AppSettings settings);
}

final class AppSettingsRepositoryImpl extends AppSettingsRepository {
  final AppSettingsDatasource _appSettingsDatasource;

  const AppSettingsRepositoryImpl({
    required AppSettingsDatasource appSettingsDatasource,
  }) : _appSettingsDatasource = appSettingsDatasource;

  @override
  Future<AppSettings?> getAppSettings() async =>
      _appSettingsDatasource.getSettings();

  @override
  Future<void> setAppSettings(AppSettings settings) async =>
      _appSettingsDatasource.saveSettings(settings);
}
