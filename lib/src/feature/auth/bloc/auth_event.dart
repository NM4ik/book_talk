part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();

  factory AuthEvent.signEmailPassword(String email, String password) =>
      _SignEmailPasswordAuthEvent(email: email, password: password);

  factory AuthEvent.signOut() => const _SignOutAuthEvent();
}

final class _SignEmailPasswordAuthEvent extends AuthEvent {
  const _SignEmailPasswordAuthEvent({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;
}

final class _SignOutAuthEvent extends AuthEvent {
  const _SignOutAuthEvent();
}
