import 'package:book_talk/src/feature/rooms/data/rooms_repository.dart';
import 'package:book_talk/src/feature/rooms/model/room.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'rooms_state.dart';
part 'rooms_event.dart';

final class RoomsBloc extends Bloc<RoomsEvent, RoomsState> {
  RoomsBloc(
    super.initialState, {
    required RoomsRepository roomsRepository,
  }) : _roomsRepository = roomsRepository {
    on<RoomsEvent>(
      (event, emitter) => switch (event) {
        _RoomsLoadEvent() => _onLoadEvent(event, emitter),
      },
    );
  }

  final RoomsRepository _roomsRepository;

  Future<void> _onLoadEvent(
    _RoomsLoadEvent event,
    Emitter<RoomsState> emitter,
  ) async {
    emitter(RoomsState.processing(rooms: state.rooms));

    try {
      final rooms = await _roomsRepository.fetchRooms();
      emitter(RoomsState.idle(rooms: rooms));

      // TODO(mikhailov): handle repository exceptions.
    } on Object catch (error, st) {
      emitter(RoomsState.error(rooms: null, error: error));
      onError(error, st);
    }
  }
}
