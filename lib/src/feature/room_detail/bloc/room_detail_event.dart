part of 'room_detail_bloc.dart';

sealed class RoomDetailEvent {
  const RoomDetailEvent();

  const factory RoomDetailEvent.changeActive({required bool isActive}) =
      _RoomDetailChangeActiveEvent;

  const factory RoomDetailEvent.changeCapacity({required int count}) =
      _RoomDetailChangeCapacityEvent;

  const factory RoomDetailEvent.changeTitle({required String value}) =
      _RoomDetailChangeTitleEvent;

  const factory RoomDetailEvent.changeTime({
    required RoomWeekdaySetting day,
    required int hour,
    required int minute,
    required bool isStartTimeChange,
  }) = _RoomDetailChangeTimeEvent;

  const factory RoomDetailEvent.changeDayActive({
    required RoomWeekdaySetting day,
    required bool value,
  }) = _RoomDetailChangeDayActiveEvent;

  const factory RoomDetailEvent.pickImage() = _RoomDetailPickImageEvent;

  const factory RoomDetailEvent.createRoom() = _CreateRoomEvent;

  const factory RoomDetailEvent.editRoom() = _EditRoomEvent;

  const factory RoomDetailEvent.deleteRoom() = _DeleteRoomEvent;
}

final class _RoomDetailChangeActiveEvent extends RoomDetailEvent {
  const _RoomDetailChangeActiveEvent({required this.isActive});

  final bool isActive;
}

final class _CreateRoomEvent extends RoomDetailEvent {
  const _CreateRoomEvent();
}

final class _EditRoomEvent extends RoomDetailEvent {
  const _EditRoomEvent();
}

final class _DeleteRoomEvent extends RoomDetailEvent {
  const _DeleteRoomEvent();
}

final class _RoomDetailChangeCapacityEvent extends RoomDetailEvent {
  const _RoomDetailChangeCapacityEvent({required this.count});

  final int count;
}

final class _RoomDetailChangeTitleEvent extends RoomDetailEvent {
  const _RoomDetailChangeTitleEvent({required this.value});

  final String value;
}

final class _RoomDetailChangeDayActiveEvent extends RoomDetailEvent {
  const _RoomDetailChangeDayActiveEvent({
    required this.value,
    required this.day,
  });

  final RoomWeekdaySetting day;
  final bool value;
}

final class _RoomDetailChangeTimeEvent extends RoomDetailEvent {
  const _RoomDetailChangeTimeEvent({
    required this.day,
    required this.hour,
    required this.minute,
    required this.isStartTimeChange,
  });

  final RoomWeekdaySetting day;
  final int hour;
  final int minute;
  final bool isStartTimeChange;
}

final class _RoomDetailPickImageEvent extends RoomDetailEvent {
  const _RoomDetailPickImageEvent();
}
