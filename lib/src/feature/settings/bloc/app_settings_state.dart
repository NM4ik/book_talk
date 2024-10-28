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
  const _IdleAppSettingsState({required this.appSettings});

  final AppSettings? appSettings;

  @override
  int get hashCode => Object.hashAll([appSettings]);

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;

    return other is _IdleAppSettingsState && other.appSettings == appSettings;
  }

  @override
  String toString() => '_IdleAppSettingsState(appSettings: $appSettings)';
}

final class _LoadingAppSettingsState extends AppSettingsState {
  const _LoadingAppSettingsState();

  @override
  int get hashCode => super.hashCode;

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;
    return other is _LoadingAppSettingsState;
  }

  @override
  String toString() => '_LoadingAppSettingsState()';
}

final class _ErrorAppSettingsState extends AppSettingsState {
  const _ErrorAppSettingsState({required this.error});

  final Object error;

  @override
  int get hashCode => Object.hashAll([error]);

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;
    return other is _ErrorAppSettingsState && other.error == error;
  }

  @override
  String toString() => '_ErrorAppSettingsState(error: $error)';
}
