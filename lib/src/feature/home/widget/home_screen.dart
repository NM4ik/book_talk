import 'package:book_talk/src/feature/auth/bloc/auth_bloc.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppScope.of(context).authBloc.add(AuthEvent.signOut());
      },
      child: Text('logot'),
    );
  }
}
