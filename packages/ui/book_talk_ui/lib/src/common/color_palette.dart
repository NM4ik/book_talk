import 'package:flutter/material.dart';

class ColorPalette extends ThemeExtension<ColorPalette> {
  final Color backgroundColor;
  final Color primary;
  final Color onPrimary;

  final Color secondary;
  final Color onSecondary;

  const ColorPalette({
    required this.backgroundColor,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
  });

  @override
  ColorPalette copyWith({
    Color? backgroundColor,
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
  }) {
    return ColorPalette(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
    );
  }

  @override
  ThemeExtension<ColorPalette> lerp(
    covariant ThemeExtension<ColorPalette>? other,
    double t,
  ) {
    if (other is! ColorPalette) {
      return this;
    }
    return ColorPalette(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t) ??
          backgroundColor,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t) ?? onSecondary,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
    );
  }
}

extension ColorPaletteExtension on ThemeData {
  ColorPalette? get colorPalette => extension<ColorPalette>();
}
