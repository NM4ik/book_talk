import 'package:book_talk/src/feature/account/data/user_datasource.dart';
import 'package:book_talk/src/feature/account/model/user.dart';
import 'package:book_talk/src/feature/account/model/user_dto.dart';

abstract interface class UserRepository {
  Future<User?> fetchUser();
}

final class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl({required UserDatasource userDatasource})
    : _userDatasource = userDatasource;

  final UserDatasource _userDatasource;

  @override
  Future<User?> fetchUser() async {
    final UserDto? userDto = await _userDatasource.fetchUser();
    return userDto?.toEntity();
  }
}
