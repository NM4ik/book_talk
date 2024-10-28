import 'package:flutter_bloc/flutter_bloc.dart';

mixin SetStateMixin<S> on Emittable<S> {
  void setState(S state) => emit(state);
}
