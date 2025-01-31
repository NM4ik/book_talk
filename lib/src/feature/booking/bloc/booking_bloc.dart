import 'package:book_talk/src/common/utils/mixins/task_executor_mixin.dart';
import 'package:book_talk/src/feature/booking/data/booking_repository.dart';
import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'booking_state.dart';
part 'booking_event.dart';

final class BookingBloc extends Bloc<BookingEvent, BookingState>
    with TaskExecuterBlocMixin {
  BookingBloc({required BookingRepository bookingRepository})
      : _bookingRepository = bookingRepository,
        super(const BookingState.processing(bookingDays: null)) {
    on<BookingEvent>(
      (event, emitter) => switch (event) {
        _Load() => _onLoadEvent(event, emitter),
      },
    );
  }

  final BookingRepository _bookingRepository;

  Future<void> _onLoadEvent(_Load event, Emitter<BookingState> emitter) async {
    await executeTask<BookingDays>(
      handle: () async {
        return await _bookingRepository.fetchBookingDays();
      },
      onDone: (data) {
        return emitter(BookingState.idle(bookingDays: data));
      },
      onError: (error, stackTrace) {
        // TODO(Mikhailov): Message
        return emitter(
          BookingState.error(
            bookingDays: state.bookingDays,
            message: 'Todo message',
          ),
        );
      },
    );
  }
}
