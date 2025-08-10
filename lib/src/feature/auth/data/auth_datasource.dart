import 'package:book_talk/src/common/rest_api/rest_api.dart';
import 'package:book_talk/src/feature/auth/model/auth_token.dart';

abstract interface class AuthDatasource {
  Future<AuthToken?> signInWithEmailAndPassword(String email, String password);

  // Future<void> signOut();
}

final class AuthDatasourceImpl implements AuthDatasource {
  const AuthDatasourceImpl({required RestClient restClient})
      : _restClient = restClient;

  final RestClient _restClient;

  @override
  Future<AuthToken?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final RestResponse response = await _restClient.post(
      path: 'auth/login',
      body: {'email': email, 'password': password},
    );

    if (response.data == null) return null;
    return AuthToken.fromJson(response.data!);
  }

  // @override
  // Future<void> signOut() async {
  //   return await Future.delayed(const Duration(seconds: 1));
  // }
}
