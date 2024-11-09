import 'package:book_talk/src/common/router/routes.dart';
import 'package:book_talk/src/common/widgets/user_avatar_widget.dart';
import 'package:book_talk/src/common/widgets/shimmer.dart';
import 'package:book_talk/src/common/widgets/window_size.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk/src/feature/rooms/bloc/rooms_bloc.dart';
import 'package:book_talk/src/feature/rooms/model/room.dart';
import 'package:book_talk/src/feature/rooms/widget/rooms_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/octopus.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    super.initState();
    AppScope.of(context).roomsBloc.add(const RoomsEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _RoomsScrollView(),
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
        child: UserAvatarWidget(
          size: 30,
        ),
      ),
    );
  }
}

class _RoomsScrollView extends StatelessWidget {
  const _RoomsScrollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text('Rooms'),
          trailing: _AvatarTrailingButton(),
        ),
        BlocBuilder<RoomsBloc, RoomsState>(
          bloc: RoomsScope.of(context),
          builder: (context, state) {
            return SliverPadding(
              padding: const EdgeInsets.all(20),
              sliver: _RoomsGridView(rooms: state.rooms),
            );
          },
        ),
      ],
    );
  }
}

class _RoomsGridView extends StatelessWidget {
  const _RoomsGridView({Key? key, this.rooms}) : super(key: key);

  final List<Room>? rooms;

  @override
  Widget build(BuildContext context) {
    bool isLoading = rooms == null;

    final windowSize = WindowSizeScope.of(context);
    final windowWidth = MediaQuery.sizeOf(context).width;
    final double spacing = windowSize.isLargeFormat ? 20 : 10;
    final crossAxisCount = windowSize.isLargeFormat
        ? 3
        : windowWidth < 650
            ? 1
            : 2;

    return SliverGrid.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: windowWidth / 3 / 100 / crossAxisCount + 0.8,
        mainAxisSpacing: spacing,
        crossAxisSpacing: spacing,
      ),
      itemCount: isLoading ? 10 : (rooms?.length ?? 0),
      itemBuilder: (context, index) {
        if (isLoading) {
          return Shimmer(
            size: Size.infinite,
            backgroundColor: Colors.grey[600],
            color: Colors.black,
          );
        }

        final room = rooms?[index];
        if (room == null) return const SizedBox();

        return _RoomCard(room: room);
      },
    );
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room, Key? key}) : super(key: key);

  final Room room;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.hardEdge,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: ColoredBox(
        color: Theme.of(context).colorPalette?.secondary ?? Colors.transparent,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 2.7 / 4,
              child: CachedNetworkImage(
                imageUrl: room.avatar,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UiText.titleSmall(room.name),
                    const SizedBox(height: 10),
                    UiText.bodyMedium(
                      'Вместимость: ${room.capacity}',
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              UiText.labelMedium(
                                room.openTime + ' - ' + room.closeTime,
                              ),
                              GestureDetector(
                                onTap: () => Octopus.of(context).setState(
                                  (state) => state
                                    ..removeByName(Routes.roomDetail.name)
                                    ..add(
                                      Routes.roomDetail.node(
                                        arguments: {'id': room.id.toString()},
                                      ),
                                    ),
                                ),
                                child: const Icon(
                                  CupertinoIcons.settings,
                                  size: 20,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
