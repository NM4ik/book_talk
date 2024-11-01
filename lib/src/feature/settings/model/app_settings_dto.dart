import 'dart:convert';

import 'package:book_talk/src/feature/settings/model/app_settings.dart';
import 'package:book_talk/src/feature/settings/model/theme_mode_codec.dart';
import 'package:flutter/material.dart';

class AppSettingsDto {
  final ThemeMode themeMode;
  final Locale locale;

  const AppSettingsDto({
    required this.themeMode,
    required this.locale,
  });

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

  String toJson() {
    return jsonEncode(
      {
        'themeMode': ThemeModeCodec().encode(themeMode),
        'locale.language_code': locale.languageCode,
        'locale.country_code': locale.countryCode,
      },
    );
  }

  AppSettings toEntity() => AppSettings(
        themeMode: themeMode,
        locale: locale,
      );
}
