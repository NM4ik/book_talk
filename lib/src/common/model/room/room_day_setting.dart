// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// Represents settings for a specific weekday in a room's schedule.
class RoomWeekdaySetting {
  /// Creates a setting for a room on a specific day with activation and timing details.
  const RoomWeekdaySetting({
    required this.day,
    required this.isActive,
    required this.startTime,
    required this.endTime,
    required this.priority,
  });

  /// The day of the week as a string.
  final String day;

  /// Indicates whether the room is active on this day.
  final bool isActive;

  /// Start time for room availability on this day.
  final TimeOfDay startTime;

  /// End time for room availability on this day.
  final TimeOfDay endTime;

  /// Priority day number of the week.
  final int priority;

  RoomWeekdaySetting toggleActive({required bool? value}) {
    return this.copyWith(isActive: value ?? !isActive);
  }

  RoomWeekdaySetting changeStartTime({required int hour, required int minute}) {
    return this.copyWith(startTime: TimeOfDay(hour: hour, minute: minute));
  }

  RoomWeekdaySetting changeEndTime({required int hour, required int minute}) {
    return this.copyWith(endTime: TimeOfDay(hour: hour, minute: minute));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomWeekdaySetting &&
        other.day == day &&
        other.isActive == isActive &&
        other.startTime == startTime &&
        other.priority == priority &&
        other.endTime == endTime;
  }

  @override
  int get hashCode =>
      Object.hashAll([day, isActive, startTime, endTime, priority]);

  RoomWeekdaySetting copyWith({
    String? day,
    bool? isActive,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    int? priority,
  }) {
    return RoomWeekdaySetting(
      day: day ?? this.day,
      isActive: isActive ?? this.isActive,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      priority: priority ?? this.priority,
    );
  }

  @override
  String toString() {
    return 'RoomWeekdaySetting(day: $day, isActive: $isActive, startTime: $startTime, endTime: $endTime, priority: $priority)';
  }
}

class RoomWeekdaySettingDto {
  const RoomWeekdaySettingDto({
    required this.day,
    required this.isActive,
    required this.startTime,
    required this.endTime,
    required this.priority,
  });

  factory RoomWeekdaySettingDto.fromMap(Map<String, Object?> map) {
    return RoomWeekdaySettingDto(
      day: map['day'] as String,
      isActive: map['isActive'] as bool,
      startTime: _parseTimeOfDay(map['startTime'] as String),
      endTime: _parseTimeOfDay(map['endTime'] as String),
      priority: map['priority'] as int,
    );
  }

  factory RoomWeekdaySettingDto.fromEntity(RoomWeekdaySetting setting) {
    return RoomWeekdaySettingDto(
      day: setting.day,
      isActive: setting.isActive,
      startTime: setting.startTime,
      endTime: setting.endTime,
      priority: setting.priority,
    );
  }

  final String day;
  final bool isActive;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final int priority;

  static TimeOfDay _parseTimeOfDay(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts.first);
    final minute = int.parse(parts.last);

    return TimeOfDay(hour: hour, minute: minute);
  }

  RoomWeekdaySetting toEntity() => RoomWeekdaySetting(
        day: day,
        isActive: isActive,
        startTime: startTime,
        endTime: endTime,
        priority: priority,
      );

  Map<String, Object?> toMap() {
    return {
      'day': day,
      'isActive': isActive,
      'startTime': '${startTime.hour}:${startTime.minute}',
      'endTime': '${endTime.hour}:${endTime.minute}',
      'priority': priority,
    };
  }
}
