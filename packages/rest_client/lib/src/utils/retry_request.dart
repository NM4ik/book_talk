import 'package:dio/dio.dart' show Dio, RequestOptions, Response;

/// Retries the request with the specified options.
Future<Response<dynamic>> retryRequest(
  Dio dio,
  RequestOptions options,
) async {
  return await dio.fetch(options);
}
