import 'dart:async';
import 'dart:math';
import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/feature/rooms/data/rooms_datasource.dart';
import 'package:flutter/material.dart';

abstract interface class RoomDetailRepository {
  // FutureOr<RoomWeekSettings> getRoomWeekdaySettings({int? roomId});

  Future<bool> createRoom(EmptyRoom room);

  Future<bool> editRoom(Room room);

  Future<bool> deleteRoom(Room room);
}

// TODO(Mikhailov): implement datasource for this repo or use from rooms datasource
// (if rooms datasource - make him common, ig)
final class RoomDetailRepositoryImpl implements RoomDetailRepository {
  @override
  Future<bool> createRoom(EmptyRoom room) async {
    final isCreated = await Future<bool>.delayed(
      const Duration(seconds: 2),
      () => Random().nextBool(),
    );

    if (!isCreated) {
      throw Exception('Unexpected error. Room was not created');
    }
    addToMockData(room);

    return isCreated;
  }

  @override
  Future<bool> editRoom(Room room) async {
    final isCreated = await Future<bool>.delayed(
      const Duration(seconds: 2),
      () => Random().nextBool(),
    );

    if (!isCreated) {
      throw Exception('Unexpected error. Room was not updated');
    }

    updateMockData(RoomDto.fromEntity(room).toMap());
    return isCreated;
  }

  @override
  Future<bool> deleteRoom(Room room) async {
    final isDeleted = await Future<bool>.delayed(
      const Duration(seconds: 2),
      () => Random().nextBool(),
    );

    if (!isDeleted) {
      throw Exception('Unexpected error. Room ${room.name} was not deleted');
    }
    deleteMockData(room);

    return isDeleted;
  }

  @visibleForTesting
  void addToMockData(EmptyRoom emptyRoom) {
    remoteRoomsMockData.add({
      'id': Random().nextInt(99999),
      'name': emptyRoom.name,
      'capacity': emptyRoom.capacity,
      'avatar':
          'https://cdn.shopify.com/s/files/1/0605/0136/0804/files/Modern_meeting_room_with_advanced_technology.jpg?v=1703751846',
      'isActive': emptyRoom.isActive,
      'roomWeekSettings': emptyRoom.roomWeekSettings.days
          .map(
            (day) => {
              'priority': day.priority,
              'day': day.day,
              'isActive': day.isActive,
              'startTime': '${day.startTime.hour}:${day.startTime.minute}',
              'endTime': '${day.endTime.hour}:${day.endTime.minute}',
            },
          )
          .toList(),
    });
  }

  @visibleForTesting
  void updateMockData(Map<String, dynamic> roomData) {
    final index = remoteRoomsMockData.indexWhere(
      (room) => room['id'] == roomData['id'],
    );

    if (index == -1) {
      throw Exception('Room not found in mock data');
    }

    remoteRoomsMockData[index] = roomData;
  }

  @visibleForTesting
  void deleteMockData(Room room) {
    final index = remoteRoomsMockData.indexWhere(
      (data) => data['id'] == room.id,
    );

    if (index == -1) {
      throw Exception('Room ${room.name} not found in mock data');
    }

    remoteRoomsMockData.removeAt(index);
  }
}
