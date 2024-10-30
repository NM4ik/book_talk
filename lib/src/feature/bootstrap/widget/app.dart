import 'package:book_talk/src/feature/account/widget/account_scope.dart';
import 'package:book_talk/src/feature/auth/widget/auth_scope.dart';
import 'package:book_talk/src/feature/bootstrap/model/dependencies_container.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_context.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk/src/feature/settings/widget/settings_scope.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({
    required this.dependenciesContainer,
    super.key,
  });

  final DependenciesContainer dependenciesContainer;

  @override
  Widget build(BuildContext context) {
    return AppScope(
      dependenciesContainer: dependenciesContainer,
      child: SettingsScope(
        child: AuthScope(
          child: AccountScope(
            child: MaterialAppContext(),
          ),
        ),
      ),
    );
  }
}
