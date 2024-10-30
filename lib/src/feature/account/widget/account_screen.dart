import 'package:book_talk/src/feature/account/widget/account_scope.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AccountScope.of(context).state.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(user?.name ?? '_EMPTY'),
      ),
    );
  }
}
