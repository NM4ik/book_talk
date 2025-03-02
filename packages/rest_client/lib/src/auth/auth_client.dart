import 'package:dio/dio.dart';

/// The authorization client which is used to validate and refresh tokens.
abstract interface class AuthorizationClient<T> {
  Future<bool> isAccessTokenValid(T token);

  Future<bool> isRefreshTokenValid(T token);

  Future<T> refresh(T token);
}

/// Thrown when token is not exists and can not be refreshed.
class RottenTokenException extends DioException {
  RottenTokenException({String? message})
      : super(
          requestOptions: RequestOptions(),
          message: message ?? 'Token is not exists and can not be refreshed',
        );
}
