import 'package:book_talk/src/common/utils/extensions/build_context_extension.dart';
import 'package:book_talk/src/feature/bootstrap/widget/app_scope.dart';
import 'package:book_talk/src/feature/rooms/bloc/rooms_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomsScope extends StatefulWidget {
  const RoomsScope({
    super.key,
    required this.child,
  });

  final Widget child;

  static RoomsBloc of(BuildContext context) =>
      context.inheritedOf<_InheritedRoomsScope>().roomsBloc;

  @override
  State<RoomsScope> createState() => _RoomsScopeState();
}

class _RoomsScopeState extends State<RoomsScope> {
  late final RoomsBloc _roomsBloc;

  @override
  void initState() {
    super.initState();
    _roomsBloc = RoomsBloc(
      const RoomsState.idle(rooms: null),
      roomsRepository: AppScope.of(context).roomsRepository,
    )..add(const RoomsEvent.load());
  }

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
