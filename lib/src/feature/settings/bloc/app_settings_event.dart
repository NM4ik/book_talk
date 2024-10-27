part of 'app_settings_bloc.dart';

sealed class AppSettingsEvent {
  const AppSettingsEvent();

  factory AppSettingsEvent.update(AppSettings appSettings) =>
      _UpdateAppSettingsEvent(appSettings: appSettings);
}

final class _UpdateAppSettingsEvent extends AppSettingsEvent {
  final AppSettings appSettings;

  const _UpdateAppSettingsEvent({required this.appSettings});
}
