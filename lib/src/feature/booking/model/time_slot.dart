import 'package:flutter/material.dart';

class TimeSlot {
  const TimeSlot({
    required this.time,
    required this.dateTime,
    required this.duration,
  });

  final TimeOfDay time;
  final DateTime dateTime;
  final TimeOfDay duration;
}

class TimeSlotDto {
  const TimeSlotDto({
    required this.time,
    required this.dateTime,
    required this.duration,
  });

  factory TimeSlotDto.fromJson(Map<String, dynamic> json) => TimeSlotDto(
        time: _stringToTimeOfDay(json['time'].toString()),
        dateTime: DateTime.parse(json['dateTime']),
        duration: _stringToTimeOfDay(json['duration'].toString()),
      );

  factory TimeSlotDto.fromEntity(TimeSlot timeSlot) => TimeSlotDto(
        time: timeSlot.time,
        dateTime: timeSlot.dateTime,
        duration: timeSlot.duration,
      );

  final TimeOfDay time;
  final DateTime dateTime;
  final TimeOfDay duration;

  TimeSlot toEntity() => TimeSlot(
        time: time,
        dateTime: dateTime,
        duration: duration,
      );

  static TimeOfDay _stringToTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts.first);
    final minute = int.parse(parts.last);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
