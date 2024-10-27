import 'package:book_talk/src/common/utils/preferences_storage/preferences_entry.dart';
import 'package:book_talk/src/common/utils/preferences_storage/preferences_storage.dart';
import 'package:book_talk/src/feature/settings/model/app_settings.dart';

abstract interface class AppSettingsDatasource {
  Future<void> saveSettings(AppSettings settings);
  Future<AppSettings?> getSettings();
}

final class AppSettingsDatasourceImpl implements AppSettingsDatasource {
  AppSettingsDatasourceImpl({required PreferencesStorage preferencesStorage})
      : _preferencesStorage = preferencesStorage;

  final PreferencesStorage _preferencesStorage;

  late final _appSettingsPreferencesEntry = _AppSettingsPreferencesEntry(
    key: 'appSettings',
    preferencesStorage: _preferencesStorage,
  );

  @override
  Future<AppSettings?> getSettings() async =>
      await _appSettingsPreferencesEntry.get();

  @override
  Future<void> saveSettings(AppSettings settings) async =>
      await _appSettingsPreferencesEntry.set(settings);
}

final class _AppSettingsPreferencesEntry
    extends PreferencesStorageEntry<AppSettings> {
  const _AppSettingsPreferencesEntry({
    required super.key,
    required super.preferencesStorage,
  });

  @override
  Future<AppSettings?> get() async {
    final json = await preferencesStorage.getString(key);
    if (json == null) return null;
    return AppSettingsDto.fromJson(json).toEntity();
  }

  @override
  Future<void> remove() async => preferencesStorage.remove(key);

  @override
  Future<void> set(AppSettings value) async {
    final json = AppSettingsDto.fromEntity(value).toJson();
    return await preferencesStorage.setString(key, json);
  }
}
