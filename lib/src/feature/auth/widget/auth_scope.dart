import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/auth/model/auth_status.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthScope extends StatefulWidget {
  const AuthScope({super.key, required this.child});

  final Widget child;

  static AuthStatus of(BuildContext context) =>
      context.inheritedOf<_AuthInherited>().authStatus;

  @override
  State<AuthScope> createState() => _AuthScopeState();
}

class _AuthScopeState extends State<AuthScope> {
  late final AuthBloc _authBloc = AppScope.of(context).authBloc;

  @override
  Widget build(BuildContext context) => BlocBuilder<AuthBloc, AuthState>(
        bloc: _authBloc,
        builder: (context, state) {
          return _AuthInherited(
            child: widget.child,
            authStatus: state.authStatus,
          );
        },
      );
}

class _AuthInherited extends InheritedWidget {
  const _AuthInherited({
    required super.child,
    required this.authStatus,
  });

  final AuthStatus authStatus;

  @override
  bool updateShouldNotify(covariant _AuthInherited oldWidget) =>
      oldWidget.authStatus != authStatus;
}
