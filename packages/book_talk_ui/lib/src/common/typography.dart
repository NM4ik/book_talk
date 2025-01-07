import 'package:flutter/material.dart';

/// An extension for theme to provide typography in context.
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.bodyLarge,
    required this.bodyMedium,
    required this.bodySmall,
    required this.labelLarge,
    required this.labelMedium,
    required this.labelSmall,
  });

  /// Display large style.
  final TextStyle displayLarge;

  /// Display medium style.
  final TextStyle displayMedium;

  /// Display small style.
  final TextStyle displaySmall;

  /// Headline large style.
  final TextStyle headlineLarge;

  /// Headline medium style.
  final TextStyle headlineMedium;

  /// Headline small style.
  final TextStyle headlineSmall;

  /// Title large style.
  final TextStyle titleLarge;

  /// Title medium style.
  final TextStyle titleMedium;

  /// Title small style.
  final TextStyle titleSmall;

  /// Body large style.
  final TextStyle bodyLarge;

  /// Body medium style.
  final TextStyle bodyMedium;

  /// Body small style.
  final TextStyle bodySmall;

  /// Label large style.
  final TextStyle labelLarge;

  /// Label medium style.
  final TextStyle labelMedium;

  /// Label small style.
  final TextStyle labelSmall;

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? displayLarge,
    TextStyle? displayMedium,
    TextStyle? displaySmall,
    TextStyle? headlineLarge,
    TextStyle? headlineMedium,
    TextStyle? headlineSmall,
    TextStyle? titleLarge,
    TextStyle? titleMedium,
    TextStyle? titleSmall,
    TextStyle? bodyLarge,
    TextStyle? bodyMedium,
    TextStyle? bodySmall,
    TextStyle? labelLarge,
    TextStyle? labelMedium,
    TextStyle? labelSmall,
  }) =>
      AppTypography(
        displayLarge: displayLarge ?? this.displayLarge,
        displayMedium: displayMedium ?? this.displayMedium,
        displaySmall: displaySmall ?? this.displaySmall,
        headlineLarge: headlineLarge ?? this.headlineLarge,
        headlineMedium: headlineMedium ?? this.headlineMedium,
        headlineSmall: headlineSmall ?? this.headlineSmall,
        titleLarge: titleLarge ?? this.titleLarge,
        titleMedium: titleMedium ?? this.titleMedium,
        titleSmall: titleSmall ?? this.titleSmall,
        bodyLarge: bodyLarge ?? this.bodyLarge,
        bodyMedium: bodyMedium ?? this.bodyMedium,
        bodySmall: bodySmall ?? this.bodySmall,
        labelLarge: labelLarge ?? this.labelLarge,
        labelMedium: labelMedium ?? this.labelMedium,
        labelSmall: labelSmall ?? this.labelSmall,
      );

  @override
  ThemeExtension<AppTypography> lerp(
    covariant ThemeExtension<AppTypography>? other,
    double t,
  ) {
    if (other == null || other is! AppTypography) {
      return this;
    }

    return AppTypography(
      displayLarge: TextStyle.lerp(displayLarge, other.displayLarge, t)!,
      displayMedium: TextStyle.lerp(displayMedium, other.displayMedium, t)!,
      displaySmall: TextStyle.lerp(displaySmall, other.displaySmall, t)!,
      headlineLarge: TextStyle.lerp(headlineLarge, other.headlineLarge, t)!,
      headlineMedium: TextStyle.lerp(headlineMedium, other.headlineMedium, t)!,
      headlineSmall: TextStyle.lerp(headlineSmall, other.headlineSmall, t)!,
      titleLarge: TextStyle.lerp(titleLarge, other.titleLarge, t)!,
      titleMedium: TextStyle.lerp(titleMedium, other.titleMedium, t)!,
      titleSmall: TextStyle.lerp(titleSmall, other.titleSmall, t)!,
      bodyLarge: TextStyle.lerp(bodyLarge, other.bodyLarge, t)!,
      bodyMedium: TextStyle.lerp(bodyMedium, other.bodyMedium, t)!,
      bodySmall: TextStyle.lerp(bodySmall, other.bodySmall, t)!,
      labelLarge: TextStyle.lerp(labelLarge, other.labelLarge, t)!,
      labelMedium: TextStyle.lerp(labelMedium, other.labelMedium, t)!,
      labelSmall: TextStyle.lerp(labelSmall, other.labelSmall, t)!,
    );
  }
}

extension AppTypographyExtension on ThemeData {
  AppTypography? get appTypography => extension<AppTypography>();
}
