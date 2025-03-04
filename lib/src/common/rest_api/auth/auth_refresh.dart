import 'package:book_talk/src/common/rest_api/rest_api.dart';
import 'package:book_talk/src/feature/auth/model/auth_token.dart';

abstract interface class AuthenticationRefreshRepository {
  Future<AuthToken?> refresh(AuthToken token);
}

final class AuthenticationRefreshRepositoryImpl
    implements AuthenticationRefreshRepository {
  const AuthenticationRefreshRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  final RestClient _restClient;

  @override
  Future<AuthToken?> refresh(AuthToken token) async {
    final RestResponse response = await _restClient.get(
        path: 'auth/refresh', headers: {'Refresh-Token': token.refreshToken});

    final Map<String, Object?>? responseData = response.data;
    if (responseData == null) return null;

    return AuthToken.fromJson(responseData);
  }
}
