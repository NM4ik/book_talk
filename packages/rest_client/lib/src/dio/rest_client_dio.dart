import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rest_client/rest_client.dart';
import 'package:rest_client/src/exception/rest_client_exception.dart';
import 'package:rest_client/src/rest_client_base.dart';
import 'package:rest_client/src/utils/extract_extension.dart';

/// The implementation of [RestClient] using [Dio].
class RestClientDio extends RestClientBase {
  RestClientDio({
    required String baseUrl,
    required this.headers,
    Dio? dio,
  }) : _dioClient = dio ?? Dio(BaseOptions(baseUrl: baseUrl));

  final Dio _dioClient;
  final Map<String, Object?> headers;

  @override
  Future<RestResponse> send({
    required String path,
    required RestClientMethod method,
    Map<String, Object?>? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParameters,
    Map<String, dynamic>? extra,
  }) async {
    try {
      final Map<String, Object?> $headers = this.headers;
      if (headers != null) {
        $headers.addAll(headers);
      }

      Object? requestData;
      if (body != null) {
        requestData = encodeBody(body);
        $headers[Headers.contentTypeHeader] = Headers.jsonContentType;
      }

      Response? response;
      try {
        response = switch (method) {
          RestClientMethod.post => await _dioClient.post(
              path,
              data: requestData,
              queryParameters: queryParameters,
              options: Options(
                headers: $headers,
                extra: extra,
                method: 'POST',
              ),
            ),
          RestClientMethod.$get => await _dioClient.get(
              path,
              data: requestData,
              queryParameters: queryParameters,
              options: Options(
                headers: $headers,
                extra: extra,
                method: 'GET',
              ),
            ),
        };
      } on DioException catch (e) {
        // TODO(Mikhailov): handle errors
        response = e.response;
        log('DIO RESPONSE = ${response?.data}, error: ${e.message}');
      }

      final Map<String, Object?>? decodedBody = decodeResponse(response?.data);
      return RestResponse(
        statusCode: response?.statusCode,
        success: decodedBody?['success'] == true,
        message: decodedBody?['message']?.toString(),
        data: decodedBody?['data']?.safeExtract,
        errorDescription: decodedBody?['errorsDescription']?.safeExtract,
      );
    } on RestClientException {
      rethrow;
    } on Object catch (e, stackTrace) {
      Error.throwWithStackTrace(
        ClientException(
          message: 'RestClientDio.send unexpected behaviour',
          cause: e,
        ),
        stackTrace,
      );
    }
  }

  void injectAuthenticationInterceptor({
    required AuthTokenStorage<Token> tokenStorage,
    required AuthorizationClient<Token> authorizationClient,
    required List<String> excludedPaths,
  }) {
    _dioClient.interceptors.add(
      AuthInterceptor(
        dio: _dioClient,
        tokenStorage: tokenStorage,
        authorizationClient: authorizationClient,
        excludedPaths: excludedPaths,
      ),
    );
  }

  void injectInterceptor({required Interceptor interceptor}) {
    _dioClient.interceptors.add(interceptor);
  }
}
