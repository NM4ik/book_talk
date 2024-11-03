part of 'rooms_bloc.dart';

sealed class RoomsState {
  const RoomsState({required this.rooms});

  const factory RoomsState.idle({required List<Room>? rooms}) = _IdleRoomsState;

  const factory RoomsState.processing({required List<Room>? rooms}) =
      _ProcessingRoomsState;

  const factory RoomsState.error({
    required List<Room>? rooms,
    required Object error,
  }) = _ErrorRoomsState;

  final List<Room>? rooms;
}

final class _IdleRoomsState extends RoomsState {
  const _IdleRoomsState({required super.rooms});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _IdleRoomsState && listEquals(rooms, other.rooms);
  }

  @override
  int get hashCode => Object.hashAll([rooms]);

  @override
  String toString() => 'RoomsState.idle(rooms: $rooms)';
}

final class _ErrorRoomsState extends RoomsState {
  const _ErrorRoomsState({
    required super.rooms,
    required this.error,
  });

  final Object error;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ErrorRoomsState &&
        error == other.error &&
        listEquals(rooms, other.rooms);
  }

  @override
  int get hashCode => Object.hashAll([rooms, error]);

  @override
  String toString() => 'RoomsState.error(rooms: $rooms)';
}

final class _ProcessingRoomsState extends RoomsState {
  const _ProcessingRoomsState({required super.rooms});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ProcessingRoomsState && listEquals(rooms, other.rooms);
  }

  @override
  int get hashCode => Object.hashAll([rooms]);

  @override
  String toString() => 'RoomsState.processing(rooms: $rooms)';
}
