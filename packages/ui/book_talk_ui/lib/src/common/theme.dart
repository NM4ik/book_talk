import 'package:book_talk_ui/src/common/color_palette.dart';
import 'package:flutter/material.dart';

class BookTalkTheme {
  final _darkThemeData = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    extensions: const {
      ColorPalette(
        backgroundColor: Color(0xFF2F2F2F),
        primary: Color(0xffFF8C42),
      ),
    },
  );

  final _lightThemeData = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    extensions: const {
      ColorPalette(
        backgroundColor: Color(0xFFFBFBFB),
        primary: Color(0xffFF8C42),
      ),
    },
  );

  ThemeData get darkTheme => _darkThemeData;

  ThemeData get lightTheme => _lightThemeData;
}
