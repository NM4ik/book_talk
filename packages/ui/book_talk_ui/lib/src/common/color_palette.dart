import 'package:flutter/material.dart';

class ColorPalette extends ThemeExtension<ColorPalette> {
  final Color backgroundColor;
  final Color primary;

  const ColorPalette({
    required this.backgroundColor,
    required this.primary,
  });

  @override
  ColorPalette copyWith({
    Color? backgroundColor,
    Color? primary,
  }) {
    return ColorPalette(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primary: primary ?? this.primary,
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
    );
  }
}

extension ColorPaletteExtension on ThemeData {
  ColorPalette? get colorPalette => extension<ColorPalette>();
}
