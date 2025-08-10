part of 'app_settings_bloc.dart';

@immutable
sealed class AppSettingsState {
  const AppSettingsState();

  const factory AppSettingsState.idle({required AppSettings? appSettings}) =
      _IdleAppSettingsState;

  const factory AppSettingsState.loading() = _LoadingAppSettingsState;

  const factory AppSettingsState.error({required Object error}) =
      _ErrorAppSettingsState;

  AppSettings? get settings => switch (this) {
    _IdleAppSettingsState() => (this as _IdleAppSettingsState).appSettings,
    _LoadingAppSettingsState() => null,
    _ErrorAppSettingsState() => null,
  };

  bool get isLoading => switch (this) {
    _LoadingAppSettingsState() => true,
    _ => false,
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
}

final class _ErrorAppSettingsState extends AppSettingsState {
  const _ErrorAppSettingsState({required this.error});

  final Object error;

  @override
  String toString() => '_ErrorAppSettingsState(error: $error)';
}
