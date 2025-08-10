import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A widget that rebuilds itself when the [Bloc] emits a new state,
/// with a transition animation using [AnimatedSwitcher].
///
/// The [AnimatedBlocBuilder] is similar to [BlocBuilder] but adds an
/// animation transition whenever the widget rebuilds.
///
/// The duration can be specified to control the length of the
/// transition animation. If not provided, a default duration of
/// 300 milliseconds is used.
class AnimatedBlocBuilder<B extends StateStreamable<S>, S>
    extends BlocBuilder<B, S> {
  /// Creates an [AnimatedBlocBuilder].
  ///
  /// The [builder] parameter must not be null.
  const AnimatedBlocBuilder({
    required super.builder,
    super.buildWhen,
    super.key,
    super.bloc,
    Duration? duration,
  }) : _duration = duration ?? const Duration(milliseconds: 300);

  /// The duration of the transition animation. Defaults to 300 milliseconds
  /// if not specified.
  final Duration _duration;

  @override
  Widget build(BuildContext context, S state) =>
      AnimatedSwitcher(duration: _duration, child: super.build(context, state));
}
