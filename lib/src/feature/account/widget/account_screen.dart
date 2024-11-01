import 'package:book_talk/src/common/widgets/user_avatar_widget.dart';
import 'package:book_talk/src/feature/account/bloc/account_bloc.dart';
import 'package:book_talk/src/feature/account/widget/account_scope.dart';
import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountScope.of(context).accountBloc;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        top: false,
        minimum: const EdgeInsets.only(bottom: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const UserAvatarWidget(),
                  const SizedBox(width: 20),
                  BlocBuilder<AccountBloc, AccountState>(
                    bloc: accountBloc,
                    builder: (context, state) {
                      return Text(state.user?.name ?? '');
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            UiButton.negativePrimary(
              onPressed: () => _onLogout(context),
              label: const Text(
                'LogOut',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onLogout(BuildContext context) {
    print('Logout');
    AppScope.of(context).authBloc.add(AuthEvent.signOut());
  }
}
