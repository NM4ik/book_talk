import 'package:book_talk/src/feature/booking/model/time_slot.dart';

/// A day in booking calendar.
///
/// Consists of [date] and a list of available [TimeSlot]s.
class BookingDay {
  const BookingDay({required this.date, required this.slots});

  /// The date of the day.
  final DateTime date;

  /// The available time slots.
  final List<TimeSlot> slots;
}

class BookingDayDto {
  const BookingDayDto({required this.date, required this.slots});

  factory BookingDayDto.fromJson(String date, List<dynamic> slots) {
    return BookingDayDto(
      date: DateTime.parse(date),
      slots: slots.map((object) => TimeSlotDto.fromJson(object)).toList(),
    );
  }

  final DateTime date;

  final List<TimeSlotDto> slots;

  BookingDay toEntity() => BookingDay(
        date: date,
        slots: slots.map((slot) => slot.toEntity()).toList(),
      );
}
