import 'package:book_talk/src/common/model/room/room.dart';
import 'package:book_talk/src/feature/rooms/data/rooms_datasource.dart';

/// Repository for accessing and managing room data.
abstract interface class RoomsRepository {
  const RoomsRepository();

  /// Returns a list of all rooms.
  Future<List<Room>> fetchRooms();

  /// Deletes a room by its [id]. Returns `true` if successful.
  Future<bool> deleteRoom(int id);
}

final class RoomsRepositoryImpl extends RoomsRepository {
  const RoomsRepositoryImpl({required RoomsDatasource roomsDatasource})
      : _roomsDatasource = roomsDatasource;

  final RoomsDatasource _roomsDatasource;

  @override
  Future<List<Room>> fetchRooms() async {
    final roomsResponse = await _roomsDatasource.fetchRooms();
    return roomsResponse.map((roomDto) => roomDto.toEntity()).toList();
  }

  @override
  Future<bool> deleteRoom(int id) async =>
      _roomsDatasource.deleteRoom(id);
}
