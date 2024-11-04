import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk/src/feature/rooms/bloc/rooms_bloc.dart';
import 'package:book_talk/src/feature/rooms/model/room.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:collection/collection.dart';

class RoomsScope extends StatefulWidget {
  const RoomsScope({
    super.key,
    required this.child,
  });

  final Widget child;

  static RoomsBloc of(BuildContext context) =>
      context.inheritedOf<_InheritedRoomsScope>(listen: false).roomsBloc;

  static Room? getById(BuildContext context, int? id) =>
      of(context).state.rooms?.firstWhereOrNull(
            (room) => room.id == id,
          );

  @override
  State<RoomsScope> createState() => _RoomsScopeState();
}

class _RoomsScopeState extends State<RoomsScope> {
  late final RoomsBloc _roomsBloc = AppScope.of(context).roomsBloc;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomsBloc, RoomsState>(
      bloc: _roomsBloc,
      builder: (context, state) {
        return _InheritedRoomsScope(
          child: widget.child,
          roomsBloc: _roomsBloc,
        );
      },
    );
  }
}

class _InheritedRoomsScope extends InheritedWidget {
  const _InheritedRoomsScope({
    Key? key,
    required super.child,
    required this.roomsBloc,
  }) : super(key: key);

  final RoomsBloc roomsBloc;

  @override
  bool updateShouldNotify(covariant _InheritedRoomsScope oldWidget) =>
      roomsBloc != oldWidget.roomsBloc;
}
