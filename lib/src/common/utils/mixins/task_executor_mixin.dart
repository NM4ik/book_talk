import 'dart:async';
import 'package:bloc/bloc.dart';

mixin TaskExecuterBlocMixin<E, S> on Bloc<E, S> {
  bool get executeTaskIngoreOn => false;

  Future<void> executeTask<T>({
    required FutureOr<T> Function() handle,
    required Function(T data) onDone,
    Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    if (executeTaskIngoreOn) return;

    try {
      final T data = await handle();

      if (!isClosed) {
        onDone(data);
      }
    } on Object catch (e, stackTrace) {
      this.onError(e, stackTrace);
      if (!isClosed) {
        onError?.call(e, stackTrace);
      }
    }
  }
}
