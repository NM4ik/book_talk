part of 'app_settings_bloc.dart';

sealed class AppSettingsState {
  const AppSettingsState();

  factory AppSettingsState.idle(AppSettings? appSettings) =>
      _IdleAppSettingsState(appSettings: appSettings);

  factory AppSettingsState.loading() => _LoadingAppSettingsState();

  factory AppSettingsState.error(Object error) =>
      _ErrorAppSettingsState(error: error);

  AppSettings? get settings => switch (this) {
        _IdleAppSettingsState() => (this as _IdleAppSettingsState).appSettings,
        _LoadingAppSettingsState() => null,
        _ErrorAppSettingsState() => null,
      };
}

final class _IdleAppSettingsState extends AppSettingsState {
  final AppSettings? appSettings;

  const _IdleAppSettingsState({required this.appSettings});

  @override
  bool operator ==(covariant _IdleAppSettingsState other) {
    if (identical(this, other)) return true;

    return other.appSettings == appSettings;
  }

  @override
  int get hashCode => appSettings.hashCode;

  @override
  String toString() => '_IdleAppSettingsState(appSettings: $appSettings)';
}

final class _LoadingAppSettingsState extends AppSettingsState {
  @override
  String toString() => '_LoadingAppSettingsState()';
}

final class _ErrorAppSettingsState extends AppSettingsState {
  final Object error;

  const _ErrorAppSettingsState({required this.error});

  @override
  bool operator ==(covariant _ErrorAppSettingsState other) {
    if (identical(this, other)) return true;

    return other.error == error;
  }

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => '_ErrorAppSettingsState(error: $error)';
}
