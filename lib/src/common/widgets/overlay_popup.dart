import 'package:flutter/material.dart';

/// A utility class to manage an overlay popup in Flutter.
///
/// The `OverlayPopup` class allows for the creation of a custom popup overlay
/// relative to a widget’s position on the screen. This can be used for
/// displaying additional UI elements, like a calendar or menu, over the main
/// content.
///
/// Example usage:
/// ```
/// final overlayPopup = OverlayPopup();
/// overlayPopup.createCalendarOverlay(
///   context,
///   child: CalendarWidget(),
/// );
/// ```
class OverlayPopup {
  OverlayEntry? _overlayEntry;

  /// Creates and displays an overlay at a position relative to the calling widget.
  ///
  /// The overlay aligns to the top or bottom of the widget, depending on
  /// available screen space. The `child` parameter defines the widget to be displayed
  /// inside the overlay.
  ///
  /// If an overlay already exists, it is removed before creating a new one.
  ///
  /// Throws an [AssertionError] if the render object is null.
  void createCalendarOverlay(
    BuildContext context, {
    required Widget child,
  }) {
    // Remove the existing _overlayEntry.
    removeHighlightOverlay();
    assert(_overlayEntry == null, 'Overlay entry is not null');

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) {
      throw AssertionError('RenderBox is null');
    }

    final renderBoxSize = renderBox.size;
    final renderBoxOffset = renderBox.localToGlobal(Offset.zero);
    final availableHeight = MediaQuery.of(context).size.height -
        renderBoxOffset.dy -
        renderBoxSize.height;

    final Size modalSize = Size(renderBoxSize.width, 250);
    final topIndent = renderBoxOffset.dy +
        (modalSize.height > availableHeight
            ? -modalSize.height - 5
            : renderBoxSize.height + 5);

    _overlayEntry = OverlayEntry(
      builder: (context) => Align(
        child: Stack(
          fit: StackFit.expand,
          children: [
            _BarrierHandler(onTapOutside: removeHighlightOverlay),
            Positioned(
              top: topIndent,
              left: renderBoxOffset.dx,
              child: _AnimatedPopupContainer.fromSize(
                size: modalSize,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );

    final entry = _overlayEntry;
    if (entry != null) Overlay.of(context).insert(entry);
  }

  /// Removes the current overlay if it exists.
  ///
  /// This method disposes of the overlay entry, freeing resources and
  /// setting `_overlayEntry` to null.
  void removeHighlightOverlay() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
  }
}

class _AnimatedPopupContainer extends StatelessWidget {
  const _AnimatedPopupContainer._({required this.size, required this.child});

  const factory _AnimatedPopupContainer.fromSize({
    required Size size,
    required Widget child,
  }) = _AnimatedPopupContainer._;

  final Size size;
  final Widget child;

  @override
  Widget build(BuildContext context) => _FadePopupTransitionContainer(
      duration: const Duration(milliseconds: 200),
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(
          Radius.circular(4),
        ),
        child: SizedBox.fromSize(
          size: size,
          child: child,
        ),
      ),
    );
}

class _BarrierHandler extends StatelessWidget {
  const _BarrierHandler({required this.onTapOutside});

  final VoidCallback onTapOutside;

  @override
  Widget build(BuildContext context) => _FadePopupTransitionContainer(
      duration: const Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: onTapOutside,
        child: const ColoredBox(
          color: Colors.black26,
        ),
      ),
    );
}

class _FadePopupTransitionContainer extends StatefulWidget {
  const _FadePopupTransitionContainer({
    required this.child,
    required this.duration,
  });

  final Widget child;
  final Duration duration;

  @override
  State<_FadePopupTransitionContainer> createState() =>
      _FadePopupTransitionContainerState();
}

class _FadePopupTransitionContainerState
    extends State<_FadePopupTransitionContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _fadeAnimationController;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeAnimationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      _fadeAnimationController,
    );
    _fadeAnimationController.forward();
  }

  @override
  void dispose() {
    _fadeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
      opacity: _fadeAnimation,
      child: widget.child,
    );
}
