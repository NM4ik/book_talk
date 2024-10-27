import 'dart:convert';

import 'package:book_talk/src/feature/settings/model/theme_codec.dart';
import 'package:flutter/material.dart';

class AppSettingsDto {
  final ThemeMode themeMode;
  final Locale locale;

  const AppSettingsDto({
    required this.themeMode,
    required this.locale,
  });

  String toJson() {
    return jsonEncode(
      {
        'themeMode': ThemeModeCodec().encode(themeMode),
        'locale.language_code': locale.languageCode,
        'locale.country_code': locale.countryCode,
      },
    );
  }

  factory AppSettingsDto.fromJson(String json) {
    final data = jsonDecode(json) as Map<String, Object?>;
    return AppSettingsDto(
      themeMode: ThemeModeCodec().decode(data['themeMode'] as String),
      locale: Locale(
        data['locale.language_code'] as String,
        data['locale.country_code'] as String?,
      ),
    );
  }

  factory AppSettingsDto.fromEntity(AppSettings entity) => AppSettingsDto(
        themeMode: entity.themeMode,
        locale: entity.locale,
      );

  AppSettings toEntity() => AppSettings(
        themeMode: themeMode,
        locale: locale,
      );
}

class AppSettings {
  final ThemeMode themeMode;
  final Locale locale;

  const AppSettings({
    required this.themeMode,
    required this.locale,
  });

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
