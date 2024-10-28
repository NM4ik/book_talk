import 'package:book_talk/src/feature/account/data/user_repository.dart';
import 'package:book_talk/src/feature/account/model/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_event.dart';
part 'account_state.dart';

final class AccountBloc extends Bloc<AccountEvent, AccountState> {
  AccountBloc({
    required UserRepository userRepository,
    required String token,
  })  : _token = token,
        _userRepository = userRepository,
        super(AccountState.idle(null)) {
    on<AccountEvent>(
      (event, emitter) => switch (event) {
        _LoadUserAccountEvent() => _onLoadEvent(event, emitter),
      },
    );
  }

  final UserRepository _userRepository;
  final String _token;

  Future<void> _onLoadEvent(
    _LoadUserAccountEvent event,
    Emitter<AccountState> emitter,
  ) async {
    emitter(AccountState.processing(state.user));

    try {
      final userResponse = await _userRepository.fetchUser(_token);
      emitter(AccountState.idle(userResponse));
    } on Object catch (error) {
      emitter(AccountState.error(state.user, error));

      // TODO(mikhailov): Подумать на счет HTTPexcp.
      rethrow;
    }
  }

  Stream<User?> get userStream => _userRepository.userStream;
}
