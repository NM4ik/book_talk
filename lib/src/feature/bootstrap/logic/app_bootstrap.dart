import 'package:book_talk/src/common/constants/config.dart';
import 'package:book_talk/src/common/utils/app_bloc_observer.dart';
import 'package:book_talk/src/common/utils/error_tracking.dart';
import 'package:book_talk/src/common/utils/logger.dart';
import 'package:book_talk/src/common/utils/platform/platform_initialization.dart';
import 'package:book_talk/src/feature/bootstrap/logic/composition_root.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app.dart';
import 'package:book_talk/src/feature/bootstrap/widget/material_app_failed.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

final class AppBootstrap {
  Future<void> initializeApp() async {
    final bindings = WidgetsFlutterBinding.ensureInitialized()
      ..deferFirstFrame();

    /// BLoC setup
    Bloc.observer = AppBlocObserver(logger: appLogger);
    Bloc.transformer = bloc_concurrency.sequential();

    /// Handler setup
    FlutterError.onError = appLogger.logFlutterError;
    PlatformDispatcher.instance.onError =
        ErrorTracking.trackPlatformDispatcherError;

    await $platformInitialization();
    await _runApp();
    bindings.allowFirstFrame();
  }

  Future<void> _runApp() async {
    const config = Config();

    try {
      final root = await CompositionRoot(config, appLogger).compose();
      runApp(App(dependenciesContainer: root.dependencies));
    } on Object catch (e, stackTrace) {
      runApp(MaterialAppFailed(
        onRetry: _runApp,
        error: e,
        stackTrace: stackTrace,
      ));
      ErrorTracking.trackError(e, stackTrace);
    }
  }
}
