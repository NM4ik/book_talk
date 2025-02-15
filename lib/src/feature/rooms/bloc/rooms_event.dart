part of 'rooms_bloc.dart';

sealed class RoomsEvent {
  const RoomsEvent();

  const factory RoomsEvent.load() = _RoomsLoadEvent;
}

final class _RoomsLoadEvent extends RoomsEvent {
  const _RoomsLoadEvent();
}
