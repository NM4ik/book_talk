import 'package:book_talk/src/common/widgets/window_size.dart';
import 'package:book_talk/src/feature/bootstrap/model/dependencies_container.dart';
import 'package:book_talk/src/feature/bootstrap/widget/material_app_context.dart';
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
      child: const SettingsScope(
        child: WindowSizeScope(
          child: MaterialAppContext(),
        ),
      ),
    );
  }
}
