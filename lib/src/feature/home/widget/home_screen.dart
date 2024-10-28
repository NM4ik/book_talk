import 'package:book_talk/src/feature/account/widget/account_scope.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AccountScope(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('Home'),
          actions: [
            _AvatarTrailingButton(),
          ],
        ),
      ),
    );
  }
}

class _AvatarTrailingButton extends StatelessWidget {
  const _AvatarTrailingButton();

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountScope.of(context);

    return StreamBuilder(
      stream: accountBloc.userStream,
      initialData: accountBloc.state.user,
      builder: (context, snapshot) {
        final user = snapshot.data;

        print('user - $user');

        Widget? child;
        if (user != null) {
          child = ClipOval(
            child: CachedNetworkImage(
              imageUrl: user.avatar,
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SizedBox(
            width: 35,
            height: 35,
            child: DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
              child: child,
            ),
          ),
        );

        // return Text(
        //   'snapshot - ${snapshot.data}, state - ${snapshot.connectionState},'
        //   'hasData = ${snapshot.hasData}',
        // );
      },
    );
  }
}
