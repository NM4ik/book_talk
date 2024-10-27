import 'package:book_talk/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'SignIn ${SettingsScope.settingsOf(context)}, mode ThemeMode ${Theme.of(context).brightness}'
          'Locale = ${Localizations.localeOf(context)}',
        ),
      ),
    );
  }
}
