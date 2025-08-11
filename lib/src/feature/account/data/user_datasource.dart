import 'package:book_talk/src/common/rest_api/rest_api.dart';
import 'package:book_talk/src/feature/account/model/user_dto.dart';

abstract interface class UserDatasource {
  Future<UserDto?> fetchUser();
}

final class UserDatasourceImpl implements UserDatasource {
  const UserDatasourceImpl({required RestClient restClient})
    : _restClient = restClient;

  final RestClient _restClient;

  @override
  Future<UserDto?> fetchUser() async {
    final response = await _restClient.get(path: 'me');
    final Object? userJson = response.data?['user'];
    if (!response.success || userJson is! Map<String, Object?>) return null;
    return UserDto.fromJson(userJson);
  }
}
