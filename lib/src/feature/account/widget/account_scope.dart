import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:book_talk/src/feature/account/bloc/account_bloc.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScope extends StatefulWidget {
  const AccountScope({
    required this.child,
    super.key,
  });

  final Widget child;

  static AccountBloc of(BuildContext context) =>
      context.inheritedOf<_InheritedAccountScope>().accountBloc;

  @override
  State<AccountScope> createState() => _AccountScopeState();
}

class _AccountScopeState extends State<AccountScope> {
  late final AccountBloc _accountBloc;

  @override
  void initState() {
    _accountBloc = AppScope.of(context).accountBloc..add(AccountEvent.load());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountBloc, AccountState>(
      bloc: _accountBloc,
      builder: (context, state) {
        return _InheritedAccountScope(
          accountBloc: _accountBloc,
          child: widget.child,
        );
      },
    );
  }
}

class _InheritedAccountScope extends InheritedWidget {
  final AccountBloc accountBloc;

  const _InheritedAccountScope({
    required super.child,
    required this.accountBloc,
  });

  @override
  bool updateShouldNotify(covariant _InheritedAccountScope oldWidget) =>
      oldWidget.accountBloc != accountBloc;
}
