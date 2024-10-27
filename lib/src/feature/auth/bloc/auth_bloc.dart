import 'package:book_talk/src/feature/auth/data/auth_repository.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';
part 'auth_event.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(
    super.initialState, {
    required AuthRepository authRepository,
  }) : _authRepository = authRepository {
    on<AuthEvent>(
      (event, emitter) => switch (event) {
        _SignEmailPasswordAuthEvent() =>
          _onSignEmailPasswordEvent(event, emitter),
        _SignOutAuthEvent() => _onSignOutEvent(event, emitter),
      },
    );

    _authRepository.authStatus.map((status) => AuthState.idle(status)).listen(
      ($state) {
        if ($state != state) {
          print('state update state');
          emit($state);
        }
      },
    );
  }

  final AuthRepository _authRepository;

  Future<void> _onSignEmailPasswordEvent(
    _SignEmailPasswordAuthEvent event,
    Emitter<AuthState> emitter,
  ) async {
    emitter(AuthState.processing(state.authStatus));

    try {
      await _authRepository.signInWithEmailAndPassword(
        event.email,
        event.password,
      );
      emitter(AuthState.idle(AuthStatus.auth));
    } on Object catch (e, stackTrace) {
      emitter(AuthState.error(AuthStatus.unAuth, e));
      onError(e, stackTrace);
    }
  }

  Future<void> _onSignOutEvent(
    _SignOutAuthEvent event,
    Emitter<AuthState> emitter,
  ) async {
    emitter(AuthState.processing(state.authStatus));
    try {
      await _authRepository.signOut();
      emitter(AuthState.idle(AuthStatus.unAuth));
    } on Object catch (e, stackTrace) {
      emitter(AuthState.error(AuthStatus.unAuth, e));
      onError(e, stackTrace);
    }
  }

}
