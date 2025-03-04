import 'dart:async';
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
    required this.excludedPaths,
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
  final List<String> excludedPaths;
  late final StreamSubscription<Token?> _tokenStreamSubscription;
  Token? _token;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    /// Skip interceptor if request should not be authenticated
    if (_isExcludedPath(options.uri.path)) {
      return super.onRequest(options, handler);
    }

    Future<void> clearRottenTokenReject() async {
      await _tokenStorage.clearToken();
      return handler.reject(
        RottenTokenException(requestOptions: options),
      );
    }

    final token = _token;

    /// If token is not exists and can not be refreshed
    if (token == null) {
      return await clearRottenTokenReject();
    }

    /// If access token is valid, submit request with token and inject it into headers
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
      } on Object catch (e, st) {
        return handler.reject(
          UnexpectedBehaviorException(message: e.toString(), stackTrace: st),
        );
      }
    }

    return await clearRottenTokenReject();
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    /// Skip interceptor if request should not be authenticated
    if (_isExcludedPath(err.requestOptions.path)) {
      return super.onError(err, handler);
    }

    Future<void> clearRottenTokenReject() async {
      await _tokenStorage.clearToken();
      return handler.reject(
        RottenTokenException(requestOptions: err.requestOptions),
      );
    }

    final statusCode = err.response?.statusCode;
    final isRetriedAttempt = err.requestOptions._isRetriedAttempt;

    /// If status code is 401 and it is second attempt then clear and reject.
    if (statusCode == 401 && isRetriedAttempt) {
      return await clearRottenTokenReject();
    }

    /// If status code is not 401 or it is second attempt then just follow up
    if (statusCode != 401 || isRetriedAttempt) {
      return handler.next(err);
    }

    final token = _token;

    /// If [token] is not exists and can not be refreshed
    if (token == null) {
      return await clearRottenTokenReject();
    }

    /// If refresh token is valid, refresh access token and retry request
    ///
    /// If token is not refreshable clear it and reject request
    if (await _authorizationClient.isRefreshTokenValid(token)) {
      try {
        final $token = await _authorizationClient.refresh(token);

        await _tokenStorage.saveToken($token);
        _token = $token;

        /// If token is different from current token then retry request
        final options = err.requestOptions._retry();
        final response = await retryRequest(_dio, options);

        return handler.resolve(response);
      } on RottenTokenException catch (e) {
        await _tokenStorage.clearToken();
        return handler.reject(e);
      } on DioException catch (e) {
        return handler.reject(e);
      } on Object catch (e, st) {
        return handler.reject(
          UnexpectedBehaviorException(message: e.toString(), stackTrace: st),
        );
      }
    } else {
      return clearRottenTokenReject();
    }
  }

  /// Build bearer authorization header with given [token].
  Map<String, String> _buildBearerHeader(Token token) => {
        'Authorization': 'Bearer ${token.accessToken}',
      };

  bool _isExcludedPath(String path) =>
      excludedPaths.any((ignorePath) => path.contains(ignorePath));

  void dispose() {
    _tokenStreamSubscription.cancel();
  }
}

extension on RequestOptions {
  static const _retryKey = 'retry_request';
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
