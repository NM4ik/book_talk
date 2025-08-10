part of 'room_detail_bloc.dart';

@immutable
sealed class RoomDetailState {
  const RoomDetailState({required this.room});

  const factory RoomDetailState.idle({required IRoom room}) =
      _RoomDetailIdleState;

  const factory RoomDetailState.processing({required IRoom room}) =
      _RoomDetailProcessingState;

  const factory RoomDetailState.error({required IRoom room, String? message}) =
      _RoomDetailErrorState;

  const factory RoomDetailState.success({required IRoom room}) =
      _RoomDetailSuccessState;

  final IRoom room;

  RoomDetailState copyWith({IRoom? room});

  void $maybeWhen({
    required void Function() orElse,
    void Function()? idle,
    void Function()? processing,
    void Function(String? message)? error,
    void Function()? success,
  }) {
    if (error != null && this is _RoomDetailErrorState) {
      return error((this as _RoomDetailErrorState).message);
    } else if (idle != null && this is _RoomDetailIdleState) {
      return idle();
    } else if (processing != null && this is _RoomDetailProcessingState) {
      return processing();
    } else if (success != null && this is _RoomDetailSuccessState) {
      return success();
    }

    return orElse();
  }
}

final class _RoomDetailSuccessState extends RoomDetailState {
  const _RoomDetailSuccessState({required super.room});

  @override
  int get hashCode => room.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _RoomDetailSuccessState && room == other.room;
  }

  @override
  _RoomDetailSuccessState copyWith({IRoom? room}) =>
      _RoomDetailSuccessState(room: room ?? this.room);
}

final class _RoomDetailIdleState extends RoomDetailState {
  const _RoomDetailIdleState({required super.room});

  @override
  int get hashCode => room.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _RoomDetailIdleState && room == other.room;
  }

  @override
  RoomDetailState copyWith({IRoom? room}) =>
      _RoomDetailIdleState(room: room ?? this.room);
}

final class _RoomDetailProcessingState extends RoomDetailState {
  const _RoomDetailProcessingState({required super.room});

  @override
  int get hashCode => room.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _RoomDetailProcessingState && room == other.room;
  }

  @override
  _RoomDetailProcessingState copyWith({IRoom? room}) =>
      _RoomDetailProcessingState(room: room ?? this.room);
}

final class _RoomDetailErrorState extends RoomDetailState {
  const _RoomDetailErrorState({required super.room, this.message});

  final String? message;

  @override
  int get hashCode => Object.hashAll([room, message]);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _RoomDetailErrorState &&
        room == other.room &&
        message == other.message;
  }

  @override
  _RoomDetailErrorState copyWith({IRoom? room, String? message}) =>
      _RoomDetailErrorState(
        room: room ?? this.room,
        message: message ?? this.message,
      );
}
