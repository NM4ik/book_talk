import 'package:book_talk/src/feature/auth/data/auth_storage.dart';
import 'package:book_talk/src/feature/auth/model/auth_token.dart';
import 'package:rest_client/rest_client.dart';

final class RestApiAuthStorage implements AuthTokenStorage {
  const RestApiAuthStorage({required AuthStorage authStorage})
      : _authStorage = authStorage;

  final AuthStorage _authStorage;

  @override
  Future<void> clearToken() async {
    await _authStorage.clear();
  }

  @override
  Future<void> saveToken(Token token) async {
    await _authStorage.save(
      AuthToken(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      ),
    );
  }

  @override
  Stream<Token?> tokenStream() {
    return _authStorage.authTokenStream.map(
      (token) => token == null
          ? null
          : Token(
              accessToken: token.accessToken,
              refreshToken: token.refreshToken,
            ),
    );
  }
}
