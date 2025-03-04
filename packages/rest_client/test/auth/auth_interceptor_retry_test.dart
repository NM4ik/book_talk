import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rest_client/src/auth/auth_client.dart';
import 'package:rest_client/src/auth/token.dart';
import 'package:rest_client/src/auth/token_storage.dart';
import 'package:rest_client/src/auth/auth_interceptor.dart';
import 'package:rest_client/src/utils/retry_request.dart';

class MockErrorInterceptorHandler extends Mock
    implements ErrorInterceptorHandler {}

class MockDio extends Mock implements Dio {}

class MockAuthorizationClient extends Mock
    implements AuthorizationClient<Token> {}

class MockTokenStorage extends Mock implements AuthTokenStorage<Token> {
  @override
  Stream<Token?> tokenStream() {
    return Stream.value(const Token(
      accessToken: 'valid_access',
      refreshToken: 'valid_refresh',
    ));
  }
}

class FakeResponse extends Fake implements Response<dynamic> {}

void main() {
  late MockDio dio;
  late MockAuthorizationClient authorizationClient;
  late MockTokenStorage tokenStorage;
  late AuthInterceptor authInterceptor;
  late Token validToken;
  late Token expiredToken;
  late ErrorInterceptorHandler errorHandler;
  late Response<dynamic> validResponse;

  setUp(() {
    dio = MockDio();
    authorizationClient = MockAuthorizationClient();
    tokenStorage = MockTokenStorage();
    errorHandler = MockErrorInterceptorHandler();
    validResponse = Response(requestOptions: RequestOptions());
    authInterceptor = AuthInterceptor(
      dio: dio,
      tokenStorage: tokenStorage,
      authorizationClient: authorizationClient,
      excludedPaths: ['auth/refresh', 'auth/login'],
    );

    registerFallbackValue(DioException(requestOptions: RequestOptions()));
    registerFallbackValue(Response<dynamic>);
    registerFallbackValue(FakeResponse());
    registerFallbackValue(RequestOptions());
    registerFallbackValue(const Token(accessToken: '', refreshToken: ''));

    validToken = const Token(
      accessToken: 'valid_access',
      refreshToken: 'valid_refresh',
    );
    expiredToken = const Token(
      accessToken: 'expired_access',
      refreshToken: 'expired_refresh',
    );

    registerFallbackValue(validToken);
    registerFallbackValue(expiredToken);
  });

  tearDown(() {
    authInterceptor.dispose();
  });

  group('AuthInterceptor retry tests', () {
    test('retryRequest should retry the request and return response', () async {
      when(() => dio.fetch(validResponse.requestOptions))
          .thenAnswer((_) async => Future.value(validResponse));
      final result = await retryRequest(dio, validResponse.requestOptions);

      expect(result, equals(validResponse));
      verify(() => dio.fetch(validResponse.requestOptions)).called(1);
    });

    test('retryRequest should throw DioException on failure', () async {
      final reqOpt = RequestOptions();
      when(() => dio.fetch(reqOpt)).thenThrow(
          DioException(requestOptions: reqOpt, type: DioExceptionType.unknown));

      expect(
        () async => retryRequest(dio, reqOpt),
        throwsA(isA<DioException>()),
      );
      verify(() => dio.fetch(reqOpt)).called(1);
    });

    test('should retry request after 401 with valid refresh token', () async {
      when(() => authorizationClient.isRefreshTokenValid(any()))
          .thenAnswer((_) async => true);
      when(() => authorizationClient.refresh(any()))
          .thenAnswer((_) async => validToken);
      when(() => tokenStorage.saveToken(any())).thenAnswer((_) async {});
      when(() => dio.fetch(any()))
          .thenAnswer((_) async => Future.value(validResponse));
      final dioException = DioException(
        requestOptions: validResponse.requestOptions,
        response: Response(
          statusCode: 401,
          requestOptions: validResponse.requestOptions,
        ),
      );

      await authInterceptor.onError(dioException, errorHandler);

      verify(() => errorHandler.resolve(any())).called(1);
    });

    test('should reject request if refresh token is invalid', () async {
      when(() => authorizationClient.isAccessTokenValid(any()))
          .thenAnswer((_) async => false);
      when(() => authorizationClient.isRefreshTokenValid(any()))
          .thenAnswer((_) async => false);
      when(() => tokenStorage.clearToken()).thenAnswer((_) async {});

      final requestOptions = RequestOptions(path: '/test', method: 'GET');
      final dioException = DioException(
        requestOptions: requestOptions,
        response: Response(
          statusCode: 401,
          headers: Headers.fromMap({
            'Authorization': ['Bearer ${validToken.accessToken}']
          }),
          requestOptions: requestOptions,
        ),
      );

      await authInterceptor.onError(dioException, errorHandler);
      verify(() => tokenStorage.clearToken()).called(1);
      verify(() => errorHandler.reject(any())).called(1);
    });
  });
}
