import 'package:book_talk/src/common/router/routes.dart';
import 'package:book_talk/src/common/widgets/user_avatar_widget.dart';
import 'package:flutter/material.dart';
import 'package:octopus/octopus.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Home'),
        actions: [
          const _AvatarTrailingButton(),
        ],
      ),
    );
  }
}

class _AvatarTrailingButton extends StatelessWidget {
  const _AvatarTrailingButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.octopus.push(Routes.account),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: UserAvatarWidget(),
      ),
    );
  }
}
