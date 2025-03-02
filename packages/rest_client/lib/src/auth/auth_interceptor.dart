import 'dart:async';
import 'dart:developer' show log;
import 'package:dio/dio.dart';
import 'package:rest_client/src/auth/auth_client.dart';
import 'package:rest_client/src/auth/token.dart';
import 'package:rest_client/src/auth/token_storage.dart';
import 'package:rest_client/src/utils/retry_request.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required Dio dio,
    required AuthTokenStorage<Token> tokenStorage,
    required AuthorizationClient<Token> authorizationClient,
  })  : _tokenStorage = tokenStorage,
        _dio = dio,
        _authorizationClient = authorizationClient {
    _tokenStreamSubscription = tokenStorage.tokenStream().listen((token) {
      _token = token;
    });
  }

  final Dio _dio;
  final AuthTokenStorage<Token> _tokenStorage;
  final AuthorizationClient<Token> _authorizationClient;
  late final StreamSubscription<Token?> _tokenStreamSubscription;
  Token? _token;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    /// Skip interceptor if request should not be authenticated
    if (options._skipAuth) {
      return super.onRequest(options, handler);
    }

    final token = _token;

    /// If token is not exists and can not be refreshed
    if (token == null) {
      log('token is null ');

      await _tokenStorage.clearToken();
      return handler.reject(
        RottenTokenException(
          message: 'Token is not exists and can not be refreshed',
        ),
      );
    }

    /// If access token is valid, submit request with token and inject it to headers
    if (await _authorizationClient.isAccessTokenValid(token)) {
      final headers = _buildBearerHeader(token);
      options.headers.addAll(headers);
      return handler.next(options);
    }

    /// If refresh token is valid, refresh token and retry request
    if (await _authorizationClient.isRefreshTokenValid(token)) {
      try {
        final $token = await _authorizationClient.refresh(token);
        await _tokenStorage.saveToken($token);
        final headers = _buildBearerHeader($token);
        options.headers.addAll(headers);
        return handler.next(options);
      } on RottenTokenException catch (e) {
        await _tokenStorage.clearToken();
        return handler.reject(e);
      } on DioException catch (e) {
        return handler.reject(e);
      } on Object {
        rethrow;
      }
    }

    /// If token is not refreshable clear it and reject request
    await _tokenStorage.clearToken();
    return handler.reject(RottenTokenException(
        message: 'Token is not exists and can not be refreshed'));
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    /// Skip interceptor if error is not related to authentication
    /// or if request was already retried
    ///
    /// Todo(mikhailov): think about _isRetriedAttempt, it is needed?
    ///
    if (err.response?.statusCode != 401 ||
        err.requestOptions._isRetriedAttempt) {
      return handler.next(err);
    }

    final token = _token;

    /// If current token is not exists and can not be refreshed
    if (token == null) {
      return handler.reject(RottenTokenException());
    }

    final tokenFromHeaders = _extractTokenFromHeaders(err.response?.headers);

    /// If token from headers is equal to current token try to refresh it
    if (tokenFromHeaders == token.accessToken) {
      /// If refresh token is valid, refresh token and retry request
      if (await _authorizationClient.isRefreshTokenValid(token)) {
        try {
          final $token = await _authorizationClient.refresh(token);
          await _tokenStorage.saveToken($token);
          _token = $token;
        } on RottenTokenException catch (e) {
          await _tokenStorage.clearToken();
          return handler.reject(e);
        } on Object {
          rethrow;
        }
      } else {
        /// If token is not refreshable clear it and reject request
        await _tokenStorage.clearToken();
        return handler.reject(RottenTokenException());
      }
    }

    /// If token is different from current token then retry request
    final options = err.requestOptions._retry();
    final response = await retryRequest(_dio, options);
    handler.resolve(response);
  }

  /// Build bearer authorization header with given [token].
  Map<String, String> _buildBearerHeader(Token token) => {
        'Authorization': 'Bearer ${token.accessToken}',
      };

  /// Extract token from response with given [headers].
  String? _extractTokenFromHeaders(Headers? headers) {
    final bearer = headers?.value('Authorization');
    if (bearer is! String || !bearer.startsWith('Bearer ')) return null;

    return bearer.substring(7);
  }

  void dispose() {
    _tokenStreamSubscription.cancel();
  }
}

extension on RequestOptions {
  static const _retryKey = 'retry_request';
  static const _skipAuthKey = 'skip_auth';

  bool get _skipAuth => extra[_skipAuthKey] == true;
  bool get _isRetriedAttempt => extra[_retryKey] == true;

  RequestOptions _retry() {
    return copyWith(
      extra: {
        _retryKey: true,
        ...extra,
      },
    );
  }
}
