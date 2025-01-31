part of 'booking_bloc.dart';

sealed class BookingEvent {
  const BookingEvent();

  const factory BookingEvent.load() = _Load;
}

final class _Load extends BookingEvent {
  const _Load();
}
