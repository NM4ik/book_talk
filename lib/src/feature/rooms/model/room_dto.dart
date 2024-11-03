import 'package:book_talk/src/feature/rooms/model/room.dart';

class RoomDto {
  const RoomDto({
    required this.id,
    required this.capacity,
    required this.openTime,
    required this.closeTime,
    required this.avatar,
    required this.name,
  });

  factory RoomDto.fromMap(Map<String, Object?> map) {
    return RoomDto(
      id: map['id'] as int,
      capacity: map['capacity'] as int,
      openTime: map['open_time'] as String,
      closeTime: map['close_time'] as String,
      avatar: map['avatar'] as String,
      name: map['name'] as String,
    );
  }

  final int id;
  final int capacity;
  final String openTime;
  final String closeTime;
  final String avatar;
  final String name;

  Room toEntity() => Room(
        id: id,
        capacity: capacity,
        openTime: openTime,
        closeTime: closeTime,
        avatar: avatar,
        name: name,
      );
}
