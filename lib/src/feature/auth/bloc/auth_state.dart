part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState({required this.authStatus});

  final AuthStatus authStatus;

  factory AuthState.idle(AuthStatus authStatus) =>
      _IdleAuthState(authStatus: authStatus);

  factory AuthState.processing(AuthStatus authStatus) =>
      _ProcessingAuthState(authStatus: authStatus);

  factory AuthState.error(AuthStatus authStatus, Object error) =>
      _ErrorAuthState(authStatus: authStatus, error: error);

  bool get isLoading => switch (this) {
        _ProcessingAuthState() => true,
        _ => false,
      };
}

final class _IdleAuthState extends AuthState {
  const _IdleAuthState({required super.authStatus});

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;

    return other is _IdleAuthState && other.authStatus == authStatus;
  }

  @override
  int get hashCode => Object.hashAll([authStatus]);

  @override
  String toString() => '_IdleAuthState(authStatus: $authStatus)';
}

final class _ProcessingAuthState extends AuthState {
  const _ProcessingAuthState({required super.authStatus});

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;
    return other is _ProcessingAuthState && other.authStatus == authStatus;
  }

  @override
  int get hashCode => Object.hashAll([authStatus]);

  @override
  String toString() => '_ProcessingAuthState(authStatus: $authStatus)';
}

final class _ErrorAuthState extends AuthState {
  const _ErrorAuthState({
    required super.authStatus,
    required this.error,
  });

  final Object error;

  @override
  int get hashCode => Object.hashAll([authStatus, error]);

  @override
  bool operator ==(covariant Object other) {
    if (identical(this, other)) return true;

    return other is _ErrorAuthState &&
        authStatus == other.authStatus &&
        error == other.error;
  }
}
