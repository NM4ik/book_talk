part of 'booking_bloc.dart';

@immutable
sealed class BookingState {
  const BookingState({required this.bookingDays});

  const factory BookingState.idle({required BookingDays? bookingDays}) = _Idle;

  const factory BookingState.processing({required BookingDays? bookingDays}) =
      _Processing;

  const factory BookingState.error({
    BookingDays? bookingDays,
    String? message,
  }) = _Error;

  final BookingDays? bookingDays;

  T $map<T>({
    required T Function({required BookingDays? bookingDays}) idle,
    required T Function() processing,
    required T Function({
      required BookingDays? bookingDays,
      required String? message,
    }) error,
  }) =>
      switch (this) {
        _Idle() => idle(bookingDays: bookingDays),
        _Processing() => processing(),
        _Error() => error(
            bookingDays: bookingDays,
            message: (this as _Error).message,
          ),
      };

  bool get isProcessing => this is _Processing;

  bool get isError => this is _Error;
}

final class _Idle extends BookingState {
  const _Idle({required super.bookingDays});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Idle &&
          runtimeType == other.runtimeType &&
          bookingDays == other.bookingDays;

  @override
  int get hashCode => bookingDays.hashCode;
}

final class _Processing extends BookingState {
  const _Processing({required super.bookingDays});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Processing &&
          runtimeType == other.runtimeType &&
          bookingDays == other.bookingDays;

  @override
  int get hashCode => bookingDays.hashCode;
}

final class _Error extends BookingState {
  const _Error({super.bookingDays, this.message});

  final String? message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Error &&
          runtimeType == other.runtimeType &&
          bookingDays == other.bookingDays;

  @override
  int get hashCode => bookingDays.hashCode;
}
