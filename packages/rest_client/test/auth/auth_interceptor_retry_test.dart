import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rest_client/src/auth/auth_client.dart';
import 'package:rest_client/src/auth/token.dart';
import 'package:rest_client/src/auth/token_storage.dart';
import 'package:rest_client/src/auth/auth_interceptor.dart';
import 'package:rest_client/src/utils/retry_request.dart';

// Ensure mock class is set up correctly
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

  setUp(() {
    dio = MockDio();
    authorizationClient = MockAuthorizationClient();
    tokenStorage = MockTokenStorage();
    errorHandler = MockErrorInterceptorHandler();
    authInterceptor = AuthInterceptor(
      dio: dio,
      tokenStorage: tokenStorage,
      authorizationClient: authorizationClient,
    );

    registerFallbackValue(DioException(requestOptions: RequestOptions()));
    registerFallbackValue(Response<dynamic>);
    registerFallbackValue(FakeResponse());
    registerFallbackValue(RequestOptions());

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
      final reqOpt = RequestOptions();
      final validResponse = Response(requestOptions: reqOpt);
      when(() => dio.fetch(reqOpt))
          .thenAnswer((_) async => Future.value(validResponse));
      final result = await retryRequest(dio, reqOpt);

      expect(result, equals(validResponse));
      verify(() => dio.fetch(reqOpt)).called(1);
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
      final requestOptions = RequestOptions();
      final validResponse = Response(requestOptions: RequestOptions());
      when(() => authorizationClient.isAccessTokenValid(expiredToken))
          .thenAnswer((_) async => false);
      when(() => authorizationClient.isRefreshTokenValid(expiredToken))
          .thenAnswer((_) async => true);
      when(() => dio.fetch(any()))
          .thenAnswer((_) async => Future.value(validResponse));
      when(() => authorizationClient.refresh(expiredToken))
          .thenAnswer((_) async => validToken);
      final dioException = DioException(
        requestOptions: requestOptions,
        response: Response(statusCode: 401, requestOptions: requestOptions),
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

    test('should not retry if token is different in headers', () async {
      // Мокаем ситуацию, когда токен в заголовке отличается от текущего
      when(() => authorizationClient.isAccessTokenValid(expiredToken))
          .thenAnswer((_) async => false);
      when(() => authorizationClient.isRefreshTokenValid(expiredToken))
          .thenAnswer((_) async => true);

      final requestOptions = RequestOptions(
        path: '/test',
        method: 'GET',
        headers: {'Authorization': 'Bearer different_token'},
      );
      when(() => dio.fetch(any())).thenAnswer(
          (_) async => Future.value(Response(requestOptions: requestOptions)));

      final dioException = DioException(
        requestOptions: requestOptions,
        response: Response(
          statusCode: 401,
          requestOptions: RequestOptions(),
          headers: Headers.fromMap({
            'Authorization': ['Bearer different_token']
          }),
        ),
      );

      await authInterceptor.onError(dioException, errorHandler);
      verify(() => errorHandler.resolve(any())).called(1);
    });
  });
}
