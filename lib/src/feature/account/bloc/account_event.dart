part of 'account_bloc.dart';

sealed class AccountEvent {
  const AccountEvent();

  factory AccountEvent.load() => const _LoadEvent();

  factory AccountEvent.logout() => const _LogoutEvent();
}

final class _LoadEvent extends AccountEvent {
  const _LoadEvent();

  @override
  String toString() => '_LoadAccountEvent()';
}

final class _LogoutEvent extends AccountEvent {
  const _LogoutEvent();

  @override
  String toString() => '_LogoutEventAccountEvent()';
}
