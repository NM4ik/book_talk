import 'dart:convert';

class UserDto {
  final String id;
  final String name;
  final String avatar;

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

  User toEntity() => User(
        id: id,
        name: name,
        avatar: avatar,
      );
}

class User {
  final String id;
  final String name;
  final String avatar;

  const User({
    required this.id,
    required this.name,
    required this.avatar,
  });

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
    return other.id == id && other.name == name && other.avatar == avatar;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ avatar.hashCode;

  @override
  String toString() => 'User(id: $id, name: $name, avatar: $avatar)';
}
