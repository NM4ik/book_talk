import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';

enum UiBoxType { colored, height }

class UiBox extends StatelessWidget {
  const UiBox._({
    this.height,
    this.color,
    this.size,
    this.borderRadius,
    this.uiBoxType = UiBoxType.height,
    super.key,
  });

  factory UiBox.hGap({double height = 20, Key? key}) =>
      UiBox._(key: key, height: height);

  factory UiBox.colored({
    Key? key,
    Color? color,
    Size? size,
    BorderRadiusGeometry? borderRadius,
  }) => UiBox._(
    key: key,
    size: size,
    borderRadius: borderRadius,
    color: color,
    uiBoxType: UiBoxType.colored,
  );

  final double? height;
  final Color? color;
  final Size? size;
  final BorderRadiusGeometry? borderRadius;
  final UiBoxType uiBoxType;

  @override
  Widget build(BuildContext context) {
    if (uiBoxType == UiBoxType.height) {
      return SizedBox(height: height);
    }

    if (uiBoxType == UiBoxType.colored) {
      return _SizedBoxColored(
        key: key,
        color: color,
        size: size,
        borderRadius: borderRadius,
      );
    }

    return const SizedBox.shrink();
  }
}

class _SizedBoxColored extends StatelessWidget {
  const _SizedBoxColored({this.color, this.size, this.borderRadius, super.key});

  final Color? color;
  final Size? size;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    key: ValueKey(color),
    decoration: BoxDecoration(
      color: color ?? Theme.of(context).colorPalette?.destructive,
      shape: BoxShape.circle,
      borderRadius: borderRadius,
    ),
    child: SizedBox.fromSize(size: size ?? const Size(8, 8)),
  );
}
