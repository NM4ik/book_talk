import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk/src/feature/booking/model/day_slots.dart';

abstract interface class BookingDataSource {
  Future<BookingDaysDto?> fetchBookingDays();

  /// Fetches the time slots for a specific day.
  ///
  /// [date] The day for which time slots are to be fetched.
  Future<BookingDayDto?> fetchTimeSlotsForDay(String date);
}

final class BookingDatasourceImpl implements BookingDataSource {
  @override
  Future<BookingDaysDto?> fetchBookingDays() async {
    final Map<String, dynamic> response = await Future.delayed(
      const Duration(seconds: 2),
      () => _availableDays,
    );

    return BookingDaysDto.fromJson(response);
  }

  @override
  Future<BookingDayDto?> fetchTimeSlotsForDay(String date) async {
    final response = await Future.delayed(
      const Duration(seconds: 2),
      () => shedule[date],
    );

    if (response == null) {
      return null;
    }

    return BookingDayDto.fromJson(date, response);
  }
}

final Map<String, dynamic> _availableDays = {
  'days': [
    {
      'date': '2025-02-01',
      'slots': 3,
    },
    {
      'date': '2025-02-02',
      'slots': 5,
    },
    {
      'date': '2025-02-03',
      'slots': 2,
    },
    {
      'date': '2025-02-04',
      'slots': 4,
    },
    {
      'date': '2025-02-05',
      'slots': 6,
    },
    {
      'date': '2025-02-06',
      'slots': 1,
    },
    {
      'date': '2025-02-07',
      'slots': 7,
    },
    {
      'date': '2025-02-08',
      'slots': 3,
    },
    {
      'date': '2025-02-09',
      'slots': 5,
    },
    {
      'date': '2025-02-10',
      'slots': 2,
    },
    {
      'date': '2025-02-11',
      'slots': 4,
    },
    {
      'date': '2025-02-12',
      'slots': 6,
    },
    {
      'date': '2025-02-13',
      'slots': 1,
    },
    {
      'date': '2025-02-14',
      'slots': 7,
    },
    {
      'date': '2025-02-15',
      'slots': 3,
    },
    {
      'date': '2025-02-16',
      'slots': 5,
    },
    {
      'date': '2025-02-17',
      'slots': 2,
    },
    {
      'date': '2025-02-18',
      'slots': 4,
    },
    {
      'date': '2025-02-19',
      'slots': 6,
    },
    {
      'date': '2025-02-20',
      'slots': 1,
    },
    {
      'date': '2025-02-21',
      'slots': 7,
    },
    {
      'date': '2025-02-22',
      'slots': 3,
    },
    {
      'date': '2025-02-23',
      'slots': 5,
    },
    {
      'date': '2025-02-24',
      'slots': 2,
    },
    {
      'date': '2025-02-25',
      'slots': 4,
    },
    {
      'date': '2025-02-26',
      'slots': 6,
    },
    {
      'date': '2025-02-27',
      'slots': 1,
    },
    {
      'date': '2025-02-28',
      'slots': 7,
    },
    {
      'date': '2025-03-01',
      'slots': 3,
    },
    {
      'date': '2025-03-02',
      'slots': 5,
    },
    {
      'date': '2025-03-03',
      'slots': 2,
    },
    {
      'date': '2025-03-04',
      'slots': 4,
    },
    {
      'date': '2025-03-05',
      'slots': 6,
    },
    {
      'date': '2025-03-06',
      'slots': 1,
    },
    {
      'date': '2025-03-07',
      'slots': 7,
    },
    {
      'date': '2025-03-08',
      'slots': 3,
    },
    {
      'date': '2025-03-09',
      'slots': 5,
    },
    {
      'date': '2025-03-10',
      'slots': 2,
    },
    {
      'date': '2025-03-11',
      'slots': 4,
    },
    {
      'date': '2025-03-12',
      'slots': 6,
    },
    {
      'date': '2025-03-13',
      'slots': 1,
    },
    {
      'date': '2025-03-14',
      'slots': 7,
    },
    {
      'date': '2025-03-15',
      'slots': 3,
    },
    {
      'date': '2025-03-16',
      'slots': 5,
    },
    {
      'date': '2025-03-17',
      'slots': 2,
    },
    {
      'date': '2025-03-18',
      'slots': 4,
    },
    {
      'date': '2025-03-19',
      'slots': 6,
    },
    {
      'date': '2025-03-20',
      'slots': 1,
    },
    {
      'date': '2025-03-21',
      'slots': 7,
    },
    {
      'date': '2025-03-22',
      'slots': 3,
    },
    {
      'date': '2025-03-23',
      'slots': 5,
    },
    {
      'date': '2025-03-24',
      'slots': 2,
    },
    {
      'date': '2025-03-25',
      'slots': 4,
    },
    {
      'date': '2025-03-26',
      'slots': 6,
    },
    {
      'date': '2025-03-27',
      'slots': 1,
    },
    {
      'date': '2025-03-28',
      'slots': 7,
    },
    {
      'date': '2025-03-29',
      'slots': 3,
    },
    {
      'date': '2025-03-30',
      'slots': 5,
    },
    {
      'date': '2025-03-31',
      'slots': 2,
    },
    {
      'date': '2025-04-01',
      'slots': 4,
    },
    {
      'date': '2025-04-02',
      'slots': 6,
    },
    {
      'date': '2025-04-03',
      'slots': 1,
    },
    {
      'date': '2025-04-04',
      'slots': 7,
    },
    {
      'date': '2025-04-05',
      'slots': 3,
    },
    {
      'date': '2025-04-06',
      'slots': 5,
    },
    {
      'date': '2025-04-07',
      'slots': 2,
    },
    {
      'date': '2025-04-08',
      'slots': 4,
    },
    {
      'date': '2025-04-09',
      'slots': 6,
    },
    {
      'date': '2025-04-10',
      'slots': 1,
    },
    {
      'date': '2025-04-11',
      'slots': 7,
    },
    {
      'date': '2025-04-12',
      'slots': 3,
    },
    {
      'date': '2025-04-13',
      'slots': 5,
    },
    {
      'date': '2025-04-14',
      'slots': 2,
    },
    {
      'date': '2025-04-15',
      'slots': 4,
    },
    {
      'date': '2025-04-16',
      'slots': 6,
    },
    {
      'date': '2025-04-17',
      'slots': 1,
    },
    {
      'date': '2025-04-18',
      'slots': 7,
    },
    {
      'date': '2025-04-19',
      'slots': 3,
    },
    {
      'date': '2025-04-20',
      'slots': 5,
    },
    {
      'date': '2025-04-21',
      'slots': 2,
    },
    {
      'date': '2025-04-22',
      'slots': 4,
    },
    {
      'date': '2025-04-23',
      'slots': 6,
    },
    {
      'date': '2025-04-24',
      'slots': 1,
    },
    {
      'date': '2025-04-25',
      'slots': 7,
    },
    {
      'date': '2025-04-26',
      'slots': 3,
    },
    {
      'date': '2025-04-27',
      'slots': 5,
    },
    {
      'date': '2025-04-28',
      'slots': 2,
    },
    {
      'date': '2025-04-29',
      'slots': 4,
    },
    {
      'date': '2025-04-30',
      'slots': 6,
    }
  ],
  'pagination': {
    'current_page': 1,
    'total_pages': 1,
    'per_page': 30,
  }
};

