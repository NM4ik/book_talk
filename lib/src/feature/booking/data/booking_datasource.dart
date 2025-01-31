import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk/src/feature/booking/model/time_slot.dart';

abstract interface class BookingDataSource {
  Future<BookingDaysDto> fetchBookingDays();

  /// Fetches the time slots for a specific day.
  ///
  /// [day] The day for which time slots are to be fetched.
  Future<List<TimeSlotDto>> fetchTimeSlotsForDay(int day);
}

final class BookingDatasourceImpl implements BookingDataSource {
  @override
  Future<BookingDaysDto> fetchBookingDays() async {
    return await Future.delayed(
      const Duration(seconds: 2),
      () => BookingDaysDto.fromJson(bookingDaysJsonMock),
    );
  }

  @override
  Future<List<TimeSlotDto>> fetchTimeSlotsForDay(int day) async {
    return bookingDaysTimeSlotsJsonMock[day]!
        .map((object) => TimeSlotDto.fromJson(object))
        .toList();
  }
}

final bookingDaysJsonMock = {
  'booking_days': {
    1: [1, 2, 3, 4],
    2: [1, 4],
  }
};

final bookingDaysTimeSlotsJsonMock = {
  1: [
    {
      'time': '10:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '11:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '13:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '15:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '16:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '18:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '19:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '21:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
  ],
  2: [
    {
      'time': '09:30',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '12:15',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '14:45',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '17:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '09:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '11:30',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '16:15',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
    {
      'time': '20:00',
      'duration': 60,
      'dateTime': '2025-01-07T10:00:00.000Z',
    },
  ],
  3: [
    {
      'time': '08:00',
      'duration': 60,
      'dateTime': '2025-01-08T08:00:00.000Z',
    },
    {
      'time': '10:30',
      'duration': 60,
      'dateTime': '2025-01-08T10:30:00.000Z',
    },
    {
      'time': '13:00',
      'duration': 60,
      'dateTime': '2025-01-08T13:00:00.000Z',
    },
    {
      'time': '15:30',
      'duration': 60,
      'dateTime': '2025-01-08T15:30:00.000Z',
    },
    {
      'time': '18:00',
      'duration': 60,
      'dateTime': '2025-01-08T18:00:00.000Z',
    },
    {
      'time': '20:30',
      'duration': 60,
      'dateTime': '2025-01-08T20:30:00.000Z',
    },
  ],
  4: [
    {
      'time': '09:00',
      'duration': 60,
      'dateTime': '2025-01-09T09:00:00.000Z',
    },
    {
      'time': '11:00',
      'duration': 60,
      'dateTime': '2025-01-09T11:00:00.000Z',
    },
    {
      'time': '13:30',
      'duration': 60,
      'dateTime': '2025-01-09T13:30:00.000Z',
    },
    {
      'time': '16:00',
      'duration': 60,
      'dateTime': '2025-01-09T16:00:00.000Z',
    },
    {
      'time': '18:30',
      'duration': 60,
      'dateTime': '2025-01-09T18:30:00.000Z',
    },
    {
      'time': '21:00',
      'duration': 60,
      'dateTime': '2025-01-09T21:00:00.000Z',
    },
  ],
};
