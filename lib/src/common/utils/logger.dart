import 'package:flutter/src/foundation/assertions.dart';
import 'package:l/l.dart';

/// Provides a logging interface for different types of logs in the app.
///
/// The default implementation is [DefaultAppLogger], which uses an underlying
/// logger instance (e.g., `l`) to log messages to an external log provider.
AppLogger get appLogger => _defaultAppLogger;
final _defaultAppLogger = DefaultAppLogger();

/// Abstract class for logging in the app.
///
/// [AppLogger] defines methods for logging errors, messages, Flutter-specific
/// errors, and platform dispatcher errors. This is intended to standardize
/// logging practices across the app, allowing easy debugging and error tracking.
abstract class AppLogger {
  /// Logs an error with the provided [error] and [stackTrace].
  void logError(Object error, StackTrace stackTrace);

  /// Logs a general message.
  void logMessage(String message);

  /// Logs Flutter-specific error details.
  void logFlutterError(FlutterErrorDetails details);

  /// Logs platform dispatcher errors.
  bool logPlatformDispatcherError(Object exception, StackTrace stackTrace);
}

/// Default implementation of [AppLogger] that logs messages using a logger.
final class DefaultAppLogger extends AppLogger {
  final L _logger = l; // Underlying logger instance.

  @override
  void logError(Object error, StackTrace stackTrace) {
    _logger.e(
      '$error'
      '\n'
      '[StackTrace]:\n$stackTrace',
    );
  }

  @override
  void logFlutterError(FlutterErrorDetails details) {
    _logger.e(
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
    _logger.e(
      'PlatformDispatcherError: ${exception}'
      '\n'
      'StackTrace: ${stackTrace}',
    );

    return true;
  }
}
