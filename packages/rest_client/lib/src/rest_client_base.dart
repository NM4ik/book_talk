import 'dart:convert';

import 'package:rest_client/src/exception/rest_client_exception.dart';
import 'package:rest_client/src/rest_client.dart';
import 'package:rest_client/src/rest_response.dart';

/// The methods supported by a REST client.
enum RestClientMethod { post, $get }

/// The base interface for a REST client.
abstract class RestClientBase implements RestClient {
  Future<RestResponse> send({
    required String path,
    required RestClientMethod method,
    Map<String, Object?>? body,
    Map<String, Object?>? headers,
    Map<String, Object?>? queryParameters,
    Map<String, dynamic>? extra,
  });

  @override
  Future<RestResponse> post({
    required String path,
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, String>? extra,
  }) =>
      send(
        path: path,
        method: RestClientMethod.post,
        headers: headers,
        queryParameters: queryParameters,
        body: body,
        extra: extra,
      );

  @override
  Future<RestResponse> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) =>
      send(
        path: path,
        method: RestClientMethod.$get,
        headers: headers,
        queryParameters: queryParameters,
      );

  /// Encodes the request body to JSON.
  String encodeBody(Map<String, Object?> body) {
    try {
      return jsonEncode(body);
    } on Object catch (e, st) {
      Error.throwWithStackTrace(
        ClientException(
          message: 'Error occurred during encoding request body',
          cause: e,
        ),
        st,
      );
    }
  }

  /// Decodes the response body from JSON.
  Map<String, Object?>? decodeResponse(Object? response) {
    if (response == null) return null;
    if (response is Map<String, Object?>) return response;

    throw const ClientException(
      message: 'Error occurred during decoding response. '
          'Unexpected response type',
      cause: 'Map<String, Object?>? decodeResponse',
    );
  }
}
