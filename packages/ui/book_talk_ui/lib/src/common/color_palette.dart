import 'package:flutter/material.dart';

class ColorPalette extends ThemeExtension<ColorPalette> {
  final Color backgroundColor;

  /// The primary color of entire app. [Brand-Color]
  final Color primary;
  final Color onPrimary;

  final Color secondary;
  final Color onSecondary;

  /// The color of text, icons, buttons, active elements
  final Color foreground;

  const ColorPalette({
    required this.backgroundColor,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.foreground,
  });

  @override
  ColorPalette copyWith({
    Color? backgroundColor,
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? foreground,
  }) {
    return ColorPalette(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      foreground: foreground ?? this.foreground,
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
      foreground: Color.lerp(foreground, other.foreground, t) ?? foreground,
    );
  }
}

extension ColorPaletteExtension on ThemeData {
  ColorPalette? get colorPalette => extension<ColorPalette>();
}
