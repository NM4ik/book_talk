part of 'rooms_bloc.dart';

sealed class RoomsEvent {
  const RoomsEvent();

  const factory RoomsEvent.load() = _RoomsLoadEvent;

  const factory RoomsEvent.refresh() = _RoomsRefreshEvent;
}

final class _RoomsLoadEvent extends RoomsEvent {
  const _RoomsLoadEvent();
}

final class _RoomsRefreshEvent extends RoomsEvent {
  const _RoomsRefreshEvent();
}
