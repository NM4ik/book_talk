// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import 'package:book_talk/src/common/model/room/room_day_setting.dart';

/// {@template RoomWeekSettings}
/// Holds weekly settings for a room, mapping each day to its specific settings.
/// {@endtemplate}
class RoomWeekSettings {
  /// Creates a weekly settings configuration for a room.
  const RoomWeekSettings({
    required this.days,
  });

  // TODO(Mikhailov): redoc
  /// A map of days to their specific settings for room availability.
  /// The key is the day's name, and the value is the setting for that day.
  // final Map<int, RoomWeekdaySetting> days;

  final List<RoomWeekdaySetting> days;

  RoomWeekdaySetting? settingByDay(String day) =>
      days.firstWhereOrNull((setting) => setting.day == day);

  void updateSetting(MapEntry<int, RoomWeekdaySetting> entry) {
    days[entry.key] = entry.value;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomWeekSettings && listEquals(other.days, days);
  }

  @override
  int get hashCode => days.hashCode;

  RoomWeekSettings copyWith({List<RoomWeekdaySetting>? days}) {
    return RoomWeekSettings(days: days ?? this.days);
  }
}

class RoomWeekSettingsDto {
  const RoomWeekSettingsDto({required this.days});

  factory RoomWeekSettingsDto.fromMap(List<dynamic> days) {
    return RoomWeekSettingsDto(
      days:
          days.map((object) => RoomWeekdaySettingDto.fromMap(object)).toList(),
    );
  }

  factory RoomWeekSettingsDto.fromEntity(RoomWeekSettings settings) {
    return RoomWeekSettingsDto(
      days: settings.days
          .map((setting) => RoomWeekdaySettingDto.fromEntity(setting))
          .toList(),
    );
  }

  final List<RoomWeekdaySettingDto> days;

  RoomWeekSettings toEntity() => RoomWeekSettings(
        days: days.map((setting) => setting.toEntity()).toList(),
      );

  List<dynamic> toMap() => days.map((setting) => setting.toMap()).toList();
}
