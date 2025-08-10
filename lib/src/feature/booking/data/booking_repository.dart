import 'package:book_talk/src/feature/booking/data/booking_datasource.dart';
import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk/src/feature/booking/model/day_slots.dart';

abstract interface class BookingRepository {
  Future<BookingDays?> fetchBookingDays();

  Future<BookingDay?> fetchTimeSlotsForDay(String date);
}

final class BookingRepositoryImpl implements BookingRepository {
  const BookingRepositoryImpl({required BookingDataSource bookingDataSource})
      : _bookingDataSource = bookingDataSource;

  final BookingDataSource _bookingDataSource;

  @override
  Future<BookingDays?> fetchBookingDays() async => (await _bookingDataSource.fetchBookingDays())?.toEntity();

  @override
  Future<BookingDay?> fetchTimeSlotsForDay(String date) async => (await _bookingDataSource.fetchTimeSlotsForDay(date))?.toEntity();
}
