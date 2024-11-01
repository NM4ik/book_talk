import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:octopus/octopus.dart';

import 'package:book_talk/src/feature/auth/model/auth_status.dart';

class AuthenticationGuard extends OctopusGuard {
  AuthenticationGuard({
    required AuthStatus Function() getAuthStatus,
    required Set<String> routes,
    required OctopusState signinNavigation,
    required OctopusState homeNavigation,
    required this.buildContext,
    OctopusState? lastNavigation,
    super.refresh,
  })  : _getAuthStatus = getAuthStatus,
        _routes = routes,
        _signinNavigation = signinNavigation,
        _lastNavigation = lastNavigation ?? homeNavigation {
    if (lastNavigation == null) {
      try {
        final state = OctopusState.fromLocation(
          WidgetsBinding.instance.platformDispatcher.defaultRouteName,
        );
        if (state.isNotEmpty) {
          _lastNavigation = state;
        }
      } on Object {/* ignore */}
    }
  }

  final BuildContext buildContext;

  final AuthStatus Function() _getAuthStatus;

  final Set<String> _routes;

  /// The navigation to use when the user is not authenticated.
  final OctopusState _signinNavigation;

  /// The navigation to use when the user is authenticated.
  OctopusState _lastNavigation;

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) async {
    final authStatus = await _getAuthStatus();
    context['authStatus'] = authStatus;
    final isAuthNav =
        state.children.any((child) => _routes.contains(child.name));
    final isAuth = authStatus == AuthStatus.auth;

    if (isAuthNav) {
      if (isAuth) {
        // Remove any navigation that is an authentication navigation.
        state.removeWhere((child) => _routes.contains(child.name));
        // Restore the last navigation when the user is authenticated
        // if the state contains only the authentication routes.

        return state.isEmpty ? _lastNavigation : state;
      } else {
        // Remove any navigation that is not an authentication navigation.
        state.removeWhere((child) => !_routes.contains(child.name));
        // Add the signin navigation if the state is empty.
        // Or return the state if it contains the signin navigation.

        return state.isEmpty ? _signinNavigation : state;
      }
    } else {
      if (isAuth) {
        // Save the current navigation as the last navigation.
        _lastNavigation = state;

        return super.call(history, state, context);
      } else {
        // User not authenticated.
        // Replace the current navigation with the signin navigation.
        return _signinNavigation;
      }
    }
  }
}
