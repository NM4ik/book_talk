import 'package:flutter/foundation.dart';

@immutable
class BookingDays {
  const BookingDays({required this.daysInfo, required this.pagination});

  final List<DayInfo> daysInfo;
  final BookingDaysPagination pagination;

  @override
  bool operator ==(covariant BookingDays other) {
    if (identical(this, other)) return true;
    return listEquals(other.daysInfo, daysInfo) &&
        other.pagination == pagination;
  }

  @override
  int get hashCode => daysInfo.hashCode ^ pagination.hashCode;

  // TODO(Mikhailov): Maybe sort should be in repository?
  List<DayInfo> getSortedUpcomingDays(DateTime dateTime) {
    daysInfo.sort();
    return daysInfo.where((day) => day.date.isAfter(dateTime)).toList();
  }

  @override
  String toString() => 'BookingDays(days: $daysInfo, pagination: $pagination)';
}

class BookingDaysDto {
  const BookingDaysDto({required this.daysInfo, required this.pagination});

  factory BookingDaysDto.fromJson(Map<String, dynamic> json) => BookingDaysDto(
    daysInfo: (json['days'] as List<dynamic>)
        .whereType<Map<String, dynamic>>()
        .map(DayInfoDto.fromJson)
        .toList(),
    pagination: BookingDaysPaginationDto.fromJson(
      json['pagination'] as Map<String, dynamic>,
    ),
  );

  final List<DayInfoDto> daysInfo;
  final BookingDaysPaginationDto pagination;

  BookingDays toEntity() => BookingDays(
    daysInfo: daysInfo.map((day) => day.toEntity()).toList(),
    pagination: pagination.toEntity(),
  );
}

@immutable
class DayInfo implements Comparable<DayInfo> {
  const DayInfo({required this.date, required this.slots});

  final DateTime date;
  final int slots;

  @override
  String toString() => 'DayInfo(date: $date, slots: $slots)';

  @override
  bool operator ==(covariant DayInfo other) {
    if (identical(this, other)) return true;

    return other.date == date && other.slots == slots;
  }

  @override
  int get hashCode => date.hashCode ^ slots.hashCode;

  @override
  int compareTo(DayInfo other) => date.compareTo(other.date);
}

class DayInfoDto {
  const DayInfoDto({required this.date, required this.slots});

  factory DayInfoDto.fromJson(Map<String, dynamic> json) => DayInfoDto(
    date: json['date'] as String,
    slots: json['slots'] as int? ?? 0,
  );

  final String date;
  final int slots;

  DayInfo toEntity() => DayInfo(date: DateTime.parse(date), slots: slots);
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

class BookingDaysPaginationDto {
  const BookingDaysPaginationDto({
    required this.currentPage,
    required this.totalPages,
    required this.perPage,
  });

  factory BookingDaysPaginationDto.fromJson(Map<String, dynamic> json) =>
      BookingDaysPaginationDto(
        currentPage: json['current_page'] as int,
        totalPages: json['total_pages'] as int,
        perPage: json['per_page'] as int,
      );

  final int currentPage;
  final int totalPages;
  final int perPage;

  BookingDaysPagination toEntity() => BookingDaysPagination(
    currentPage: currentPage,
    totalPages: totalPages,
    perPage: perPage,
  );
}
