part of 'rooms_bloc.dart';

@immutable
sealed class RoomsState {
  const RoomsState({required this.rooms});

  const factory RoomsState.idle({required List<Room>? rooms}) = _IdleState;

  const factory RoomsState.processing({required List<Room>? rooms}) =
      _ProcessingState;

  const factory RoomsState.error({
    required List<Room>? rooms,
    required Object error,
  }) = _ErrorState;

  final List<Room>? rooms;

  bool get isError => this is _ErrorState;

  bool get isProcessing => this is _ProcessingState;

  bool get isIdle => this is _IdleState;
}

final class _IdleState extends RoomsState {
  const _IdleState({required super.rooms});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _IdleState && listEquals(rooms, other.rooms);
  }

  @override
  int get hashCode => Object.hashAll([rooms]);

  @override
  String toString() => 'RoomsState.idle(rooms: $rooms)';
}

final class _ErrorState extends RoomsState {
  const _ErrorState({required super.rooms, required this.error});

  final Object error;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ErrorState &&
        error == other.error &&
        listEquals(rooms, other.rooms);
  }

  @override
  int get hashCode => Object.hashAll([rooms, error]);

  @override
  String toString() => 'RoomsState.error(rooms: $rooms)';
}

final class _ProcessingState extends RoomsState {
  const _ProcessingState({required super.rooms});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ProcessingState && listEquals(rooms, other.rooms);
  }

  @override
  int get hashCode => Object.hashAll([rooms]);

  @override
  String toString() => 'RoomsState.processing(rooms: $rooms)';
}
