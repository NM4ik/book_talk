/// Represents booking days.
///
/// Consists of a list of [DateTime]s and a [BookingDaysPagination].
class BookingDays {
  const BookingDays({
    required this.days,
    required this.pagination,
  });

  /// A list of [DateTime]s.
  final List<DateTime> days;

  /// A pagination object.
  final BookingDaysPagination pagination;
}

class BookingDaysPagination {
  const BookingDaysPagination({
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
  });

  final int currentPage;
  final int totalPages;
  final int perPage;
}

class BookingDaysDto {
  const BookingDaysDto({
    required this.days,
    required this.pagination,
  });

  factory BookingDaysDto.fromJson(Map<String, dynamic> json) {
    return BookingDaysDto(
      days: (json['days'] as List<dynamic>).whereType<String>().toList(),
      pagination: BookingDaysPaginationDto.fromJson(json['pagination']),
    );
  }

  final List<String> days;
  final BookingDaysPaginationDto pagination;

  BookingDays toEntity() => BookingDays(
        days: days.map((day) => DateTime.parse(day)).toList(),
        pagination: pagination.toEntity(),
      );
}

class BookingDaysPaginationDto {
  const BookingDaysPaginationDto({
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
  });

  factory BookingDaysPaginationDto.fromJson(Map<String, dynamic> json) {
    return BookingDaysPaginationDto(
      currentPage: json['current_page'] as int,
      totalPages: json['total_pages'] as int,
      perPage: json['per_page'] as int,
    );
  }

  final int currentPage;
  final int totalPages;
  final int perPage;

  BookingDaysPagination toEntity() => BookingDaysPagination(
        currentPage: currentPage,
        totalPages: totalPages,
        perPage: perPage,
      );
}
