import 'package:book_talk/src/feature/booking/data/booking_datasource.dart';
import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk/src/feature/booking/model/time_slot.dart';

abstract interface class BookingRepository {
  Future<BookingDays> fetchBookingDays();
  Future<List<TimeSlot>> fetchTimeSlotsForDay(int day);
}

final class BookingRepositoryImpl implements BookingRepository {
  const BookingRepositoryImpl({required BookingDataSource bookingDataSource})
      : _bookingDataSource = bookingDataSource;

  final BookingDataSource _bookingDataSource;

  @override
  Future<BookingDays> fetchBookingDays() async {
    return (await _bookingDataSource.fetchBookingDays()).toEntity();
  }

  @override
  Future<List<TimeSlot>> fetchTimeSlotsForDay(int day) async {
    return (await _bookingDataSource.fetchTimeSlotsForDay(day))
        .map((slotDto) => slotDto.toEntity())
        .toList();
  }
}
