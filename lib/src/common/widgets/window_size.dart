import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The scope provides [WindowSize] information to its descendants.
/// 
/// This widget listens for size changes and updates its state accordingly,
/// making it useful for managing layouts across different screen sizes.
class WindowSizeScope extends StatefulWidget {
  const WindowSizeScope({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  static WindowSize of(BuildContext context) =>
      context.inheritedOf<_InheritedWindowSizeScope>().windowSize;

  @override
  State<WindowSizeScope> createState() => _WindowSizeScopeState();
}

class _WindowSizeScopeState extends State<WindowSizeScope>
    with WidgetsBindingObserver {
  late WindowSize _windowSize;

  @override
  void initState() {
    super.initState();
    _windowSize = _getWindowSize();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeMetrics() {
    final windowSize = _getWindowSize();

    if (windowSize != _windowSize && mounted) {
      setState(() => _windowSize = windowSize);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  WindowSize _getWindowSize() {
    final view = PlatformDispatcher.instance.views.first;

    return WindowSize.fromSize(view.physicalSize / view.devicePixelRatio);
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedWindowSizeScope(
      child: widget.child,
      windowSize: _windowSize,
    );
  }
}

class _InheritedWindowSizeScope extends InheritedWidget {
  const _InheritedWindowSizeScope({
    required this.windowSize,
    required super.child,
  });

  final WindowSize windowSize;

  @override
  bool updateShouldNotify(covariant _InheritedWindowSizeScope oldWidget) =>
      windowSize != oldWidget.windowSize;
}

/// Сlass representing different window sizes, used for handling
/// various screen dimensions in a responsive manner.
///
/// [WindowSize] is a base class for representing a window's size, with three
/// concrete subclasses for different size categories: compact, medium, and large.
/// The class allows categorization of window sizes based on specific width thresholds.
///
/// The factory constructor [WindowSize.fromSize] categorizes the input [Size]
/// into one of the window size types based on its width, throwing an error for
/// invalid sizes.
///
/// The class provides convenience getters like [isLargeFormat], [isMediumFormat],
/// and [isCompactFormat] to check the window's category in an easy-to-read way.
sealed class WindowSize extends Size {
  WindowSize({
    required this.maxWidth,
    required this.minWidth,
    required Size size,
  }) : super(size.width, size.height);

  factory WindowSize.fromSize(Size size) {
    return switch (size.width) {
      >= _WindowSizeCompact._minWidth && < _WindowSizeMedium._minWidth =>
        _WindowSizeCompact(size: size),
      >= _WindowSizeMedium._minWidth && < _WindowSizeLarge._minWidth =>
        _WindowSizeMedium(size: size),
      >= _WindowSizeLarge._minWidth => _WindowSizeLarge(size: size),
      _ => throw AssertionError('Invalid windowSize - $size')
    };
  }

  /// Returns true if the window is considered large (width >= [minWidth] of [_WindowSizeLarge]).
  bool get isLargeFormat => switch (this) {
        _WindowSizeLarge() => true,
        _ => false,
      };

  /// Returns true if the window is considered medium (width >= [minWidth] of [_WindowSizeMedium]).
  bool get isMediumFormat => switch (this) {
        _WindowSizeMedium() => true,
        _ => false,
      };

  /// Returns true if the window is considered compact (width < [minWidth] of [_WindowSizeCompact]).
  bool get isCompactFormat => switch (this) {
        _WindowSizeCompact() => true,
        _ => false,
      };

  /// Maps the [WindowSize] to a value of type [T].
  T map<T>({
    required T Function(_WindowSizeCompact) compact,
    required T Function(_WindowSizeMedium) medium,
    required T Function(_WindowSizeLarge) large,
  }) =>
      switch (this) {
        final _WindowSizeCompact size => compact(size),
        final _WindowSizeMedium size => medium(size),
        final _WindowSizeLarge size => large(size),
      };

  /// Lazy maps the [WindowSize] to a value of type [T].
  T maybeMap<T>({
    T Function(_WindowSizeCompact)? compact,
    T Function(_WindowSizeMedium)? medium,
    T Function(_WindowSizeLarge)? large,
    required T Function() orElse,
  }) =>
      switch (this) {
        final _WindowSizeCompact size => compact?.call(size) ?? orElse(),
        final _WindowSizeMedium size => medium?.call(size) ?? orElse(),
        final _WindowSizeLarge size => large?.call(size) ?? orElse(),
      };

  final double maxWidth;
  final double minWidth;
}

final class _WindowSizeCompact extends WindowSize {
  _WindowSizeCompact({
    required Size size,
  }) : super(
          maxWidth: _maxWidth,
          minWidth: _minWidth,
          size: size,
        );

  static const _minWidth = 0.0;
  static const _maxWidth = 500.0;

  @override
  bool operator ==(Object other) {
    return other is _WindowSizeCompact &&
        minWidth == other.minWidth &&
        maxWidth == other.maxWidth &&
        width == other.width &&
        height == other.height;
  }

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, height, width]);

  @override
  String toString() => '_WindowSizeCompact';
}

final class _WindowSizeMedium extends WindowSize {
  _WindowSizeMedium({
    required Size size,
  }) : super(
          maxWidth: _maxWidth,
          minWidth: _minWidth,
          size: size,
        );

  static const _minWidth = 501.0;
  static const _maxWidth = 1024.0;

  @override
  bool operator ==(Object other) {
    return other is _WindowSizeMedium &&
        minWidth == other.minWidth &&
        maxWidth == other.maxWidth &&
        width == other.width &&
        height == other.height;
  }

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, height, width]);

  @override
  String toString() => '_WindowSizeMedium';
}

final class _WindowSizeLarge extends WindowSize {
  _WindowSizeLarge({
    required Size size,
  }) : super(
          maxWidth: _maxWidth,
          minWidth: _minWidth,
          size: size,
        );

  static const _minWidth = 1025.0;
  static const _maxWidth = double.infinity;

  @override
  bool operator ==(Object other) {
    return other is _WindowSizeLarge &&
        minWidth == other.minWidth &&
        maxWidth == other.maxWidth &&
        width == other.width &&
        height == other.height;
  }

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, height, width]);

  @override
  String toString() => '_WindowSizeLarge';
}
