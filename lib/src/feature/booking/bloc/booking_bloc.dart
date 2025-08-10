import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:book_talk/src/feature/booking/data/booking_repository.dart';
import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'booking_state.dart';
part 'booking_event.dart';

final class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc({
    required BookingRepository bookingRepository,
  })  : _bookingRepository = bookingRepository,
        super(const BookingState.processing(bookingDays: null)) {
    on<BookingEvent>(
      (event, emitter) => switch (event) {
        _Load() => _onLoadEvent(event, emitter),
      },
      transformer: droppable(),
    );
  }

  final BookingRepository _bookingRepository;

  Future<void> _onLoadEvent(_Load event, Emitter<BookingState> emitter) async {
    try {
      emitter(BookingState.processing(bookingDays: state.bookingDays));

      final BookingDays? bookingDays =
          await _bookingRepository.fetchBookingDays();

      if (bookingDays != null) {
        emitter(BookingState.idle(bookingDays: bookingDays));
      } else {
        emitter(const BookingState.error());
      }
    } on Object catch (e, st) {
      onError(e, st);
      emitter(
        BookingState.error(
          bookingDays: state.bookingDays,
          message: e.toString(),
        ),
      );
    }
  }
}
