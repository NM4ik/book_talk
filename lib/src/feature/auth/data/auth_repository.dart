import 'dart:async';

import 'package:book_talk/src/feature/auth/data/auth_datasource.dart';
import 'package:book_talk/src/feature/auth/data/auth_storage.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:book_talk/src/feature/auth/model/auth_token.dart';

abstract interface class AuthRepository {
  /// Sign in with email and password
  Future<AuthToken?> signInWithEmailAndPassword(String email, String password);

  /// Sign out
  Future<void> signOut();

  /// Get current authStatus
  Stream<AuthStatus> get authStatus;
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthStorage authStorage,
    required AuthDatasource authDatasource,
  })  : _authStorage = authStorage,
        _authDatasource = authDatasource;

  final AuthStorage _authStorage;
  final AuthDatasource _authDatasource;

  @override
  Future<AuthToken?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final AuthToken? token = await _authDatasource.signInWithEmailAndPassword(
      email,
      password,
    );

    if (token != null) {
      await _authStorage.save(token);
    }

    return token;
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      // _authDatasource.signOut(),
      _authStorage.clear(),
    ]);
  }

  @override
  Stream<AuthStatus> get authStatus => _authStorage.authTokenStream.map(
        (token) => token != null ? AuthStatus.auth : AuthStatus.unAuth,
      );
}
