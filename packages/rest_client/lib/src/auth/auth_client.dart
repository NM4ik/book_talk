import 'package:dio/dio.dart';
import 'package:rest_client/rest_client.dart' show Token;

/// The authorization client which is used to validate and refresh tokens.
abstract interface class AuthorizationClient<T extends Token> {
  Future<bool> isAccessTokenValid(T token);

  Future<bool> isRefreshTokenValid(T token);

  Future<T> refresh(T token);
}

/// Thrown when token is not exists and can not be refreshed.
class RottenTokenException extends DioException {
  RottenTokenException({
    String? message,
    RequestOptions? requestOptions,
  }) : super(
          requestOptions: requestOptions ?? RequestOptions(),
          message: message ?? 'Token is not exists and can not be refreshed',
        );
}

/// Thrown when token is not exists and can not be refreshed.
class UnexpectedBehaviorException extends DioException {
  UnexpectedBehaviorException({
    String? message,
    RequestOptions? requestOptions,
    super.stackTrace,
  }) : super(
          requestOptions: requestOptions ?? RequestOptions(),
          message: message ??
              'The request could not be completed for an unknown reason.',
        );
}
