import 'package:book_talk/src/common/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

mixin RouterMixin<T extends StatefulWidget> on State<T> {
  late final Octopus router;

  @override
  void initState() {
    router = Octopus(
      routes: Routes.values,
      defaultRoute: Routes.signin,
      transitionDelegate: const DefaultTransitionDelegate(),
      guards: <IOctopusGuard>[],
    );
    super.initState();
  }
}
