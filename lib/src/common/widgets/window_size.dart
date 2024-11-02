import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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

  bool get isLargeFormat => switch (this) {
        _WindowSizeLarge() => true,
        _ => false,
      };

  bool get isMediumFormat => switch (this) {
        _WindowSizeMedium() => true,
        _ => false,
      };

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
    required T Function(_WindowSizeCompact)? compact,
    required T Function(_WindowSizeMedium)? medium,
    required T Function(_WindowSizeLarge)? large,
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
  static const _maxWidth = 700.0;

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

  static const _minWidth = 701.0;
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
