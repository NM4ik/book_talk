import 'package:book_talk/src/common/rest_api/auth/auth_refresh.dart';
import 'package:book_talk/src/feature/auth/model/auth_token.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:rest_client/rest_client.dart';

final class RestApiAuthorizationClient<T extends Token>
    implements AuthorizationClient<T> {
  RestApiAuthorizationClient({
    required AuthenticationRefreshRepository authenticationRefreshRepository,
  }) : _authenticationRefreshRepository = authenticationRefreshRepository;

  final AuthenticationRefreshRepository _authenticationRefreshRepository;

  @override
  Future<bool> isAccessTokenValid(T token) async {
    return _checkTokenValid(token.accessToken);
  }

  @override
  Future<bool> isRefreshTokenValid(T token) async {
    return _checkTokenValid(token.refreshToken);
  }

  @override
  Future<T> refresh(token) async {
    final AuthToken? authToken = await _authenticationRefreshRepository.refresh(
      AuthToken(
        accessToken: token.accessToken,
        refreshToken: token.refreshToken,
      ),
    );

    if (authToken == null) {
      throw RottenTokenException(
        message: 'Implementation of AuthorizationClient can not refresh token',
      );
    }

    return Token(
      accessToken: authToken.accessToken,
      refreshToken: authToken.refreshToken,
    ) as T;
  }

  bool _checkTokenValid(String token) {
    final JWT? jwt = JWT.tryDecode(token);
    final Object? exp = jwt?.payload['exp'];

    if (exp is! int) return false;

    final tokenExpiredDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
    return tokenExpiredDate.isAfter(DateTime.now());
  }
}
