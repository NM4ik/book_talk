import 'dart:async';

import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rest_client/src/auth/auth_client.dart';
import 'package:rest_client/src/auth/token.dart';
import 'package:rest_client/src/auth/token_storage.dart';
import 'package:rest_client/src/auth/auth_interceptor.dart';

class MockDio extends Mock implements Dio {}

class MockAuthTokenStorage extends Mock implements AuthTokenStorage<Token> {}

class MockAuthorizationClient extends Mock
    implements AuthorizationClient<Token> {}

class MockRequestOptions extends Mock implements RequestOptions {}

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockRequestInterceptorHandler extends Mock
    implements RequestInterceptorHandler {}

void main() {
  late Dio dio;
  late MockAuthTokenStorage tokenStorage;
  late MockAuthorizationClient authorizationClient;
  late AuthInterceptor authInterceptor;
  late StreamController<Token?> tokenStreamController;

  setUp(() {
    dio = MockDio();
    tokenStorage = MockAuthTokenStorage();
    authorizationClient = MockAuthorizationClient();
    tokenStreamController = StreamController<Token?>();

    when(() => tokenStorage.tokenStream())
        .thenAnswer((_) => tokenStreamController.stream);
    registerFallbackValue(RottenTokenException());

    authInterceptor = AuthInterceptor(
      dio: dio,
      tokenStorage: tokenStorage,
      authorizationClient: authorizationClient,
      excludedPaths: [
        'auth/refresh',
        'auth/login',
      ],
    );
  });

  tearDown(() async {
    authInterceptor.dispose();
    await tokenStreamController.close();
  });

  test('Should add Authorization header if token is valid', () async {
    const token = Token(
      accessToken: 'valid_access',
      refreshToken: 'valid_refresh',
    );
    tokenStreamController.add(token);

    when(() => authorizationClient.isAccessTokenValid(token))
        .thenAnswer((_) async => true);

    final requestOptions = RequestOptions(path: '/test');
    final handler = RequestInterceptorHandler();

    await pumpEventQueue();

    await authInterceptor.onRequest(requestOptions, handler);

    expect(requestOptions.headers['Authorization'], 'Bearer valid_access');
  });

  test('Should refresh token if access token is expired', () async {
    const oldToken =
        Token(accessToken: 'expired_access', refreshToken: 'valid_refresh');
    const newToken =
        Token(accessToken: 'new_access', refreshToken: 'new_refresh');
    tokenStreamController.add(oldToken);
    when(() => authorizationClient.isAccessTokenValid(oldToken))
        .thenAnswer((_) async => false);
    when(() => authorizationClient.isRefreshTokenValid(oldToken))
        .thenAnswer((_) async => true);
    when(() => authorizationClient.refresh(oldToken))
        .thenAnswer((_) async => newToken);
    when(() => tokenStorage.saveToken(newToken)).thenAnswer((_) async {});

    final requestOptions = RequestOptions(path: '/test');
    final handler = RequestInterceptorHandler();

    await pumpEventQueue();

    await authInterceptor.onRequest(requestOptions, handler);

    expect(requestOptions.headers['Authorization'], 'Bearer new_access');
  });

  test('Should reject request if token cannot be refreshed', () async {
    const expiredToken =
        Token(accessToken: 'expired_access', refreshToken: 'expired_refresh');

    // Add the expired token to the stream controller
    tokenStreamController.add(expiredToken);

    // Mock the responses for token validation and storage clearing
    when(() => authorizationClient.isAccessTokenValid(expiredToken))
        .thenAnswer((_) async => false);
    when(() => authorizationClient.isRefreshTokenValid(expiredToken))
        .thenAnswer((_) async => false);
    when(() => tokenStorage.clearToken()).thenAnswer((_) async {});

    // Create the request options and the handler for interceptors
    final requestOptions = RequestOptions(path: '/test');
    final handler = MockRequestInterceptorHandler();

    // Execute the interceptor on the request
    await authInterceptor.onRequest(requestOptions, handler);

    // Pump the event queue to allow async operations to complete
    await pumpEventQueue();

    // Verify that token storage's clearToken method was called
    verify(() => tokenStorage.clearToken()).called(1);
  });

  test('should not modify request for excluded path', () async {
    final requestOptions = RequestOptions(path: 'auth/login1');
    final handler = MockRequestInterceptorHandler();

    await authInterceptor.onRequest(requestOptions, handler);

    verify(() => handler.next(requestOptions)).called(1);
  });

  test('should not retry request for excluded path on error', () async {
    final requestOptions = RequestOptions(path: 'auth/refresh');
    final dioException = DioException(
      requestOptions: requestOptions,
      response: Response(statusCode: 401, requestOptions: requestOptions),
    );
    final errorHandler = MockErrorInterceptorHandler();

    await authInterceptor.onError(dioException, errorHandler);

    verify(() => errorHandler.next(dioException)).called(1);
  });
}
