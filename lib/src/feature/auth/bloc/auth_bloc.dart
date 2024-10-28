import 'dart:async';

import 'package:book_talk/src/common/utils/mixins/bloc_state_mixin.dart';
import 'package:book_talk/src/feature/auth/data/auth_repository.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';
part 'auth_event.dart';

final class AuthBloc extends Bloc<AuthEvent, AuthState> with SetStateMixin {
  AuthBloc(
    String? token, {
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        _token = token,
        super(AuthState.idle(
            token != null ? AuthStatus.auth : AuthStatus.unAuth)) {
    on<AuthEvent>(
      (event, emitter) => switch (event) {
        _SignEmailPasswordAuthEvent() =>
          _onSignEmailPasswordEvent(event, emitter),
        _SignOutAuthEvent() => _onSignOutEvent(event, emitter),
      },
    );

    _authStatusSubscription = _authRepository.authStatus
        .map((status) => AuthState.idle(status))
        .listen(
      ($state) {
        if ($state != state) {
          setState($state);
        }
      },
    );
  }

  final AuthRepository _authRepository;
  final String? _token;
  StreamSubscription<AuthState>? _authStatusSubscription;

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

  String? get token => _token;

  @override
  Future<void> close() {
    _authStatusSubscription?.cancel();
    return super.close();
  }
}
