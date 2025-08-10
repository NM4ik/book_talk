import 'package:book_talk/l10n/app_localizations.dart';
import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/common/model/room/room_day_setting.dart';
import 'package:book_talk/src/common/router/routes.dart';
import 'package:book_talk/src/common/widgets/bloc_builder.dart';
import 'package:book_talk/src/common/widgets/image.dart';
import 'package:book_talk/src/common/widgets/shimmer.dart';
import 'package:book_talk/src/common/widgets/user_avatar_widget.dart';
import 'package:book_talk/src/common/widgets/window_size.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk/src/feature/rooms/bloc/rooms_bloc.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/octopus.dart';

/// {@template rooms_screen}
/// _RoomsScreen widget.
/// {@endtemplate}
class RoomsScreen extends StatefulWidget {
  /// {@macro rooms_screen}
  const RoomsScreen({
    super.key, // ignore: unused_element
  });

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

/// State for widget _RoomsScreen.
class _RoomsScreenState extends State<RoomsScreen> {
  /* #region Lifecycle */
  @override
  void initState() {
    super.initState();
    AppScope.of(context).roomsBloc.add(const RoomsEvent.load());
  }
  /* #endregion */

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: CustomScrollView(
            slivers: [
              const CupertinoSliverNavigationBar(
                largeTitle: _NavigationTitle(),
                trailing: _AvatarTrailingButton(),
              ),
              BlocBuilder<RoomsBloc, RoomsState>(
                bloc: AppScope.of(context).roomsBloc,
                builder: (context, state) {
                  final List<Room>? rooms = state.rooms;
                  if (rooms != null) {
                    return _RoomsGrid(rooms: rooms);
                  }

                  if (state.isProcessing) {
                    return const _LoadingGrid();
                  }

                  return const _RoomsError();
                },
              ),
            ],
          ),
        ),
      );
}

class _NavigationTitle extends StatelessWidget {
  const _NavigationTitle();

  @override
  Widget build(BuildContext context) => Row(
      children: [
        Text(AppLocalizations.of(context)!.roomsTitle),
        const SizedBox(width: 10),
        const _CreateRoomButton(),
      ],
    );
}

class _AvatarTrailingButton extends StatelessWidget {
  const _AvatarTrailingButton();

  @override
  Widget build(BuildContext context) => GestureDetector(
      onTap: () => context.octopus.push(Routes.account),
      child: const UserAvatarWidget(
        size: 30,
      ),
    );
}

/// {@template rooms_screen}
/// _CreateRoomButton widget.
/// {@endtemplate}
class _CreateRoomButton extends StatelessWidget {
  /// {@macro rooms_screen}
  const _CreateRoomButton();

  @override
  Widget build(BuildContext context) => AnimatedBlocBuilder<RoomsBloc, RoomsState>(
      bloc: AppScope.of(context).roomsBloc,
      builder: (context, state) {
        final Widget child;

        if (state.isIdle) {
          child = GestureDetector(
            onTap: () => _onRoomEdit(context, null),
            child: Icon(
              Icons.add_circle_rounded,
              color: Theme.of(context).colorPalette?.primary,
            ),
          );
        } else {
          child = const SizedBox.shrink();
        }

        return AnimatedSwitcher(
          duration: Durations.medium2,
          child: child,
        );
      },
    );
}

/// {@template rooms_screen}
/// _RoomsGrid widget.
/// {@endtemplate}
class _RoomsGrid extends StatelessWidget {
  /// {@macro rooms_screen}
  const _RoomsGrid({
    required this.rooms, // ignore: unused_element
  });

  final List<Room> rooms;

  @override
  Widget build(BuildContext context) => _GridBuilder(
        itemBuilder: (context, index) => _RoomCard(room: rooms[index]),
        itemCount: rooms.length,
      );
}

/// {@template rooms_screen}
/// _LoadingGrid widget.
/// {@endtemplate}
class _LoadingGrid extends StatelessWidget {
  /// {@macro rooms_screen}
  const _LoadingGrid();

  @override
  Widget build(BuildContext context) => _GridBuilder(
        itemBuilder: (context, index) => Shimmer(
            size: Size.infinite,
            backgroundColor: Colors.grey[600],
            color: Colors.black,
          ),
        itemCount: 9,
      );
}

class _GridBuilder extends StatelessWidget {
  const _GridBuilder({
    required this.itemBuilder,
    required this.itemCount,
  });

  final Widget? Function(BuildContext, int) itemBuilder;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final windowSize = WindowSizeScope.of(context);
    final windowWidth = MediaQuery.sizeOf(context).width;
    final double spacing = windowSize.isLargeFormat ? 20 : 10;
    final crossAxisCount = windowSize.isLargeFormat
        ? 3
        : windowWidth < 650
            ? 1
            : 2;

    return SliverPadding(
      padding: const EdgeInsets.only(top: 20),
      sliver: SliverGrid.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          childAspectRatio: windowWidth / 3 / 100 / crossAxisCount + 0.8,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}

class _RoomCard extends StatelessWidget {
  const _RoomCard({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final int weekDay = DateTime.now().weekday - 1;
    final RoomWeekdaySetting currentWeekDay =
        room.roomWeekSettings.days[weekDay];

    return UiButton.common(
      onPressed: () {
        Octopus.of(context).push(
          Routes.booking,
          arguments: {'room-id': room.id.toString()},
        );
      },
      bgColor: Theme.of(context).colorPalette?.secondary,
      hoverColor: Theme.of(context).colorPalette?.muted,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          AspectRatio(
            aspectRatio: 2.7 / 4,
            child: CachedNetworkImage.url(
              url: room.avatar,
              boxFit: BoxFit.cover,
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

                  // TODO(Mikhailov): localize
                  UiText.bodyMedium('Capacity: ${room.capacity}'),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // TODO(mikhailov): make open time.
                            // refactor
                            UiText.labelMedium(
                              '${currentWeekDay.startTime.format(context)} - ${currentWeekDay.endTime.format(context)}',
                            ),
                            GestureDetector(
                              onTap: () => _onRoomEdit(context, room),
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
    );
  }
}

void _onRoomEdit(BuildContext context, Room? room) {
  Octopus.of(context).setState((state) => state
    ..removeByName(Routes.roomDetail.name)
    ..add(
      Routes.roomDetail.node(
        arguments: {
          if (room != null) 'id': room.id.toString(),
        },
      ),
    ));
}

/// {@template rooms_screen}
/// _RoomsError widget.
/// {@endtemplate}
class _RoomsError extends StatelessWidget {
  /// {@macro rooms_screen}
  const _RoomsError();

  @override
  Widget build(BuildContext context) => SliverFillRemaining(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiText.titleMedium(
              AppLocalizations.of(context)!.errorSomethingWentWrong,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            UiText.bodySmall(
              AppLocalizations.of(context)!.retryOrLater,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 25),
            UiButton.filledPrimary(
              onPressed: () {
                AppScope.of(context).roomsBloc.add(const RoomsEvent.load());
              },
              label: UiText.bodyMedium(AppLocalizations.of(context)!.tryAgain),
              innerPadding:
                  const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
            ),
          ],
        ),
      );
}
