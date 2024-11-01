import 'dart:convert';

import 'package:book_talk/src/feature/account/model/user.dart';
import 'package:book_talk/src/feature/account/model/user_dto.dart';
import 'package:uuid/uuid.dart';

abstract interface class UserDatasource<T> {
  Future<User> fetchUser(T token);
}

final class UserDatasourceImpl<T> extends UserDatasource<T> {
  @override
  Future<User> fetchUser(T token) async {
    return await Future.delayed(
      const Duration(seconds: 1),
      () => UserDto.fromJson(jsonEncode(_getMockUser)).toEntity(),
    );
  }

  Map<String, dynamic> get _getMockUser => {
        'id': const Uuid().v6(),
        'name': 'Nikita Mikhailov',
        'avatar': 'https://avatars.githubusercontent.com/u/78036389?v=4',
      };
}
