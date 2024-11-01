import 'package:uuid/uuid.dart';

abstract interface class AuthDatasource<T> {
  Future<T> signInWithEmailAndPassword(String email, String password);

  Future<void> signOut();
}

final class AuthDatasourceTemporaryImpl implements AuthDatasource<String> {
  @override
  Future<String> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await Future.delayed(
        const Duration(seconds: 1), () => const Uuid().v1());
  }

  @override
  Future<void> signOut() async {
    return await Future.delayed(const Duration(seconds: 1));
  }
}
