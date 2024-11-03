part of 'account_bloc.dart';

sealed class AccountState {
  const AccountState({required this.user});

  const factory AccountState.idle({required User? user}) = _IdleAccountState;

  const factory AccountState.processing({required User? user}) =
      _ProcessingAccountState;

  const factory AccountState.error({
    required User? user,
    required Object error,
  }) = _ErrorAccountState;

  final User? user;
}

final class _IdleAccountState extends AccountState {
  const _IdleAccountState({required super.user});

  @override
  int get hashCode => Object.hashAll([user]);

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
  int get hashCode => Object.hashAll([user]);

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
  int get hashCode => Object.hashAll([user, error]);

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
