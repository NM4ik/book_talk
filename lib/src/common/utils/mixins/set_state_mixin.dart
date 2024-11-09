import 'package:flutter_bloc/flutter_bloc.dart';

/// [SetStateMixin] is used with classes extending [Emittable] to simplify
/// state updates by providing a `setState` method. This method emits a new
/// state of type [S], making it easier to update state in classes that
/// utilize the [Emittable] interface.
mixin SetStateMixin<S> on Emittable<S> {
  void setState(S state) => emit(state);
}
