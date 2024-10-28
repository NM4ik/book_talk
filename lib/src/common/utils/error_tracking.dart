import 'package:book_talk/src/common/utils/logger.dart';
import 'package:flutter/widgets.dart';

// TODO(mikhailov): implement tracking remote system. (Sentry, GlitchTip, FirebaseCrash)
abstract final class ErrorTracking {
  static Future<void> trackError(
    Object error,
    StackTrace stackTrace,
  ) async {
    appLogger.logError(error, stackTrace);
  }

  static Future<void> trackFlutterError(FlutterErrorDetails details) async {
    appLogger.logFlutterError(details);
  }

  static bool trackPlatformDispatcherError(
    Object error,
    StackTrace stackTrace,
  ) {
    appLogger.logError(error, stackTrace);
    return true;
  }
}