final shedule = {
  '2025-02-01': [
    {
      'time': '2025-02-01 10:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_60',
      'department': 1,
    },
    {
      'time': '2025-02-01 11:00:00 UTC+03:00',
      'status': 'available',
    },
    {
      'time': '2025-02-01 12:30:00 UTC+03:00',
      'status': 'available',
    },
    {
      'time': '2025-02-01 13:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_100',
      'department': 2,
    },
    {
      'time': '2025-02-01 14:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_32',
      'department': 3,
    },
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'available',
    },
    {
      'time': '2025-02-01 17:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_47'
    },
    {
      'time': '2025-02-01 18:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_12'
    },
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 20:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_70'
    },
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 22:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_97'
    }
  ],
  '2025-02-02': [
    {
      'time': '2025-02-01 09:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_20'
    },
    {
      'time': '2025-02-01 10:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_74'
    },
    {'time': '2025-02-01 11:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 13:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_14'
    },
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 18:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_24'
    },
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 20:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_96'
    },
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-03': [
    {'time': '2025-02-01 08:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 09:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_9'
    },
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_6'
    },
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 22:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_63'
    }
  ],
  '2025-02-04': [
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 12:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_90'
    },
    {'time': '2025-02-01 13:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 14:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_9'
    },
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 16:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 17:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 18:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_28'
    },
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 23:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_68'
    }
  ],
  '2025-02-05': [
    {'time': '2025-02-01 08:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 10:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_14'
    },
    {
      'time': '2025-02-01 17:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_43'
    },
    {'time': '2025-02-01 19:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 22:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_53'
    }
  ],
  '2025-02-06': [
    {'time': '2025-02-01 08:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 09:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_42'
    },
    {
      'time': '2025-02-01 10:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_29'
    },
    {
      'time': '2025-02-01 11:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_62'
    },
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 15:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_70'
    },
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 18:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_84'
    },
    {
      'time': '2025-02-01 19:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_42'
    },
    {'time': '2025-02-01 21:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-07': [
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 19:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_69'
    },
    {
      'time': '2025-02-01 21:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_25'
    },
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 23:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_83'
    }
  ],
  '2025-02-08': [
    {'time': '2025-02-01 08:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 16:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 17:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_17'
    },
    {
      'time': '2025-02-01 19:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_50'
    },
    {
      'time': '2025-02-01 20:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_21'
    },
    {'time': '2025-02-01 21:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 23:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_7'
    }
  ],
  '2025-02-09': [
    {'time': '2025-02-01 08:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 11:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_93'
    },
    {
      'time': '2025-02-01 12:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_51'
    },
    {'time': '2025-02-01 13:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_86'
    },
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 20:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_63'
    },
    {'time': '2025-02-01 21:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:30:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-10': [
    {
      'time': '2025-02-01 08:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_76'
    },
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_61'
    },
    {'time': '2025-02-01 17:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 18:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_67'
    },
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:30:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-11': [
    {'time': '2025-02-01 08:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 10:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 12:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_91'
    },
    {'time': '2025-02-01 13:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 16:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 17:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_2'
    },
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 21:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_78'
    },
    {
      'time': '2025-02-01 22:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_94'
    },
    {
      'time': '2025-02-01 23:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_57'
    }
  ],
  '2025-02-12': [
    {
      'time': '2025-02-01 09:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_87'
    },
    {
      'time': '2025-02-01 10:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_87'
    },
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 13:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_12'
    },
    {
      'time': '2025-02-01 14:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_15'
    },
    {
      'time': '2025-02-01 15:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_26'
    },
    {
      'time': '2025-02-01 16:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_15'
    },
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 22:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_72'
    },
    {'time': '2025-02-01 23:30:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-13': [
    {
      'time': '2025-02-01 09:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_11'
    },
    {'time': '2025-02-01 10:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 11:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_63'
    },
    {
      'time': '2025-02-01 12:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_2'
    },
    {'time': '2025-02-01 14:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 15:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_46'
    },
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 22:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_27'
    },
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-14': [
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 14:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_85'
    },
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 16:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 17:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_84'
    },
    {
      'time': '2025-02-01 18:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_11'
    },
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:30:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-15': [
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 13:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_31'
    },
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 17:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_63'
    },
    {
      'time': '2025-02-01 18:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_41'
    },
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 21:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_88'
    },
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-16': [
    {'time': '2025-02-01 09:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 10:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 12:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_26'
    },
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_93'
    },
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 19:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_81'
    },
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-17': [
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 13:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_80'
    },
    {'time': '2025-02-01 14:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 16:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 21:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_19'
    },
    {'time': '2025-02-01 22:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:30:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-18': [
    {
      'time': '2025-02-01 08:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_51'
    },
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 10:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 16:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 18:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_64'
    },
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-19': [
    {'time': '2025-02-01 08:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 19:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_18'
    },
    {
      'time': '2025-02-01 20:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_68'
    },
    {
      'time': '2025-02-01 21:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_14'
    },
    {
      'time': '2025-02-01 23:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_75'
    }
  ],
  '2025-02-20': [
    {
      'time': '2025-02-01 09:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_51'
    },
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 12:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_22'
    },
    {
      'time': '2025-02-01 13:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_64'
    },
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 16:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 22:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_87'
    }
  ],
  '2025-02-21': [
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 11:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_56'
    },
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_84'
    },
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 20:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_9'
    },
    {
      'time': '2025-02-01 21:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_6'
    },
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-22': [
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 21:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_48'
    },
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-23': [
    {
      'time': '2025-02-01 08:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_27'
    },
    {
      'time': '2025-02-01 09:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_76'
    },
    {
      'time': '2025-02-01 10:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_21'
    },
    {
      'time': '2025-02-01 11:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_57'
    },
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_44'
    },
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 18:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_82'
    },
    {'time': '2025-02-01 19:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:30:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-24': [
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 13:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_12'
    },
    {
      'time': '2025-02-01 15:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_41'
    },
    {
      'time': '2025-02-01 16:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_21'
    },
    {'time': '2025-02-01 17:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 21:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_16'
    },
    {
      'time': '2025-02-01 23:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_80'
    }
  ],
  '2025-02-25': [
    {
      'time': '2025-02-01 08:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_95'
    },
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 11:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_10'
    },
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 14:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 15:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_5'
    },
    {
      'time': '2025-02-01 17:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_37'
    },
    {
      'time': '2025-02-01 18:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_13'
    },
    {
      'time': '2025-02-01 19:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_64'
    },
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 23:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_57'
    }
  ],
  '2025-02-26': [
    {'time': '2025-02-01 09:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 10:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_10'
    },
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 12:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_83'
    },
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 14:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_20'
    },
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_31'
    },
    {
      'time': '2025-02-01 17:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_64'
    },
    {
      'time': '2025-02-01 18:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_58'
    },
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 21:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_19'
    },
    {'time': '2025-02-01 22:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:30:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-27': [
    {'time': '2025-02-01 08:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 11:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 13:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 14:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_3'
    },
    {'time': '2025-02-01 16:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 17:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:30:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-02-28': [
    {'time': '2025-02-01 08:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 09:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 11:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_29'
    },
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 13:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_26'
    },
    {
      'time': '2025-02-01 15:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_77'
    },
    {'time': '2025-02-01 16:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 19:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_69'
    },
    {'time': '2025-02-01 20:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 23:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_18'
    }
  ],
  '2025-03-01': [
    {'time': '2025-02-01 09:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 11:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_67'
    },
    {'time': '2025-02-01 12:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 13:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_66'
    },
    {'time': '2025-02-01 14:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 16:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_65'
    },
    {
      'time': '2025-02-01 17:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_92'
    },
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 20:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 23:00:00 UTC+03:00', 'status': 'available'}
  ],
  '2025-03-02': [
    {'time': '2025-02-01 09:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 10:00:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 11:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_97'
    },
    {'time': '2025-02-01 12:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 14:00:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_75'
    },
    {'time': '2025-02-01 15:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 17:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 18:00:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 19:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 20:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_46'
    },
    {'time': '2025-02-01 21:30:00 UTC+03:00', 'status': 'available'},
    {'time': '2025-02-01 22:30:00 UTC+03:00', 'status': 'available'},
    {
      'time': '2025-02-01 23:30:00 UTC+03:00',
      'status': 'booked',
      'user': 'user_26'
    }
  ]
};
