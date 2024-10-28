import 'package:book_talk/src/feature/account/data/user_datasource.dart';
import 'package:book_talk/src/feature/account/model/user.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class UserRepository {
  /// Fetch user data
  Future<User?> fetchUser(String token);

  /// Get user data
  Stream<User?> get userStream;
  User? get user;
}

final class UserRepositoryImpl extends UserRepository {
  final UserDatasource _userDatasource;

  UserRepositoryImpl({required UserDatasource userDatasource})
      : _userDatasource = userDatasource;

  final _userSubject = BehaviorSubject<User?>();

  @override
  Future<User?> fetchUser(String token) async {
    final user = await _userDatasource.fetchUser(token);
    _userSubject.add(user);
    return user;
  }

  @override
  User? get user => _userSubject.valueOrNull;

  @override
  Stream<User?> get userStream => _userSubject.stream;
}
