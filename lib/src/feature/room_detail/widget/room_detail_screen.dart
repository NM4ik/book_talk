import 'package:book_talk/common.dart';
import 'package:book_talk/generated/l10n.dart';
import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/common/widgets/notifications.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk/src/feature/bootstrap/widget/sized_box.dart';
import 'package:book_talk/src/feature/room_detail/bloc/room_detail_bloc.dart';
import 'package:book_talk/src/feature/room_detail/widget/room_detail_capacity.dart';
import 'package:book_talk/src/feature/room_detail/widget/room_detail_image.dart';
import 'package:book_talk/src/feature/room_detail/widget/room_detail_scope.dart';
import 'package:book_talk/src/feature/room_detail/widget/room_detail_weekday.dart';
import 'package:book_talk/src/feature/rooms/bloc/rooms_bloc.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:octopus/octopus.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({
    super.key,
    required this.id,
  });

  final Object? id;

  @override
  Widget build(BuildContext context) {
    final roomId = switch (id) {
      int id => id,
      String id => int.tryParse(id),
      _ => null,
    };

    final room = AppScope.of(context).roomsBloc.state.rooms?.firstWhereOrNull(
          (Room? room) => room?.id == roomId,
        );

    return RoomDetailScope(
      room: room,
      child: Scaffold(
        appBar: CupertinoNavigationBar(
          leading: Theme.of(context)
              .actionIconTheme!
              .backButtonIconBuilder!(context),
          middle: UiText.titleMedium(
            room == null
                ? S.of(context).roomCreateTitle
                : S.of(context).roomEditTitle,
          ),
        ),
        body: const _RoomDetailStateListener(
          child: _RoomDetail(),
        ),
      ),
    );
  }
}

class _RoomDetail extends StatelessWidget {
  const _RoomDetail();

  @override
  Widget build(BuildContext context) {
    final windowSize = WindowSizeScope.of(context);
    final roomDetailBloc = RoomDetailScope.of(context);

    return SingleChildScrollView(
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(
              windowSize.map(
                compact: (_) => 10,
                medium: (_) => 20,
                large: (_) => 40,
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: windowSize.maybeMap(
                  orElse: () => double.infinity,
                  large: ($large) => $large.minWidth,
                ),
              ),
              child: BlocBuilder<RoomDetailBloc, RoomDetailState>(
                bloc: roomDetailBloc,
                builder: (context, state) {
                  final room = state.room;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// room image
                      RoomDetailImageWidget(room: room),

                      // if (viewSize.width < 700)
                      //   RoomDetailImageWidget(room: room)
                      // else
                      //   Row(
                      //     children: [
                      //       Expanded(child: RoomDetailImageWidget(room: room)),
                      //       const SizedBox(width: 20),
                      //       const Expanded(child: _DragNDrop()),
                      //     ],
                      //   ),

                      /// room title
                      const _RoomTitle(),

                      UiBox.hGap(),

                      /// room capacity
                      const RoomCapacitySelector(),

                      UiBox.hGap(),

                      /// room available
                      const _RoomAvailableToggle(),

                      UiBox.hGap(),

                      /// room weekday
                      const Padding(
                        padding: EdgeInsets.only(bottom: 40),
                        child: RoomDetailWeekdayWidget(),
                      ),

                      /// control buttons
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 500),
                        child: Row(
                          children: [
                            const Expanded(flex: 2, child: _SaveRoomButton()),
                            if (room is Room) ...[
                              const SizedBox(width: 20),
                              const Expanded(
                                flex: 1,
                                child: const _DeleteRoomButton(),
                              ),
                            ]
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoomTitle extends StatefulWidget {
  const _RoomTitle();

  @override
  State<_RoomTitle> createState() => _RoomTitleState();
}

class _RoomTitleState extends State<_RoomTitle> {
  late final TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: RoomDetailScope.of(context, listen: false).state.room.name,
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: UiTextField.standart(
        controller: _textEditingController,
        hintText: S.of(context).title,
        onChanged: (value) {
          RoomDetailScope.of(context)
              .add(RoomDetailEvent.changeTitle(value: value));
        },
      ),
    );
  }
}

class _RoomAvailableToggle extends StatelessWidget {
  const _RoomAvailableToggle();

  @override
  Widget build(BuildContext context) {
    final roomDetailBloc = RoomDetailScope.of(context);

    return BlocBuilder<RoomDetailBloc, RoomDetailState>(
      bloc: roomDetailBloc,
      buildWhen: (previous, current) =>
          previous.room.isActive != current.room.isActive,
      builder: (context, state) {
        final isActive = state.room.isActive;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UiText.labelMedium(S.of(context).roomIsActiveStatus),
                const SizedBox(width: 5),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: UiBox.colored(
                    key: ValueKey(isActive),
                    color: isActive ? Colors.green : null,
                  ),
                ),
              ],
            ),
            UiDivider(margin: const EdgeInsets.only(bottom: 5)),
            Switch(
              value: isActive,
              onChanged: (value) => roomDetailBloc.add(
                RoomDetailEvent.changeActive(isActive: value),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _DeleteRoomButton extends StatelessWidget {
  const _DeleteRoomButton();

  @override
  Widget build(BuildContext context) {
    return UiButton.filledDesctructive(
      label: UiText.bodyMedium('Delete'),
      onPressed: () async {
        final isConfirmed = await SnackManager.confirm(context, message: '123');

        if (isConfirmed ?? false) {
          RoomDetailScope.of(context).add(const RoomDetailEvent.deleteRoom());
        }
      },
    );
  }
}

class _SaveRoomButton extends StatelessWidget {
  const _SaveRoomButton();

  @override
  Widget build(BuildContext context) {
    return UiButton.filledPrimary(
      label: UiText.bodyMedium('Save'),
      onPressed: () {
        final RoomDetailBloc roomDetailBloc = RoomDetailScope.of(context);
        roomDetailBloc.add(
          roomDetailBloc.state.room is Room
              ? const RoomDetailEvent.editRoom()
              : const RoomDetailEvent.createRoom(),
        );
      },
    );
  }
}

/// {@template room_detail_screen}
/// _RoomDetailStateListener widget.
/// {@endtemplate}
class _RoomDetailStateListener extends StatelessWidget {
  /// {@macro room_detail_screen}
  const _RoomDetailStateListener({
    required this.child, // ignore: unused_element
  });

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      BlocListener<RoomDetailBloc, RoomDetailState>(
        bloc: RoomDetailScope.of(context),
        listener: (context, state) {
          state.$maybeWhen(
            orElse: () {},
            error: (message) {
              if (message != null)
                SnackManager.error(context, message: message);
            },
            success: () {
              SnackManager.success(
                context,
                message: 'Room was successfully created',
              );

              AppScope.of(context).roomsBloc.add(const RoomsEvent.load());
              Octopus.of(context).setState(
                (state) {
                  state
                    ..clear()
                    ..putIfAbsent(
                      Routes.rooms.name,
                      () => Routes.rooms.node(),
                    );

                  return state;
                },
              );
            },
          );
        },
        child: child,
      );
}
