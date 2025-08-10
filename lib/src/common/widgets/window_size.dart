import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// The scope provides [WindowSize] information to its descendants.
///
/// This widget listens for size changes and updates its state accordingly,
/// making it useful for managing layouts across different screen sizes.
@immutable
class WindowSizeScope extends StatefulWidget {
  const WindowSizeScope({required this.child, super.key});

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
  Widget build(BuildContext context) =>
      _InheritedWindowSizeScope(windowSize: _windowSize, child: widget.child);
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

  factory WindowSize.fromSize(Size size) => switch (size.width) {
    >= WindowSizeCompact._minWidth && < WindowSizeMedium._minWidth =>
      WindowSizeCompact(size: size),
    >= WindowSizeMedium._minWidth && < WindowSizeLarge._minWidth =>
      WindowSizeMedium(size: size),
    >= WindowSizeLarge._minWidth => WindowSizeLarge(size: size),
    _ => throw AssertionError('Invalid windowSize - $size'),
  };

  /// Returns true if the window is considered large (width >= [minWidth] of [WindowSizeLarge]).
  bool get isLargeFormat => switch (this) {
    WindowSizeLarge() => true,
    _ => false,
  };

  /// Returns true if the window is considered medium (width >= [minWidth] of [WindowSizeMedium]).
  bool get isMediumFormat => switch (this) {
    WindowSizeMedium() => true,
    _ => false,
  };

  /// Returns true if the window is considered compact (width < [minWidth] of [WindowSizeCompact]).
  bool get isCompactFormat => switch (this) {
    WindowSizeCompact() => true,
    _ => false,
  };

  /// Maps the [WindowSize] to a value of type [T].
  T map<T>({
    required T Function(WindowSizeCompact) compact,
    required T Function(WindowSizeMedium) medium,
    required T Function(WindowSizeLarge) large,
  }) => switch (this) {
    final WindowSizeCompact size => compact(size),
    final WindowSizeMedium size => medium(size),
    final WindowSizeLarge size => large(size),
  };

  /// Lazy maps the [WindowSize] to a value of type [T].
  T maybeMap<T>({
    required T Function() orElse,
    T Function(WindowSizeCompact)? compact,
    T Function(WindowSizeMedium)? medium,
    T Function(WindowSizeLarge)? large,
  }) => switch (this) {
    final WindowSizeCompact size => compact?.call(size) ?? orElse(),
    final WindowSizeMedium size => medium?.call(size) ?? orElse(),
    final WindowSizeLarge size => large?.call(size) ?? orElse(),
  };

  final double maxWidth;
  final double minWidth;
}

@immutable
final class WindowSizeCompact extends WindowSize {
  WindowSizeCompact({required super.size})
    : super(maxWidth: _maxWidth, minWidth: _minWidth);

  static const _minWidth = 0.0;
  static const _maxWidth = 500.0;

  @override
  bool operator ==(Object other) =>
      other is WindowSizeCompact &&
      minWidth == other.minWidth &&
      maxWidth == other.maxWidth &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, height, width]);

  @override
  String toString() => '_WindowSizeCompact';
}

@immutable
final class WindowSizeMedium extends WindowSize {
  WindowSizeMedium({required super.size})
    : super(maxWidth: _maxWidth, minWidth: _minWidth);

  static const _minWidth = 501.0;
  static const _maxWidth = 1024.0;

  @override
  bool operator ==(Object other) =>
      other is WindowSizeMedium &&
      minWidth == other.minWidth &&
      maxWidth == other.maxWidth &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, height, width]);

  @override
  String toString() => '_WindowSizeMedium';
}

@immutable
final class WindowSizeLarge extends WindowSize {
  WindowSizeLarge({required super.size})
    : super(maxWidth: _maxWidth, minWidth: _minWidth);

  static const _minWidth = 1025.0;
  static const _maxWidth = double.infinity;

  @override
  bool operator ==(Object other) =>
      other is WindowSizeLarge &&
      minWidth == other.minWidth &&
      maxWidth == other.maxWidth &&
      width == other.width &&
      height == other.height;

  @override
  int get hashCode => Object.hashAll([minWidth, maxWidth, height, width]);

  @override
  String toString() => '_WindowSizeLarge';
}
