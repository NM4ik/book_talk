import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:book_talk/src/feature/room_detail/bloc/room_detail_bloc.dart';
import 'package:book_talk/src/feature/room_detail/data/room_detail_repository.dart';
import 'package:book_talk/src/feature/room_detail/data/room_image_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomDetailScope extends StatefulWidget {
  const RoomDetailScope({
    super.key,
    required this.room,
    required this.child,
  });

  static RoomDetailBloc of(BuildContext context, {bool listen = true}) =>
      context.inheritedOf<_InhertiedRoomScope>(listen: listen).roomDetailBloc;

  final Room? room;
  final Widget child;

  @override
  State<RoomDetailScope> createState() => _RoomDetailScopeState();
}

class _RoomDetailScopeState extends State<RoomDetailScope> {
  late final RoomDetailBloc _roomDetailBloc = RoomDetailBloc(
    room: widget.room,
    roomImageRepository: RoomImageRepositoryImpl(),
    roomDetailRepository: RoomDetailRepositoryImpl(),
  );

  @override
  void dispose() {
    _roomDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _roomDetailBloc,
      builder: (context, state) => _InhertiedRoomScope(
        child: widget.child,
        roomDetailBloc: _roomDetailBloc,
      ),
    );
  }
}

class _InhertiedRoomScope extends InheritedWidget {
  const _InhertiedRoomScope({
    required super.child,
    required this.roomDetailBloc,
  });

  final RoomDetailBloc roomDetailBloc;

  @override
  bool updateShouldNotify(covariant _InhertiedRoomScope oldWidget) =>
      roomDetailBloc != oldWidget.roomDetailBloc;
}
