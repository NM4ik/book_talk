import 'dart:async';
import 'package:flutter/material.dart';

/// The type of progress indicator.
enum UiProgressIndicatorType { deferred }

const _kDefferedDuration = const Duration(seconds: 2);
const _kDefferedAppearDuration = const Duration(milliseconds: 500);

/// {@template progress_indicator}
/// UiProgressIndicator widget.
/// This widget displays a progress indicator.
/// It is similar to CircularProgressIndicator.
/// {@endtemplate}
class UiProgressIndicator extends StatelessWidget {
  /// {@macro progress_indicator}
  const UiProgressIndicator._({
    required this.type,
    this.duration,
    super.key,
  });

  factory UiProgressIndicator.deffered({Duration? duration, Key? key}) =>
      UiProgressIndicator._(
        type: UiProgressIndicatorType.deferred,
        duration: duration,
        key: key,
      );

  final Duration? duration;
  final UiProgressIndicatorType type;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      UiProgressIndicatorType.deferred => _DefferedProgressIndicator(
          duration: duration,
          key: key,
        ),
    };
  }
}

/// {@template progress_indicator}
/// _DefferedProgressIndicator widget.
///
/// [deferred] is time delayed indicator which will show after some time
/// {@endtemplate}
class _DefferedProgressIndicator extends StatefulWidget {
  /// {@macro progress_indicator}
  const _DefferedProgressIndicator({
    Duration? duration,
    super.key, // ignore: unused_element
  }) : _duration = duration ?? _kDefferedDuration;

  final Duration _duration;

  @override
  State<_DefferedProgressIndicator> createState() =>
      __DefferedProgressIndicatorState();
}

/// State for widget _DefferedProgressIndicator.
class __DefferedProgressIndicatorState
    extends State<_DefferedProgressIndicator> {
  late final Timer _timer;
  bool _isVisible = false;

  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    _timer = Timer(widget._duration, () {
      if (mounted) {
        setState(() => _isVisible = !_isVisible);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) {
    print('isVisible - $_isVisible');
    return AnimatedSwitcher(
      duration: _kDefferedAppearDuration,
      child: _isVisible
          ? const _ProgressIndicator()
          : SizedBox(
              key: UniqueKey(),
            ),
    );
  }
}

/// {@template progress_indicator}
/// _ProgressIndicator widget.
///
/// Simple Circular progress indicator widget with custom parameters
/// {@endtemplate}
class _ProgressIndicator extends StatelessWidget {
  /// {@macro progress_indicator}
  const _ProgressIndicator({
    super.key, // ignore: unused_element
  });

  @override
  Widget build(BuildContext context) =>
      CircularProgressIndicator(strokeWidth: 2.5);
}
