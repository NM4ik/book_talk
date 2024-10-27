import 'package:book_talk/src/feature/auth/widget/login_screen.dart';
import 'package:book_talk/src/feature/home/widget/home_screen.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:octopus/octopus.dart';

enum Routes with OctopusRoute {
  signin('signin', title: 'SignIn'),
  home('home', title: 'Home');

  const Routes(this.name, {this.title});

  @override
  final String name;

  @override
  final String? title;

  @override
  Widget builder(BuildContext context, OctopusState state, OctopusNode node) =>
      switch (this) {
        Routes.signin => LoginScreen(),
        Routes.home => HomeScreen(),
      };
}
