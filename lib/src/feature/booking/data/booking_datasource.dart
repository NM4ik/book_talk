import 'package:book_talk/src/feature/booking/model/booking_days.dart';
import 'package:book_talk/src/feature/booking/model/day_slots.dart';

abstract interface class BookingDataSource {
  Future<BookingDaysDto?> fetchBookingDays();

  /// Fetches the time slots for a specific day.
  ///
  /// [day] The day for which time slots are to be fetched.
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
  "days": [
    "2025-02-01",
    "2025-02-02",
    "2025-02-03",
    "2025-02-04",
    "2025-02-05",
    "2025-02-06",
    "2025-02-07",
    "2025-02-08",
    "2025-02-09",
    "2025-02-10",
    "2025-02-11",
    "2025-02-12",
    "2025-02-13",
    "2025-02-14",
    "2025-02-15",
    "2025-02-16",
    "2025-02-17",
    "2025-02-18",
    "2025-02-19",
    "2025-02-20",
    "2025-02-21",
    "2025-02-22",
    "2025-02-23",
    "2025-02-24",
    "2025-02-25",
    "2025-02-26",
    "2025-02-27",
    "2025-02-28"
  ],
  "pagination": {
    "current_page": 1,
    "total_pages": 1,
    "per_page": 30,
  }
};

