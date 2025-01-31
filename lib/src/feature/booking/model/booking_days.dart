class BookingDays {
  const BookingDays({required this.days});

  final Map<int, List<int>> days;
}

class BookingDaysDto {
  const BookingDaysDto({required this.days});

  factory BookingDaysDto.fromJson(Map<String, dynamic> json) {
    return BookingDaysDto(days: json['booking_days'] as Map<int, List<int>>);
  }

  final Map<int, List<int>> days;

  BookingDays toEntity() => BookingDays(days: days);
}
