import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';

enum ButtonVariant {
  /// Button with background filled with primary color
  filledPrimary,
  negativePrimary,
}

class UiButton extends ButtonStyleButton {
  UiButton.filledPrimary({
    required VoidCallback? onPressed,
    bool enabled = true,
    IconAlignment iconAlignment = IconAlignment.start,
    Widget? label,
    Widget? icon,
    VoidCallback? onLongPress,
    super.autofocus = false,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.clipBehavior,
    super.statesController,
    super.isSemanticButton,
    super.key,
  })  : variant = ButtonVariant.filledPrimary,
        super(
          child: _ButtonIconAndLabel(
            icon: icon,
            label: label,
            iconAlignment: iconAlignment,
          ),
          onPressed: enabled ? onPressed : null,
          onLongPress: enabled ? onLongPress : null,
        );

  UiButton.negativePrimary({
    required VoidCallback? onPressed,
    bool enabled = true,
    IconAlignment iconAlignment = IconAlignment.start,
    Widget? label,
    Widget? icon,
    VoidCallback? onLongPress,
    super.autofocus = false,
    super.onHover,
    super.onFocusChange,
    super.style,
    super.focusNode,
    super.clipBehavior,
    super.statesController,
    super.isSemanticButton,
    super.key,
  })  : variant = ButtonVariant.negativePrimary,
        super(
          child: _ButtonIconAndLabel(
            icon: icon,
            label: label,
            iconAlignment: iconAlignment,
          ),
          onPressed: enabled ? onPressed : null,
          onLongPress: enabled ? onLongPress : null,
        );

  final ButtonVariant variant;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette!;
    final typography = theme.appTypography!;

    return switch (variant) {
      ButtonVariant.filledPrimary =>
        _FilledPrimaryStyle(palette: palette, appTypography: typography),
      ButtonVariant.negativePrimary =>
        _NegativePrimaryStyle(palette: palette, appTypography: typography),
    };
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) => null;
}

class _NegativePrimaryStyle extends _UiBaseButtonStyle {
  final ColorPalette? palette;

  const _NegativePrimaryStyle({
    required this.palette,
    required super.appTypography,
  });

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      const WidgetStatePropertyAll(Colors.transparent);

  @override
  WidgetStateProperty<BorderSide?>? get side => WidgetStatePropertyAll(
        BorderSide(
          color: palette?.primary ?? Colors.transparent,
          width: 1,
        ),
      );

  @override
  WidgetStateProperty<double>? get elevation => const WidgetStatePropertyAll(0);
}

class _FilledPrimaryStyle extends _UiBaseButtonStyle {
  final ColorPalette? palette;

  const _FilledPrimaryStyle({
    required this.palette,
    required super.appTypography,
  });

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return palette?.primary.withOpacity(.12);
          }

          return palette?.primary;
        },
      );

  @override
  WidgetStateProperty<double>? get elevation =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return 0.0;
        }
        if (states.contains(WidgetState.pressed)) {
          return 0.0;
        }
        if (states.contains(WidgetState.hovered)) {
          return 1.0;
        }
        if (states.contains(WidgetState.focused)) {
          return 0.0;
        }
        return 0.0;
      });
}

class _UiBaseButtonStyle extends ButtonStyle {
  const _UiBaseButtonStyle({required this.appTypography});

  final AppTypography appTypography;

  @override
  Duration? get animationDuration => const Duration(milliseconds: 200);

  @override
  AlignmentGeometry? get alignment => Alignment.center;

  @override
  WidgetStateProperty<TextStyle?>? get textStyle =>
      WidgetStatePropertyAll(appTypography.bodyMedium);

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape =>
      const WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
      );

  @override
  MaterialTapTargetSize? get tapTargetSize => MaterialTapTargetSize.shrinkWrap;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 23));

  @override
  WidgetStateProperty<Size?>? get minimumSize =>
      const WidgetStatePropertyAll(Size(60, 40));

  @override
  WidgetStateProperty<Size?>? get maximumSize =>
      const WidgetStatePropertyAll(Size.infinite);

  @override
  WidgetStateProperty<Color>? get shadowColor =>
      const WidgetStatePropertyAll<Color>(Colors.transparent);

  @override
  VisualDensity? get visualDensity => VisualDensity.adaptivePlatformDensity;

  @override
  WidgetStateProperty<MouseCursor?>? get mouseCursor =>
      WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.disabled)) {
          return SystemMouseCursors.basic;
        }
        return SystemMouseCursors.click;
      });

  @override
  WidgetStateProperty<double>? get iconSize =>
      const WidgetStatePropertyAll<double>(18.0);
}

class _ButtonIconAndLabel extends StatelessWidget {
  const _ButtonIconAndLabel({
    required this.icon,
    required this.label,
    required this.iconAlignment,
  });

  final Widget? icon;
  final Widget? label;
  final IconAlignment iconAlignment;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: iconAlignment == IconAlignment.start
            ? [
                if (icon != null) icon!,
                if (icon != null && label != null) const SizedBox(width: 8),
                if (label != null) Flexible(child: label!),
              ]
            : [
                if (label != null) Flexible(child: label!),
                if (icon != null && label != null) const SizedBox(width: 8),
                if (icon != null) icon!,
              ],
      );
}
