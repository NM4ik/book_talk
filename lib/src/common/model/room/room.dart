import 'package:book_talk/src/common/model/room/room_day_setting.dart';
import 'package:book_talk/src/common/model/room/room_week_settings.dart';
import 'package:book_talk/src/feature/room_detail/model/file_image.dart'
    as fileImageInternal;
import 'package:flutter/material.dart';

sealed class IRoom {
  const IRoom({
    required this.name,
    required this.capacity,
    required this.roomWeekSettings,
    required this.isActive,
  });

  /// Name of the room.
  final String name;

  /// Capacity of the room (number of people it can hold).
  final int capacity;

  /// Weekly schedule settings for the room.
  /// {@macro RoomWeekSettings}
  final RoomWeekSettings roomWeekSettings;

  /// Indicates whether the room is currently active.
  final bool isActive;

  IRoom copyWith({
    RoomWeekSettings? roomWeekSettings,
    int? capacity,
    bool? isActive,
    String? name,
  });

  static int get roomMaxCapacity => 9999;
}

class EmptyRoom extends IRoom {
  const EmptyRoom({
    super.name = '',
    super.capacity = 1,
    super.roomWeekSettings = _roomSettings,
    super.isActive = false,
    this.fileImage,
  });

  final fileImageInternal.FileImage? fileImage;

  EmptyRoom copyWith({
    int? capacity,
    String? name,
    RoomWeekSettings? roomWeekSettings,
    bool? isActive,
    fileImageInternal.FileImage? fileImage,
  }) {
    return EmptyRoom(
      capacity: capacity ?? this.capacity,
      name: name ?? this.name,
      roomWeekSettings: roomWeekSettings ?? this.roomWeekSettings,
      isActive: isActive ?? this.isActive,
      fileImage: fileImage ?? this.fileImage,
    );
  }

  @override
  int get hashCode =>
      Object.hashAll([name, capacity, roomWeekSettings, isActive, fileImage]);

  @override
  bool operator ==(Object other) {
    return other is EmptyRoom &&
        other.name == name &&
        other.capacity == capacity &&
        other.roomWeekSettings == roomWeekSettings &&
        other.isActive == isActive &&
        other.fileImage == fileImage;
  }
}

/// Represents a room with properties including ID, capacity, and weekly settings.
class Room extends IRoom {
  /// Creates a room instance with specified details and settings.
  const Room({
    required super.name,
    required super.capacity,
    required super.roomWeekSettings,
    required super.isActive,
    required this.avatar,
    required this.id,
  });

  /// Unique identifier for the room.
  final int id;

  /// Avatar image or icon representing the room.
  final String? avatar;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Room &&
        other.id == id &&
        other.capacity == capacity &&
        other.avatar == avatar &&
        other.name == name &&
        other.roomWeekSettings == roomWeekSettings &&
        other.isActive == isActive;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        capacity.hashCode ^
        avatar.hashCode ^
        name.hashCode ^
        roomWeekSettings.hashCode ^
        isActive.hashCode;
  }

  Room copyWith({
    int? id,
    int? capacity,
    String? avatar,
    String? name,
    RoomWeekSettings? roomWeekSettings,
    bool? isActive,
  }) {
    return Room(
      id: id ?? this.id,
      capacity: capacity ?? this.capacity,
      avatar: avatar ?? this.avatar,
      name: name ?? this.name,
      roomWeekSettings: roomWeekSettings ?? this.roomWeekSettings,
      isActive: isActive ?? this.isActive,
    );
  }
}

class RoomDto {
  const RoomDto({
    required this.id,
    required this.capacity,
    required this.avatar,
    required this.name,
    required this.roomWeekSettings,
    required this.isActive,
  });

  factory RoomDto.fromMap(Map<String, Object?> map) {
    print(
        'roomSettings - ${map['roomWeekSettings'].runtimeType}, : ${map['roomWeekSettings']}');
    return RoomDto(
      id: map['id'] as int,
      capacity: map['capacity'] as int,
      avatar: map['avatar'] as String,
      name: map['name'] as String,
      roomWeekSettings: RoomWeekSettingsDto.fromMap(
        map['roomWeekSettings'] as List<dynamic>,
      ),
      isActive: map['isActive'] as bool,
    );
  }

  factory RoomDto.fromEntity(Room room) {
    return RoomDto(
      id: room.id,
      capacity: room.capacity,
      avatar: room.avatar,
      name: room.name,
      roomWeekSettings: RoomWeekSettingsDto.fromEntity(room.roomWeekSettings),
      isActive: room.isActive,
    );
  }

  final int id;
  final int capacity;
  final String? avatar;
  final String name;
  final RoomWeekSettingsDto roomWeekSettings;
  final bool isActive;

  Room toEntity() => Room(
        id: id,
        capacity: capacity,
        avatar: avatar,
        name: name,
        roomWeekSettings: roomWeekSettings.toEntity(),
        isActive: isActive,
      );

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'capacity': capacity,
      'avatar': avatar,
      'name': name,
      'roomWeekSettings': roomWeekSettings.toMap(),
      'isActive': isActive,
    };
  }

  @override
  String toString() {
    return 'RoomDto(id: $id, capacity: $capacity, avatar: $avatar, name: $name, roomWeekSettings: $roomWeekSettings, isActive: $isActive)';
  }
}

const _start = TimeOfDay(hour: 8, minute: 0);
const _end = TimeOfDay(hour: 24, minute: 0);
const _roomSettings = RoomWeekSettings(
  days: [
    RoomWeekdaySetting(
      priority: 1,
      day: 'Monday',
      isActive: true,
      startTime: _start,
      endTime: _end,
    ),
    RoomWeekdaySetting(
      priority: 2,
      day: 'Tuesday',
      isActive: true,
      startTime: _start,
      endTime: _end,
    ),
    RoomWeekdaySetting(
      priority: 3,
      day: 'Wednesday',
      isActive: true,
      startTime: _start,
      endTime: _end,
    ),
    RoomWeekdaySetting(
      priority: 4,
      day: 'Thursday',
      isActive: true,
      startTime: _start,
      endTime: _end,
    ),
    RoomWeekdaySetting(
      priority: 5,
      day: 'Friday',
      isActive: true,
      startTime: _start,
      endTime: _end,
    ),
    RoomWeekdaySetting(
      priority: 6,
      day: 'Saturday',
      isActive: true,
      startTime: _start,
      endTime: _end,
    ),
    RoomWeekdaySetting(
      priority: 7,
      day: 'Sunday',
      isActive: true,
      startTime: _start,
      endTime: _end,
    ),
  ],
);
