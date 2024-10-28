part of 'account_bloc.dart';

sealed class AccountEvent {
  const AccountEvent();

  factory AccountEvent.load() => _LoadUserAccountEvent();
}

final class _LoadUserAccountEvent extends AccountEvent {
  const _LoadUserAccountEvent();

  @override
  String toString() => '_LoadUserAccountEvent()';
}
