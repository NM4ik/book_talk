import 'package:book_talk_ui/src/common/color_palette.dart';
import 'package:book_talk_ui/src/common/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookTalkTheme {
  ThemeData get darkTheme => _darkThemeData;

  ThemeData get lightTheme => _lightThemeData;

  late final _darkThemeData = ThemeData(
    extensions: const {
      _darkColorPallete,
      _appTypography,
    },
    brightness: Brightness.dark,
    useMaterial3: true,
    actionIconTheme: _actionIconThemeData,
    scaffoldBackgroundColor: _darkColorPallete.backgroundColor,
    appBarTheme: AppBarTheme(
      backgroundColor: _darkColorPallete.backgroundColor,
      elevation: .5,
    ),
    dividerTheme: DividerThemeData(
      color: _darkColorPallete.muted,
    ),
    cupertinoOverrideTheme: CupertinoThemeData(
      brightness: Brightness.dark,
      barBackgroundColor: _darkColorPallete.backgroundColor,
      primaryColor: _darkColorPallete.primary,
      primaryContrastingColor: _darkColorPallete.onPrimary,
      textTheme: CupertinoTextThemeData(
        primaryColor: _darkColorPallete.primary,
        navLargeTitleTextStyle: _appTypography.headlineLarge
            .copyWith(color: _darkColorPallete.foreground),
        navTitleTextStyle: _appTypography.titleMedium
            .copyWith(color: _darkColorPallete.foreground),
      ),
    ),
  );

  late final _lightThemeData = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    actionIconTheme: _actionIconThemeData,
    extensions: const {
      _darkColorPallete,
      _appTypography,
    },
  );

  ActionIconThemeData get _actionIconThemeData => ActionIconThemeData(
        backButtonIconBuilder: (context) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Icon(
              CupertinoIcons.chevron_back,
              size: 25,
              color: _darkColorPallete.primary,
            ),
          ),
        ),
      );

  static const _darkColorPallete = ColorPalette(
    backgroundColor: Color(0xFF2B2738),
    primary: Color(0xff6E54B5),
    onPrimary: Colors.white,
    secondary: Color(0xFF3B364C),
    onSecondary: Colors.white,
    foreground: Colors.white,
    destructive: Color(0xFFB22222),
    muted: Color.fromARGB(255, 51, 47, 66),
    complementary: Color(0xFFFFC966),
  );

  static const _appTypography = AppTypography(
    displayLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 57,
    ),
    displayMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 45,
    ),
    displaySmall: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 36,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 1,
      wordSpacing: 0,
      backgroundColor: Colors.transparent,
      decorationColor: Colors.transparent,
      decorationThickness: 1,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 28,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 24,
    ),
    titleLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 22,
    ),
    titleMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1,
      wordSpacing: 0,
      backgroundColor: Colors.transparent,
      decorationColor: Colors.transparent,
      decorationThickness: 1,
    ),
    titleSmall: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    labelLarge: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      fontSize: 10,
    ),
  );
}
