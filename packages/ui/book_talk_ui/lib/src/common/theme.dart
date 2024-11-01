import 'package:book_talk_ui/src/common/color_palette.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookTalkTheme {
  ThemeData get darkTheme => _darkThemeData;

  ThemeData get lightTheme => _lightThemeData;

  late final _darkThemeData = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    actionIconTheme: _actionIconThemeData,
    extensions: const {
      ColorPalette(
        backgroundColor: Color(0xFF2F2F2F),
        primary: Color(0xffFF8C42),
      ),
    },
  );

  late final _lightThemeData = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    actionIconTheme: _actionIconThemeData,
    extensions: const {
      ColorPalette(
        backgroundColor: Color(0xFFFBFBFB),
        primary: Color(0xffFF8C42),
      ),
    },
  );

  ActionIconThemeData get _actionIconThemeData => ActionIconThemeData(
        backButtonIconBuilder: (context) => const Icon(
          CupertinoIcons.chevron_back,
        ),
      );
}
