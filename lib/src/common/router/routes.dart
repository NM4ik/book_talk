import 'package:book_talk/src/feature/authentication/widget/signin_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  signin('signin', title: 'SignIn');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) =>
      switch (this) {
        Routes.signin => SignInScreen(),
      };
}
