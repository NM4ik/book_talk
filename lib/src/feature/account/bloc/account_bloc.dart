import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:book_talk/src/feature/account/data/user_repository.dart';
import 'package:book_talk/src/feature/account/model/user.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:meta/meta.dart';

part 'account_event.dart';
part 'account_state.dart';

final class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required Stream<AuthStatus> authStatusStream,
    required UserRepository userRepository,
  }) : _userRepository = userRepository,
       super(const AccountState.idle(user: null)) {
    on<AccountEvent>(
      (event, emitter) => switch (event) {
        _LoadEvent() => _onLoadEvent(event, emitter),
        _LogoutEvent() => _onLogoutEvent(event, emitter),
      },
    );

    _authStatusSub = authStatusStream.listen((status) {
      switch (status) {
        case AuthStatus.auth:
          add(AccountEvent.load());
        case AuthStatus.unAuth:
          add(AccountEvent.logout());
      }
    });
  }

  final UserRepository _userRepository;
  late final StreamSubscription<AuthStatus> _authStatusSub;

  Future<void> _onLoadEvent(
    _LoadEvent event,
    Emitter<AccountState> emitter,
  ) async {
    emitter(AccountState.processing(user: state.user));

    try {
      final userResponse = await _userRepository.fetchUser();
      emitter(AccountState.idle(user: userResponse));
    } on Object catch (error, st) {
      emitter(AccountState.error(user: state.user, error: error));
      onError(error, st);
    }
  }

  void _onLogoutEvent(_LogoutEvent event, Emitter<AccountState> emitter) {
    emitter(const AccountState.idle(user: null));
  }

  @override
  Future<void> close() async {
    await _authStatusSub.cancel();
    return super.close();
  }
}
