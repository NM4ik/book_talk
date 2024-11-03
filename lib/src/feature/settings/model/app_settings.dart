import 'package:flutter/material.dart';

class AppSettings {
  const AppSettings({
    required this.themeMode,
    this.locale,
  });

  final ThemeMode themeMode;
  final Locale? locale;

  AppSettings copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return AppSettings(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  String toString() => 'AppSettings(themeMode: $themeMode, locale: $locale)';

  @override
  bool operator ==(covariant AppSettings other) =>
      identical(this, other) ||
      other.themeMode == themeMode && other.locale == locale;

  @override
  int get hashCode => themeMode.hashCode ^ locale.hashCode;
}
