import 'dart:async';

import 'package:book_talk/src/feature/account/data/user_repository.dart';
import 'package:book_talk/src/feature/account/model/user.dart';
import 'package:book_talk/src/feature/auth/data/auth_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

final class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required AuthStorage authStorage,
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        _authStorage = authStorage,
        super(const AccountState.idle(user: null)) {
    on<AccountEvent>(
      (event, emitter) => switch (event) {
        _LoadUserAccountEvent() => _onLoadEvent(event, emitter),
      },
    );

    _authStatusSubscription = _authStorage.authStream.listen((_) {
      add(AccountEvent.load());
    });
  }

  final UserRepository _userRepository;
  final AuthStorage _authStorage;
  StreamSubscription? _authStatusSubscription;

  Future<void> _onLoadEvent(
    _LoadUserAccountEvent event,
    Emitter<AccountState> emitter,
  ) async {
    emitter(AccountState.processing(user: state.user));

    try {
      final token = await _authStorage.get();
      if (token == null) {
        return emitter(const AccountState.idle(user: null));
      }

      final userResponse = await _userRepository.fetchUser(token);
      emitter(AccountState.idle(user: userResponse));

      // TODO(mikhailov): handle repository exceptions.
    } on Object catch (error, st) {
      emitter(AccountState.error(user: state.user, error: error));
      onError(error, st);
    }
  }

  @override
  Future<void> close() async {
    _authStatusSubscription?.cancel();

    return super.close();
  }

  Stream<User?> get userStream => _userRepository.userStream;
}
