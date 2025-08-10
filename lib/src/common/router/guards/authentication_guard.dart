import 'dart:async';

import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:flutter/widgets.dart';
import 'package:octopus/octopus.dart';

/// A guard for managing authentication-based navigation within the app.
///
/// The [AuthenticationGuard] class extends [OctopusGuard] to control navigation
/// based on the user's authentication status.
///
/// It navigates to the appropriate screen, such as a sign-in or home screen,
/// depending on the user's auth state.
///
/// The guard ensures that authenticated users cannot access sign-in routes and
/// redirects unauthenticated users to sign-in when needed.
///
/// This guard operates by checking the authentication status through `getAuthStatus`
class AuthenticationGuard extends OctopusGuard {
  AuthenticationGuard({
    required AuthStatus Function() getAuthStatus,
    required Set<String> routes,
    required OctopusState signinNavigation,
    required OctopusState homeNavigation,
    required this.buildContext,
    super.refresh,
  })  : _getAuthStatus = getAuthStatus,
        _routes = routes,
        _signinNavigation = signinNavigation,
        _homeNavigation = homeNavigation;

  final BuildContext buildContext;

  final AuthStatus Function() _getAuthStatus;

  final Set<String> _routes;

  /// The navigation to use when the user is not authenticated.
  final OctopusState _signinNavigation;

  /// The navigation to use when the user is authenticated.
  final OctopusState _homeNavigation;

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) async {
    final authStatus = _getAuthStatus();
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

        return state.isEmpty ? _homeNavigation : state;
      } else {
        // Remove any navigation that is not an authentication navigation.
        state.removeWhere((child) => !_routes.contains(child.name));
        // Add the signin navigation if the state is empty.
        // Or return the state if it contains the signin navigation.

        return state.isEmpty ? _signinNavigation : state;
      }
    } else {
      if (isAuth) {
        return super.call(history, state, context);
      }

      // User not authenticated.
      // Replace the current navigation with the signin navigation.
      return _signinNavigation;
    }
  }
}
