import 'dart:convert';

import 'package:book_talk/src/feature/account/model/user.dart';

class UserDto {
  const UserDto({
    required this.id,
    required this.name,
    required this.avatar,
  });

  factory UserDto.fromJson(String json) {
    final data = jsonDecode(json);

    return UserDto(
      id: data['id'],
      name: data['name'],
      avatar: data['avatar'],
    );
  }

  final String id;
  final String name;
  final String avatar;

  User toEntity() => User(
        id: id,
        name: name,
        avatar: avatar,
      );
}
