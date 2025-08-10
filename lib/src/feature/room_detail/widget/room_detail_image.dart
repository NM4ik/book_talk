import 'dart:io';

import 'package:book_talk/generated/assets.gen.dart';
import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/feature/room_detail/bloc/room_detail_bloc.dart';
import 'package:book_talk/src/feature/room_detail/widget/room_detail_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoomDetailImageWidget extends StatelessWidget {
  const RoomDetailImageWidget({required this.room, super.key});

  final IRoom room;

  @override
  Widget build(BuildContext context) {
    final Widget child;

    if (room is EmptyRoom) {
      child = _EmptyRoomImage(emptyRoom: room as EmptyRoom);
    } else {
      final avatar = (room as Room).avatar;

      child = avatar == null
          ? const _RoomPlaceholderImage()
          : CachedNetworkImage(imageUrl: avatar, fit: BoxFit.cover);
    }

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        clipBehavior: Clip.hardEdge,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: Theme.of(context).colorPalette!.primary,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _EmptyRoomImage extends StatelessWidget {
  const _EmptyRoomImage({
    required this.emptyRoom,
  });

  final EmptyRoom emptyRoom;

  @override
  Widget build(BuildContext context) {
    final fileImage = emptyRoom.fileImage;

    if (fileImage != null) {
      return Image.file(
        File(fileImage.path),
        fit: BoxFit.cover,
      );
    }

    // return const _RoomPlaceholderImage();

    return UiButton.negativePrimary(
      onPressed: () {
        RoomDetailScope.of(context).add(const RoomDetailEvent.pickImage());
      },
      label: Row(
        children: [
          const SizedBox(width: 20),
          const Icon(
            Icons.image,
            size: 70,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO(Mikhailov): localize
              UiText.titleSmall(
                // S.of(context).roomSelectImage,
                'Select',
              ),
              UiText.titleSmall(
                // S.of(context).roomSelectImage,
                'Image',
              ),
            ],
          ),
        ],
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }
}

class _RoomPlaceholderImage extends StatelessWidget {
  const _RoomPlaceholderImage();

  @override
  Widget build(BuildContext context) => Stack(
      fit: StackFit.expand,
      children: [
        Assets.images.meetingRoomPlaceholder.image(fit: BoxFit.cover),
        const Placeholder(),
      ],
    );
}
