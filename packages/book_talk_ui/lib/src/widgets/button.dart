import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';

enum ButtonVariant {
  /// Button with background filled with primary color
  filledPrimary,
  negativePrimary,
  filledDesctructive,
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
    this.innerPadding,
    this.borderRadius,
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
    this.innerPadding,
    this.borderRadius,
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

  UiButton.filledDesctructive({
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
    this.innerPadding,
    this.borderRadius,
    super.key,
  })  : variant = ButtonVariant.filledDesctructive,
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
  final EdgeInsets? innerPadding;
  final BorderRadius? borderRadius;

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final theme = Theme.of(context);
    final palette = theme.colorPalette!;
    final typography = theme.appTypography!;

    return switch (variant) {
      ButtonVariant.filledPrimary => _FilledPrimaryStyle(
          colorPalette: palette,
          appTypography: typography,
          innerPadding: innerPadding,
        ),
      ButtonVariant.negativePrimary => _NegativePrimaryStyle(
          colorPalette: palette,
          appTypography: typography,
          innerPadding: innerPadding,
          borderRadius: borderRadius,
        ),
      ButtonVariant.filledDesctructive => _FilledDesctructivePrimaryStyle(
          colorPalette: palette,
          appTypography: typography,
        ),
    };
  }

  @override
  ButtonStyle? themeStyleOf(BuildContext context) => null;
}

class _FilledDesctructivePrimaryStyle extends _UiBaseButtonStyle {
  const _FilledDesctructivePrimaryStyle({
    required super.colorPalette,
    required super.appTypography,
    super.innerPadding = null,
  });

  @override
  WidgetStateProperty<Color?>? get backgroundColor => WidgetStatePropertyAll(
        colorPalette.destructive,
      );

  @override
  WidgetStateProperty<BorderSide?>? get side =>
      WidgetStatePropertyAll(BorderSide.none);

  @override
  WidgetStateProperty<double>? get elevation => const WidgetStatePropertyAll(0);
}

class _FilledPrimaryStyle extends _UiBaseButtonStyle {
  const _FilledPrimaryStyle({
    required super.colorPalette,
    required super.appTypography,
    super.innerPadding = null,
  });

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      WidgetStateProperty.resolveWith(
        (states) {
          if (states.contains(WidgetState.disabled)) {
            return colorPalette.primary.withOpacity(.12);
          }

          return colorPalette.primary;
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

class _NegativePrimaryStyle extends _UiBaseButtonStyle {
  const _NegativePrimaryStyle({
    required super.appTypography,
    required super.colorPalette,
    required super.innerPadding,
    super.borderRadius,
  });

  @override
  WidgetStateProperty<Color?>? get backgroundColor =>
      const WidgetStatePropertyAll(Colors.transparent);

  @override
  WidgetStateProperty<BorderSide?>? get side => WidgetStatePropertyAll(
        BorderSide(
          color: colorPalette.primary,
          width: 1,
        ),
      );

  @override
  WidgetStateProperty<double>? get elevation => const WidgetStatePropertyAll(0);
}

class _UiBaseButtonStyle extends ButtonStyle {
  const _UiBaseButtonStyle({
    required this.appTypography,
    required this.colorPalette,
    required this.innerPadding,
    this.borderRadius,
  });

  final AppTypography appTypography;
  final ColorPalette colorPalette;
  final EdgeInsets? innerPadding;
  final BorderRadius? borderRadius;

  @override
  WidgetStateProperty<Color?>? get overlayColor {
    return WidgetStateProperty.resolveWith((Set<WidgetState> states) {
      if (states.contains(WidgetState.hovered)) {
        return colorPalette.secondary;
      }
      return null;
    });
  }

  @override
  Duration? get animationDuration => const Duration(milliseconds: 200);

  @override
  AlignmentGeometry? get alignment => Alignment.center;

  @override
  WidgetStateProperty<TextStyle?>? get textStyle {
    return WidgetStatePropertyAll(appTypography.bodyMedium);
  }

  @override
  WidgetStateProperty<OutlinedBorder?>? get shape => WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(4)),
        ),
      );

  @override
  MaterialTapTargetSize? get tapTargetSize => MaterialTapTargetSize.shrinkWrap;

  @override
  WidgetStateProperty<EdgeInsetsGeometry?>? get padding =>
      WidgetStatePropertyAll(
        innerPadding ??
            EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 23,
            ),
      );

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
