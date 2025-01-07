import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:example/src/navigation_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final BookTalkTheme theme = BookTalkTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      darkTheme: theme.darkTheme,
      theme: theme.lightTheme,
      home: const NavigationScreen(),
    );
  }
}
