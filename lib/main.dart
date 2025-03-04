import 'dart:async';

import 'package:book_talk/src/common/utils/error_tracking.dart';
import 'package:book_talk/src/feature/bootstrap/logic/app_bootstrap.dart';

/// Entry point of the application.
///
/// Initializes the app within a `runZonedGuarded` zone to capture
/// uncaught errors and send them to the error tracking service.
void main() => runZonedGuarded(
      () => AppBootstrap().initializeApp(),
      (error, stackTrace) => ErrorTracking.trackError(error, stackTrace),
    );
