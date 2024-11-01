import 'package:flutter/src/foundation/assertions.dart';
import 'package:l/l.dart';

AppLogger get appLogger => _defaultAppLogger;
final _defaultAppLogger = DefaultAppLogger();

abstract class AppLogger {
  void logError(Object error, StackTrace stackTrace);

  void logMessage(String message);

  void logFlutterError(FlutterErrorDetails details);

  bool logPlatformDispatcherError(Object exception, StackTrace stackTrace);
}

final class DefaultAppLogger extends AppLogger {
  final L _logger = l;

  @override
  void logError(Object error, StackTrace stackTrace) {
    _logger.w(
      '$error'
      '\n'
      '[StackTrace]:\n$stackTrace',
    );
  }

  @override
  void logFlutterError(FlutterErrorDetails details) {
    _logger.w(
      'FlutterError: ${details.exception}'
      '\n'
      'StackTrace: ${details.stack}',
    );
  }

  @override
  void logMessage(String message) {
    _logger.i(message);
  }

  @override
  bool logPlatformDispatcherError(Object exception, StackTrace stackTrace) {
    _logger.w(
      'PlatformDispatcherError: ${exception}'
      '\n'
      'StackTrace: ${stackTrace}',
    );

    return true;
  }
}
