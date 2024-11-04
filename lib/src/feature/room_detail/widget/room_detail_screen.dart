import 'package:book_talk/src/common/widgets/window_size.dart';
import 'package:book_talk/src/feature/rooms/widget/rooms_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomDetailScreen extends StatelessWidget {
  const RoomDetailScreen({
    super.key,
    required this.id,
  });

  final Object? id;

  @override
  Widget build(BuildContext context) {
    final Widget child;
    final roomId = switch (id) {
      int id => id,
      String id => int.tryParse(id),
      _ => null,
    };
    final room = RoomsScope.getById(context, roomId);

    child = room == null
        ? const _RoomNotFound()
        : Align(child: Text('id - $roomId'));

    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: UiText.titleMedium('Room Detail'),
      ),
      body: child,
    );
  }
}

class _RoomNotFound extends StatelessWidget {
  const _RoomNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notFoundText = 'Room not found';

    return Center(
      child: WindowSizeScope.of(context).maybeMap(
        compact: (_) => UiText.titleMedium(notFoundText),
        orElse: () => UiText.headlineMedium(notFoundText),
      ),
    );
  }
}
