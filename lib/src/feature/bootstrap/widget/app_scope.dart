import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:book_talk/src/feature/bootstrap/model/dependencies_container.dart';
import 'package:flutter/material.dart';

final class AppScope extends InheritedWidget {
  const AppScope({
    required super.child,
    required this.dependenciesContainer,
  });

  final DependenciesContainer dependenciesContainer;

  static DependenciesContainer of(BuildContext context) =>
      context.inheritedOf<AppScope>(listen: false).dependenciesContainer;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}
