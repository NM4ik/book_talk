import 'package:book_talk/src/feature/rooms/data/rooms_datasource.dart';
import 'package:book_talk/src/feature/rooms/model/room.dart';

abstract interface class RoomsRepository {
  const RoomsRepository();

  /// Fetch rooms list data
  Future<List<Room>> fetchRooms();
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
}
