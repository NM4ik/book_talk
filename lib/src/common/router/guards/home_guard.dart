import 'dart:async';
import 'package:book_talk/src/common/router/routes.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:octopus/octopus.dart';

/// A guard ensuring the correct setup of the home route in navigation.
///
/// [HomeGuard] extends [OctopusGuard] to maintain the correct state for
/// navigating to the home route. It ensures that the home route is the
/// first and only route when the user is authenticated. If the user is
/// unauthenticated, no action is taken, and the state remains unchanged.
///
/// The guard verifies the route setup and calls [_fix] when adjustments
/// are needed, clearing any extra routes and setting the home route
/// as the initial and sole route in the navigation state.
class HomeGuard extends OctopusGuard {
  HomeGuard();

  static final String _homeName = Routes.rooms.name;

  @override
  FutureOr<OctopusState> call(
    List<OctopusHistoryEntry> history,
    OctopusState$Mutable state,
    Map<String, Object?> context,
  ) {
    // If the user is not authenticated, do nothing.
    // The home route should not be in the state.
    if (context['authStatus']
        case AuthStatus status) if (status == AuthStatus.unAuth) return state;

    // Home route should be the first route in the state
    // and should be only one in whole state.
    if (state.isEmpty) return _fix(state);
    final count = state.findAllByName(_homeName).length;
    if (count != 1) return _fix(state);
    if (state.children.first.name != _homeName) return _fix(state);

    return state;
  }

  /// Change the state of the nested navigation.
  OctopusState _fix(OctopusState$Mutable state) => state
    ..clear()
    ..putIfAbsent(_homeName, () => Routes.rooms.node());
}
