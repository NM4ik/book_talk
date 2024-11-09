import 'package:book_talk/src/common/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Custom [BlocObserver] implementation to log BLoC transitions and errors.
///
/// [AppBlocObserver] monitors state transitions and errors in all BLoC
/// instances and logs them via the provided [AppLogger]. This is useful for
/// tracking BLoC state changes and diagnosing errors during development.
final class AppBlocObserver extends BlocObserver {
  const AppBlocObserver({
    required AppLogger logger,
  }) : _logger = logger;

  final AppLogger _logger;

  /// - [onTransition] logs each transition, showing the BLoC type, the previous
  ///   and next state types, and the event type.
  @override
  void onTransition(Bloc bloc, Transition transition) {
    _logger.logMessage(
      'BLoC: ${bloc.runtimeType}. | ${transition.currentState.runtimeType} -> ${transition.nextState.runtimeType} |'
      'Event: ${transition.event.runtimeType}',
    );
    super.onTransition(bloc, transition);
  }

  /// - [onError] logs errors along with the stack trace for troubleshooting.
  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.logError('${bloc.runtimeType} | $error', stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
