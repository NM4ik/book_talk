import 'package:book_talk/src/feature/settings/data/app_settings_datasource.dart';
import 'package:book_talk/src/feature/settings/model/app_settings.dart';
import 'package:flutter/material.dart';

abstract class AppSettingsRepository {
  const AppSettingsRepository();

  Future<AppSettings?> getAppSettings();

  Future<void> setAppSettings(AppSettings settings);
}

final class AppSettingsRepositoryImpl extends AppSettingsRepository {
  const AppSettingsRepositoryImpl({
    required AppSettingsDatasource appSettingsDatasource,
  }) : _appSettingsDatasource = appSettingsDatasource;

  final AppSettingsDatasource _appSettingsDatasource;

  @override
  Future<AppSettings?> getAppSettings() async =>
      (await _appSettingsDatasource.getSettings()) ??
      const AppSettings(themeMode: ThemeMode.dark, locale: null);

  @override
  Future<void> setAppSettings(AppSettings settings) async =>
      _appSettingsDatasource.saveSettings(settings);
}
