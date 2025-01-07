import 'package:bloc/bloc.dart';
import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/common/model/room/room_day_setting.dart';
import 'package:book_talk/src/feature/room_detail/data/room_detail_repository.dart';
import 'package:book_talk/src/feature/room_detail/data/room_image_repository.dart';
import 'package:book_talk/src/feature/room_detail/model/file_image.dart';
part 'room_detail_event.dart';
part 'room_detail_state.dart';

/// Bloc for managing room details state.
final class RoomDetailBloc extends Bloc<RoomDetailEvent, RoomDetailState> {
  RoomDetailBloc({
    required IRoom? room,
    required RoomImageRepository roomImageRepository,
    required RoomDetailRepository roomDetailRepository,
  })  : _roomImageRepository = roomImageRepository,
        _roomDetailRepository = roomDetailRepository,
        super(
          RoomDetailState.idle(
            room: room == null ? const EmptyRoom() : room,
          ),
        ) {
    on<RoomDetailEvent>(
      (event, emitter) => switch (event) {
        _RoomDetailChangeActiveEvent() =>
          _onChangeRoomActiveEvent(event, emitter),
        _RoomDetailChangeCapacityEvent() =>
          _onChangeRoomCapacityEvent(event, emitter),
        _RoomDetailChangeTitleEvent() =>
          _onChangeRoomTitleEvent(event, emitter),
        _RoomDetailChangeDayActiveEvent() =>
          _onChangeDayActiveEvent(event, emitter),
        _RoomDetailChangeTimeEvent() => _onChangeTimeEvent(event, emitter),
        _RoomDetailPickImageEvent() => _onPickImageEvent(event, emitter),
        _CreateRoomEvent() => _onCreateRoomEvent(event, emitter),
        _EditRoomEvent() => _onEditRoomEvent(event, emitter),
        _DeleteRoomEvent() => _onDeleteRoomEvent(event, emitter),
      },
    );
  }

  final RoomImageRepository _roomImageRepository;
  final RoomDetailRepository _roomDetailRepository;

  /// Toggles the room's active state.
  void _onChangeRoomActiveEvent(
    _RoomDetailChangeActiveEvent event,
    Emitter<RoomDetailState> emitter,
  ) {
    setRoomState(state, state.room.copyWith(isActive: event.isActive));
  }

  /// Updates the room's capacity, clamped to valid limits.
  void _onChangeRoomCapacityEvent(
    _RoomDetailChangeCapacityEvent event,
    Emitter<RoomDetailState> emitter,
  ) {
    setRoomState(
      state,
      state.room.copyWith(
        capacity: event.count.clamp(0, IRoom.roomMaxCapacity),
      ),
    );
  }

  /// Updates the room's title.
  void _onChangeRoomTitleEvent(
    _RoomDetailChangeTitleEvent event,
    Emitter<RoomDetailState> emitter,
  ) {
    setRoomState(state, state.room.copyWith(name: event.value));
  }

  /// Toggles the active state of a specific day in the room's week settings.
  void _onChangeDayActiveEvent(
    _RoomDetailChangeDayActiveEvent event,
    Emitter<RoomDetailState> emitter,
  ) {
    final updatedDays = state.room.roomWeekSettings.days.map((setting) {
      if (setting.priority == event.day.priority) {
        return setting.toggleActive(value: event.value);
      }

      return setting;
    }).toList();

    setRoomState(
      state,
      state.room.copyWith(
        roomWeekSettings: state.room.roomWeekSettings.copyWith(
          days: updatedDays,
        ),
      ),
    );
  }

  void _onChangeTimeEvent(
    _RoomDetailChangeTimeEvent event,
    Emitter<RoomDetailState> emitter,
  ) {
    final updatedDays = state.room.roomWeekSettings.days.map((setting) {
      if (setting == event.day) {
        return event.isStartTimeChange
            ? setting.changeStartTime(hour: event.hour, minute: event.minute)
            : setting.changeEndTime(hour: event.hour, minute: event.minute);
      }

      return setting;
    }).toList();

    setRoomState(
      state,
      state.room.copyWith(
        roomWeekSettings: state.room.roomWeekSettings.copyWith(
          days: updatedDays,
        ),
      ),
    );
  }

  /// TODO(Mikhailov):
  /// Think about it - loading state
  ///
  /// Make script-comment for new laptop
  Future<void> _onPickImageEvent(
    _RoomDetailPickImageEvent event,
    Emitter<RoomDetailState> emitter,
  ) async {
    try {
      final FileImage? pickedImage =
          await _roomImageRepository.pickImageFromGallery();
      final IRoom room = state.room;

      if (pickedImage == null || room is! EmptyRoom) return;
      setRoomState(state, (room).copyWith(fileImage: pickedImage));
    } on Object catch (e, st) {
      onError(e, st);
      emitter(RoomDetailState.error(room: state.room, message: e.toString()));
    }
  }

  Future<void> _onCreateRoomEvent(
    _CreateRoomEvent event,
    Emitter<RoomDetailState> emitter,
  ) async {
    if (state is _RoomDetailProcessingState) return;

    try {
      emitter(RoomDetailState.processing(room: state.room));
      await _roomDetailRepository.createRoom(state.room as EmptyRoom);
      emitter(RoomDetailState.success(room: state.room));
    } on Object catch (e, st) {
      onError(e, st);
      emitter(RoomDetailState.error(room: state.room, message: e.toString()));
    }
  }

  Future<void> _onEditRoomEvent(
    _EditRoomEvent event,
    Emitter<RoomDetailState> emitter,
  ) async {
    if (state is _RoomDetailProcessingState) return;

    try {
      emitter(RoomDetailState.processing(room: state.room));
      await _roomDetailRepository.editRoom(state.room as Room);
      emitter(RoomDetailState.success(room: state.room));
    } on Object catch (e, st) {
      onError(e, st);
      emitter(RoomDetailState.error(room: state.room, message: e.toString()));
    }
  }

  Future<void> _onDeleteRoomEvent(
    _DeleteRoomEvent event,
    Emitter<RoomDetailState> emitter,
  ) async {
    if (state is _RoomDetailProcessingState) return;

    try {
      emitter(RoomDetailState.processing(room: state.room));
      await _roomDetailRepository.deleteRoom(state.room as Room);
      emitter(RoomDetailState.success(room: state.room));
    } on Object catch (e, st) {
      onError(e, st);
      emitter(RoomDetailState.error(room: state.room, message: e.toString()));
    }
  }
}

/// Simplifies updating the room state.
extension on Emittable<RoomDetailState> {
  void setRoomState(RoomDetailState state, IRoom room) {
    emit(state.copyWith(room: room));
  }
}
