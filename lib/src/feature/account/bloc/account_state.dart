part of 'account_bloc.dart';

sealed class AccountState {
  const AccountState({required this.user});
  final User? user;

  factory AccountState.idle(User? user) => _IdleAccountState(user: user);

  factory AccountState.processing(User? user) =>
      _ProcessingAccountState(user: user);

  factory AccountState.error(User? user, Object error) =>
      _ErrorAccountState(user: user, error: error);
}

final class _IdleAccountState extends AccountState {
  const _IdleAccountState({required super.user});

  @override
  int get hashCode => user.hashCode;

  @override
  bool operator ==(covariant Object other) {
    if (identical(other, this)) return true;
    return other is _IdleAccountState && other.user == user;
  }

  @override
  String toString() => '_IdleAccountState(user: $user)';
}

final class _ProcessingAccountState extends AccountState {
  const _ProcessingAccountState({required super.user});

  @override
  int get hashCode => user.hashCode;

  @override
  bool operator ==(covariant Object other) {
    if (identical(other, this)) return true;
    return other is _ProcessingAccountState && other.user == user;
  }

  @override
  String toString() => '_ProcessingAccountState(user: $user)';
}

final class _ErrorAccountState extends AccountState {
  const _ErrorAccountState({required super.user, required this.error});

  final Object error;

  @override
  int get hashCode => Object.hashAll([user.hashCode, error.hashCode]);

  @override
  bool operator ==(covariant Object other) {
    if (identical(other, this)) return true;
    return other is _ErrorAccountState &&
        other.user == user &&
        error == other.error;
  }

  @override
  String toString() => '_ErrorAccountState(user: $user)';
}
