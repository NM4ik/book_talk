import 'dart:convert';

import 'package:book_talk/src/feature/settings/model/app_settings.dart';
import 'package:book_talk/src/feature/settings/model/theme_mode_codec.dart';
import 'package:flutter/material.dart';

class AppSettingsDto {
  const AppSettingsDto({required this.themeMode, required this.locale});

  factory AppSettingsDto.fromJson(String json) {
    final data = jsonDecode(json) as Map<String, Object?>;

    final languageCode = data['locale.language_code'] as String?;

    return AppSettingsDto(
      themeMode: ThemeModeCodec().decode(data['themeMode']! as String),
      locale: languageCode != null
          ? Locale(languageCode, data['locale.country_code'] as String?)
          : null,
    );
  }

  factory AppSettingsDto.fromEntity(AppSettings entity) =>
      AppSettingsDto(themeMode: entity.themeMode, locale: entity.locale);

  final ThemeMode themeMode;
  final Locale? locale;

  String toJson() => jsonEncode({
    'themeMode': ThemeModeCodec().encode(themeMode),
    if (locale != null) ...{
      'locale.language_code': locale?.languageCode,
      'locale.country_code': locale?.countryCode,
    },
  });

  AppSettings toEntity() => AppSettings(themeMode: themeMode, locale: locale);
}
