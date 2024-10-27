import 'dart:convert';

import 'package:flutter/material.dart';

class ThemeModeCodec extends Codec<ThemeMode, String> {
  @override
  Converter<String, ThemeMode> get decoder => _DecodeConverter();

  @override
  Converter<ThemeMode, String> get encoder => _EncodeConverter();
}

final class _DecodeConverter extends Converter<String, ThemeMode> {
  const _DecodeConverter();

  @override
  ThemeMode convert(String input) => switch (input) {
        'ThemeMode.system' => ThemeMode.system,
        'ThemeMode.light' => ThemeMode.light,
        'ThemeMode.dark' => ThemeMode.dark,
        _ => throw ArgumentError('_DecodeConverter invalid value'),
      };
}

final class _EncodeConverter extends Converter<ThemeMode, String> {
  const _EncodeConverter();

  @override
  String convert(ThemeMode input) => switch (input) {
        ThemeMode.system => 'ThemeMode.system',
        ThemeMode.light => 'ThemeMode.light',
        ThemeMode.dark => 'ThemeMode.dark'
      };
}
