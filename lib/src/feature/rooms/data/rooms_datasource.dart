import 'package:book_talk/src/feature/rooms/model/room_dto.dart';

abstract interface class RoomsDatasource {
  Future<List<RoomDto>> fetchRooms();
}

final class RoomsDatasourceImpl extends RoomsDatasource {
  @override
  Future<List<RoomDto>> fetchRooms() async {
    return await Future.delayed(
      const Duration(seconds: 3),
      () async => _mockJson
          .map(
            (object) => RoomDto.fromMap(object),
          )
          .toList(),
    );
  }
}

final _mockJson = [
  {
    'id': 1,
    'name': 'Small Meeting Room, Saint-Petersburg, BC Elizarovsky',
    'capacity': 3,
    'open_time': '09:00',
    'close_time': '18:00',
    'avatar':
        'https://images.stockcake.com/public/d/d/c/ddc17eaf-de46-461d-862c-07d6fecacab5_medium/corporate-meeting-room-stockcake.jpg',
  },
  {
    'id': 2,
    'capacity': 15,
    'name': 'Medium Meeting Room, Saint-Petersburg, BC Elizarovsky',
    'open_time': '09:00',
    'close_time': '18:00',
    'avatar':
        'https://images.stockcake.com/public/6/d/d/6dd3f553-2ded-4c6d-b457-5b52dba0bfb8_medium/modern-meeting-room-stockcake.jpg',
  },
  {
    'id': 3,
    'capacity': 52,
    'name': 'Big Meeting Room, Saint-Petersburg, BC Elizarovsky',
    'open_time': '10:00',
    'close_time': '21:00',
    'avatar':
        'https://acv-productive.imgix.net/wp-content/uploads/2022/11/Austria-Center-Vienna_Level1_Raum-1-61_1-62_WLB_8808_2022_2880x1920.jpg?auto=format',
  },
  {
    'id': 4,
    'capacity': 15,
    'name': 'Medium Meeting Room, Moscow, Moscow-City',
    'open_time': '12:00',
    'close_time': '24:00',
    'avatar':
        'https://files.idyllic.app/files/static/2561985?width=1080&optimizer=image',
  },
  {
    'id': 5,
    'capacity': 12,
    'name': 'Midi Meeting Room, Moscow, Moscow-City',
    'open_time': '08:00',
    'close_time': '24:00',
    'avatar':
        'https://files.idyllic.app/files/static/94138?width=1080&optimizer=image',
  },
  {
    'id': 6,
    'capacity': 24,
    'name': 'Big-Midi Meeting Room, Moscow, Moscow-City',
    'open_time': '04:30',
    'close_time': '16:30',
    'avatar':
        'https://files.idyllic.app/files/static/94082?width=1080&optimizer=image',
  },
];
