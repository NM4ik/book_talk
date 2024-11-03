import 'package:book_talk/src/feature/account/bloc/account_bloc.dart';
import 'package:book_talk/src/feature/account/widget/account_scope.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const double avatarSize = 35;

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    this.size = avatarSize,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    final accountBloc = AccountScope.of(context).accountBloc;

    return BlocBuilder<AccountBloc, AccountState>(
      bloc: accountBloc,
      builder: (context, state) {
        final user = state.user;
        Widget? child;
        if (user != null) {
          child = ClipOval(
            child: CachedNetworkImage(
              imageUrl: user.avatar,
            ),
          );
        }

        return SizedBox(
          width: size,
          height: size,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey,
            ),
            child: child,
          ),
        );
      },
    );
  }
}
