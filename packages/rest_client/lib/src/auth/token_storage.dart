import 'package:rest_client/src/auth/token.dart';

/// The AuthTokenStorage class is used to store and retrieve auth tokens.
abstract interface class AuthTokenStorage<T extends Token> {
  // Future<T> loadToken();

  Future<void> saveToken(Token token);

  Future<void> clearToken();

  Stream<T?> tokenStream();
}
