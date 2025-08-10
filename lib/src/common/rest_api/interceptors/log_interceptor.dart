import 'package:book_talk/common.dart';
import 'package:dio/dio.dart';

class LoggerInterceptor extends Interceptor {
  const LoggerInterceptor({required AppLogger appLogger})
      : _appLogger = appLogger;

  final AppLogger _appLogger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _appLogger.logMessage(
      'REQUEST: ${options.uri}\n'
      'Method: ${options.method}\n'
      'Body: ${options.data}\n'
      'QueryParams: ${options.queryParameters}\n'
      'Headers:\n'
      '${options.headers}\n',
    );
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    _appLogger.logOrange(
      'RESPONSE: ${response.realUri}\n'
      'Redirects: ${response.redirects.map((e) => e.location.path).toList()}\n'
      'Data: ${response.data}\n'
      'StatusCode: ${response.statusCode}\n'
      'Headers:\n'
      '${response.headers}\n',
    );

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _appLogger.logRed(
      '============ ERROR ============\n'
      'ERROR: ${err.requestOptions.uri.path}\n'
      'Data: ${err.response?.data}\n'
      'StatusCode: ${err.response?.statusCode}\n'
      'Headers:\n'
      '${err.response?.headers}\n'
      'Error: ${err.error}\n',
    );
    super.onError(err, handler);
  }
}
