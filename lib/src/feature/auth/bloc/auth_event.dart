part of 'auth_bloc.dart';

sealed class AuthEvent {
  const AuthEvent();

  factory AuthEvent.signEmailPassword(String email, String password) =>
      _SignEmailPasswordAuthEvent(
        email: email,
        password: password,
      );

  factory AuthEvent.signOut() => _SignOutAuthEvent();
}

final class _SignEmailPasswordAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const _SignEmailPasswordAuthEvent(
      {required this.email, required this.password});

  @override
  int get hashCode => email.hashCode ^ password.hashCode;

  @override
  bool operator ==(covariant _SignEmailPasswordAuthEvent other) {
    if (identical(this, other)) return true;
    return email == other.email && password == other.password;
  }
}

final class _SignOutAuthEvent extends AuthEvent {
  const _SignOutAuthEvent();
}
