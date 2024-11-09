import 'package:book_talk/src/common/widgets/window_size.dart';
import 'package:book_talk/src/feature/rooms/model/room.dart';
import 'package:book_talk/src/feature/rooms/widget/rooms_scope.dart';
import 'package:book_talk_ui/book_talk_ui.dart';
import 'package:cached_network_image/cached_network_image.dart';
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

    child = room == null ? const _RoomNotFound() : _RoomDetail(room: room);

    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: UiText.titleMedium('Room Detail'),
      ),
      body: child,
    );
  }
}

class _RoomDetail extends StatelessWidget {
  const _RoomDetail({required this.room});

  final Room room;

  @override
  Widget build(BuildContext context) {
    final windowSize = WindowSizeScope.of(context);
    final viewSize = MediaQuery.sizeOf(context);
    print('windowSize - ${windowSize.maxWidth}');

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: windowSize.maybeMap(
                orElse: () => double.infinity,
                large: ($large) => $large.minWidth,
              ),
            ),
            child: Column(
              children: [
                if (viewSize.width < 700)
                  _RoomImage(avatar: room.avatar)
                else
                  Row(
                    children: [
                      Expanded(child: _RoomImage(avatar: room.avatar)),

                      const SizedBox(width: 20),

                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    border: Border.fromBorderSide(
                                      BorderSide(
                                        width: 4,
                                        color: Theme.of(context)
                                                .colorPalette
                                                ?.primary ??
                                            Colors.transparent,
                                      ),
                                    ),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.cloud_upload, size: 32),
                                      UiText.titleLarge(
                                        'Drag and drop image',
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: UiButton.filledPrimary(
                                    onPressed: () {},
                                    label: UiText.bodyMedium('Choose image'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const Spacer(),
                    ],
                  ),
              

                 const Padding(
                   padding: EdgeInsets.only(top: 40),
                   child: UiTextField.standart(
                    hintText: 'Name',
                   ),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RoomImage extends StatelessWidget {
  const _RoomImage({required this.avatar});

  final String avatar;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: CachedNetworkImage(
        imageUrl: avatar,
        fit: BoxFit.cover,
      ),
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
