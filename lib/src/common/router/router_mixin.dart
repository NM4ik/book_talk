import 'dart:async';

import 'package:book_talk/src/common/router/guards/authentication_guard.dart';
import 'package:book_talk/src/common/router/routes.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

mixin RouterMixin<T extends StatefulWidget> on State<T> {
  late final Octopus router;
  late final StreamSubscription _authStreamSubscription;

  /// Listenable for [AuthenticationGuard]
  late final ValueNotifier<AuthStatus> notifier;

  @override
  void initState() {
    final dependencies = AppScope.of(context);
    final authBloc = dependencies.authBloc;

    notifier = ValueNotifier(authBloc.state.authStatus);
    _authStreamSubscription = authBloc.stream.listen((state) {
      notifier.value = state.authStatus;
    });

    router = Octopus(
      routes: Routes.values,
      defaultRoute: Routes.home,
      transitionDelegate: const DefaultTransitionDelegate(),
      guards: <IOctopusGuard>[
        AuthenticationGuard(
          getAuthStatus: () => notifier.value,
          routes: <String>{
            Routes.signin.name,
          },
          signinNavigation: OctopusState.single(Routes.signin.node()),
          homeNavigation: OctopusState.single(Routes.home.node()),
          buildContext: context,
          refresh: notifier,
        ),
      ],
    );
    super.initState();
  }

  @override
  void dispose() {
    _authStreamSubscription.cancel();
    notifier.dispose();
    super.dispose();
  }
}
