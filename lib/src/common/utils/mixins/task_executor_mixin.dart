import 'dart:async';
import 'package:bloc/bloc.dart';

mixin TaskExecuterBlocMixin<E, S> on Bloc<E, S> {
  bool get executeTaskIngoreOn => false;

  Future<T?> executeTask<T>({
    required FutureOr<T> Function() handle,
    void Function(T data)? onDone,
    Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    if (executeTaskIngoreOn) return null;

    try {
      final T data = await handle();

      if (!isClosed) {
        onDone?.call(data);
      }

      return data;
    } on Object catch (e, stackTrace) {
      this.onError(e, stackTrace);
      if (!isClosed) {
        onError?.call(e, stackTrace);
      }
    }
    return null;
  }
}
