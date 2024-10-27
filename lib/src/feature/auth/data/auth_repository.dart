import 'package:book_talk/src/feature/auth/data/auth_datasource.dart';
import 'package:book_talk/src/feature/auth/data/auth_storage.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';

abstract interface class AuthRepository<T> {
  /// Sign in with email and password
  Future<T> signInWithEmailAndPassword(String email, String password);

  /// Sign out
  Future<void> signOut();

  /// Get current authStatus
  Stream<AuthStatus> get authStatus;
}

class AuthRepositoryImpl<T> implements AuthRepository<T> {
  final AuthStorage<T> _authStorage;
  final AuthDatasource<T> _authDatasource;

  const AuthRepositoryImpl({
    required AuthStorage<T> authStorage,
    required AuthDatasource<T> authDatasource,
  })  : _authStorage = authStorage,
        _authDatasource = authDatasource;

  @override
  Future<T> signInWithEmailAndPassword(String email, String password) async {
    final token = await _authDatasource.signInWithEmailAndPassword(
      email,
      password,
    );
    _authStorage.save(token);
    return token;
  }

  @override
  Future<void> signOut() async {
    await Future.wait([
      _authDatasource.signOut(),
      _authStorage.clear(),
    ]);
  }

  @override
  Stream<AuthStatus> get authStatus => _authStorage.authStream().map(
        (token) => token != null ? AuthStatus.auth : AuthStatus.unAuth,
      );
}