final shedule = {
  "2025-02-01": [
    {
      "time": "2025-02-01 10:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_60",
      "department": 1,
    },
    {
      "time": "2025-02-01 11:00:00 UTC+03:00",
      "status": "available",
    },
    {
      "time": "2025-02-01 12:30:00 UTC+03:00",
      "status": "available",
    },
    {
      "time": "2025-02-01 13:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_100",
      "department": 2,
    },
    {
      "time": "2025-02-01 14:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_32",
      "department": 3,
    },
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "available",
    },
    {
      "time": "2025-02-01 17:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_47"
    },
    {
      "time": "2025-02-01 18:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_12"
    },
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 20:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_70"
    },
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 22:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_97"
    }
  ],
  "2025-02-02": [
    {
      "time": "2025-02-01 09:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_20"
    },
    {
      "time": "2025-02-01 10:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_74"
    },
    {"time": "2025-02-01 11:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 13:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_14"
    },
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 18:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_24"
    },
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 20:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_96"
    },
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-03": [
    {"time": "2025-02-01 08:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 09:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_9"
    },
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_6"
    },
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 22:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_63"
    }
  ],
  "2025-02-04": [
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 12:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_90"
    },
    {"time": "2025-02-01 13:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 14:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_9"
    },
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 16:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 17:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 18:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_28"
    },
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 23:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_68"
    }
  ],
  "2025-02-05": [
    {"time": "2025-02-01 08:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 10:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_14"
    },
    {
      "time": "2025-02-01 17:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_43"
    },
    {"time": "2025-02-01 19:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 22:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_53"
    }
  ],
  "2025-02-06": [
    {"time": "2025-02-01 08:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 09:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_42"
    },
    {
      "time": "2025-02-01 10:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_29"
    },
    {
      "time": "2025-02-01 11:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_62"
    },
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 15:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_70"
    },
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 18:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_84"
    },
    {
      "time": "2025-02-01 19:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_42"
    },
    {"time": "2025-02-01 21:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-07": [
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 19:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_69"
    },
    {
      "time": "2025-02-01 21:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_25"
    },
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 23:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_83"
    }
  ],
  "2025-02-08": [
    {"time": "2025-02-01 08:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 16:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 17:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_17"
    },
    {
      "time": "2025-02-01 19:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_50"
    },
    {
      "time": "2025-02-01 20:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_21"
    },
    {"time": "2025-02-01 21:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 23:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_7"
    }
  ],
  "2025-02-09": [
    {"time": "2025-02-01 08:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 11:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_93"
    },
    {
      "time": "2025-02-01 12:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_51"
    },
    {"time": "2025-02-01 13:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_86"
    },
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 20:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_63"
    },
    {"time": "2025-02-01 21:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:30:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-10": [
    {
      "time": "2025-02-01 08:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_76"
    },
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_61"
    },
    {"time": "2025-02-01 17:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 18:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_67"
    },
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:30:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-11": [
    {"time": "2025-02-01 08:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 10:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 12:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_91"
    },
    {"time": "2025-02-01 13:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 16:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 17:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_2"
    },
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 21:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_78"
    },
    {
      "time": "2025-02-01 22:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_94"
    },
    {
      "time": "2025-02-01 23:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_57"
    }
  ],
  "2025-02-12": [
    {
      "time": "2025-02-01 09:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_87"
    },
    {
      "time": "2025-02-01 10:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_87"
    },
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 13:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_12"
    },
    {
      "time": "2025-02-01 14:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_15"
    },
    {
      "time": "2025-02-01 15:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_26"
    },
    {
      "time": "2025-02-01 16:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_15"
    },
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 22:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_72"
    },
    {"time": "2025-02-01 23:30:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-13": [
    {
      "time": "2025-02-01 09:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_11"
    },
    {"time": "2025-02-01 10:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 11:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_63"
    },
    {
      "time": "2025-02-01 12:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_2"
    },
    {"time": "2025-02-01 14:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 15:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_46"
    },
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 22:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_27"
    },
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-14": [
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 14:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_85"
    },
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 16:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 17:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_84"
    },
    {
      "time": "2025-02-01 18:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_11"
    },
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:30:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-15": [
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 13:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_31"
    },
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 17:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_63"
    },
    {
      "time": "2025-02-01 18:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_41"
    },
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 21:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_88"
    },
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-16": [
    {"time": "2025-02-01 09:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 10:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 12:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_26"
    },
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_93"
    },
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 19:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_81"
    },
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-17": [
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 13:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_80"
    },
    {"time": "2025-02-01 14:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 16:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 21:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_19"
    },
    {"time": "2025-02-01 22:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:30:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-18": [
    {
      "time": "2025-02-01 08:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_51"
    },
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 10:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 16:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 18:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_64"
    },
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-19": [
    {"time": "2025-02-01 08:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 19:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_18"
    },
    {
      "time": "2025-02-01 20:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_68"
    },
    {
      "time": "2025-02-01 21:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_14"
    },
    {
      "time": "2025-02-01 23:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_75"
    }
  ],
  "2025-02-20": [
    {
      "time": "2025-02-01 09:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_51"
    },
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 12:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_22"
    },
    {
      "time": "2025-02-01 13:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_64"
    },
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 16:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 22:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_87"
    }
  ],
  "2025-02-21": [
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 11:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_56"
    },
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_84"
    },
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 20:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_9"
    },
    {
      "time": "2025-02-01 21:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_6"
    },
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-22": [
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 21:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_48"
    },
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-23": [
    {
      "time": "2025-02-01 08:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_27"
    },
    {
      "time": "2025-02-01 09:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_76"
    },
    {
      "time": "2025-02-01 10:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_21"
    },
    {
      "time": "2025-02-01 11:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_57"
    },
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_44"
    },
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 18:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_82"
    },
    {"time": "2025-02-01 19:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:30:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-24": [
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 13:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_12"
    },
    {
      "time": "2025-02-01 15:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_41"
    },
    {
      "time": "2025-02-01 16:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_21"
    },
    {"time": "2025-02-01 17:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 21:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_16"
    },
    {
      "time": "2025-02-01 23:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_80"
    }
  ],
  "2025-02-25": [
    {
      "time": "2025-02-01 08:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_95"
    },
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 11:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_10"
    },
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 14:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 15:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_5"
    },
    {
      "time": "2025-02-01 17:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_37"
    },
    {
      "time": "2025-02-01 18:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_13"
    },
    {
      "time": "2025-02-01 19:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_64"
    },
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 23:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_57"
    }
  ],
  "2025-02-26": [
    {"time": "2025-02-01 09:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 10:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_10"
    },
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 12:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_83"
    },
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 14:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_20"
    },
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_31"
    },
    {
      "time": "2025-02-01 17:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_64"
    },
    {
      "time": "2025-02-01 18:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_58"
    },
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 21:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_19"
    },
    {"time": "2025-02-01 22:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:30:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-27": [
    {"time": "2025-02-01 08:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 11:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 13:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 14:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_3"
    },
    {"time": "2025-02-01 16:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 17:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:30:00 UTC+03:00", "status": "available"}
  ],
  "2025-02-28": [
    {"time": "2025-02-01 08:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 09:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 11:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_29"
    },
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 13:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_26"
    },
    {
      "time": "2025-02-01 15:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_77"
    },
    {"time": "2025-02-01 16:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 19:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_69"
    },
    {"time": "2025-02-01 20:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 23:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_18"
    }
  ],
  "2025-03-01": [
    {"time": "2025-02-01 09:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 11:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_67"
    },
    {"time": "2025-02-01 12:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 13:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_66"
    },
    {"time": "2025-02-01 14:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 16:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_65"
    },
    {
      "time": "2025-02-01 17:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_92"
    },
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 20:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 23:00:00 UTC+03:00", "status": "available"}
  ],
  "2025-03-02": [
    {"time": "2025-02-01 09:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 10:00:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 11:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_97"
    },
    {"time": "2025-02-01 12:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 14:00:00 UTC+03:00",
      "status": "booked",
      "user": "user_75"
    },
    {"time": "2025-02-01 15:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 17:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 18:00:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 19:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 20:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_46"
    },
    {"time": "2025-02-01 21:30:00 UTC+03:00", "status": "available"},
    {"time": "2025-02-01 22:30:00 UTC+03:00", "status": "available"},
    {
      "time": "2025-02-01 23:30:00 UTC+03:00",
      "status": "booked",
      "user": "user_26"
    }
  ]
};
