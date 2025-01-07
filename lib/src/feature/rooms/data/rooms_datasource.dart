import 'dart:math';
import 'package:book_talk/src/common/model/room/room.dart';

/// Interface for managing room data.
abstract interface class RoomsDatasource {
  /// Returns a list of all available rooms.
  Future<List<RoomDto>> fetchRooms();

  /// Deletes a room by its [id]. Returns `true` if successful.
  Future<bool> deleteRoom(int id);
}

final class RoomsDatasourceImpl extends RoomsDatasource {
  @override
  Future<List<RoomDto>> fetchRooms() async {
    return await Future.delayed(
      const Duration(seconds: 3),
      () async => remoteRoomsMockData
          .map(
            (object) => RoomDto.fromMap(object),
          )
          .toList(),
    );
  }

  @override
  Future<bool> deleteRoom(int id) async {
    final isDeleted = await Future.delayed(
      const Duration(seconds: 1),
      () => Random().nextBool(),
    );

    if (isDeleted) {
      remoteRoomsMockData.removeWhere((item) => item['id'] == id);

      return true;
    }

    return false;
  }
}

final List<Map<String, dynamic>> remoteRoomsMockData = [
  {
    'id': 1,
    'name': 'Small Meeting Room, Saint-Petersburg, BC Elizarovsky',
    'capacity': 24,
    'avatar':
        'https://images.stockcake.com/public/d/d/c/ddc17eaf-de46-461d-862c-07d6fecacab5_medium/corporate-meeting-room-stockcake.jpg',
    'isActive': true,
    'roomWeekSettings': [
      {
        'priority': 1,
        'day': 'Monday',
        'isActive': true,
        'startTime': '09:30',
        'endTime': '21:30',
      },
      {
        'priority': 2,
        'day': 'Tuesday',
        'isActive': true,
        'startTime': '09:30',
        'endTime': '21:30',
      },
      {
        'priority': 3,
        'day': 'Wednesday',
        'isActive': true,
        'startTime': '09:30',
        'endTime': '21:30',
      },
      {
        'priority': 4,
        'day': 'Thursday',
        'isActive': true,
        'startTime': '09:30',
        'endTime': '21:30',
      },
      {
        'priority': 5,
        'day': 'Friday',
        'isActive': true,
        'startTime': '09:30',
        'endTime': '21:30',
      },
      {
        'priority': 6,
        'day': 'Saturday',
        'isActive': false,
        'startTime': '09:30',
        'endTime': '21:30',
      },
      {
        'priority': 7,
        'day': 'Sunday',
        'isActive': true,
        'startTime': '09:30',
        'endTime': '21:30',
      },
    ],
  },
];
