import 'package:book_talk/src/common/utils/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class AppBlocObserver extends BlocObserver {
  final AppLogger _logger;

  const AppBlocObserver({
    required AppLogger logger,
  }) : _logger = logger;

  @override
  void onTransition(Bloc bloc, Transition transition) {
    _logger.logMessage(
      'BLoC: ${bloc.runtimeType}. | ${transition.currentState.runtimeType} -> ${transition.nextState.runtimeType} |'
      'Event: ${transition.event.runtimeType}',
    );
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    _logger.logError('${bloc.runtimeType} | $error', stackTrace);
    super.onError(bloc, error, stackTrace);
  }
}
