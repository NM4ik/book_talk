import 'package:rest_client/rest_client.dart';

/// The base interface for a REST client.
abstract interface class RestClient {
  /// Sends a POST request to the specified [path] with the given [body], [headers], [queryParameters], and [extra].
  Future<RestResponse> post({
    required String path,
    required Map<String, Object?> body,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
    Map<String, String>? extra,
  });

  Future<RestResponse> get({
    required String path,
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  });
}
