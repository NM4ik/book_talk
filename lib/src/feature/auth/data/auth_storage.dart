import 'dart:async';
import 'dart:convert';
import 'package:book_talk/src/common/utils/interface/closable.dart';
import 'package:book_talk/src/common/utils/preferences_storage/preferences_entry.dart';
import 'package:book_talk/src/common/utils/preferences_storage/preferences_storage.dart';
import 'package:book_talk/src/feature/auth/model/auth_token.dart';
import 'package:rxdart/rxdart.dart';

abstract interface class AuthStorage implements Closable {
  /// Load auth token from storage
  ///
  /// If null -> user not authenticated
  Future<AuthToken?> get();

  Future<void> save(AuthToken data);

  Future<void> clear();

  /// Auth changes notifier
  Stream<AuthToken?> get authTokenStream;

  bool get isAuth;
}

final class AuthStorageImpl implements AuthStorage {
  AuthStorageImpl({required PreferencesStorage preferencesStorage})
      : _tokenEntry = StringPreferencesStorageEntry(
          preferencesStorage: preferencesStorage,
          key: 'auth.token',
        );

  final PreferencesStorageEntry<String> _tokenEntry;
  final BehaviorSubject<AuthToken?> _authTokenBehaviorSubject =
      BehaviorSubject<AuthToken?>();

  @override
  Future<AuthToken?> get() async {
    final String? json = await _tokenEntry.get();
    if (json == null || json.isEmpty) return null;
    final AuthToken token = AuthToken.fromJson(
      Map<String, Object?>.from(jsonDecode(json) as Map<String, Object?>),
    );
    _authTokenBehaviorSubject.add(token);
    return token;
  }

  @override
  Future<void> save(AuthToken token) async {
    await _tokenEntry.set(jsonEncode(token.toJson()));
    _authTokenBehaviorSubject.add(token);
  }

  @override
  Future<void> clear() async {
    await _tokenEntry.remove();
    _authTokenBehaviorSubject.add(null);
  }

  @override
  Future<void> close() async {
    await _authTokenBehaviorSubject.close();
  }

  @override
  Stream<AuthToken?> get authTokenStream => _authTokenBehaviorSubject.stream;

  @override
  bool get isAuth => _authTokenBehaviorSubject.valueOrNull != null;
}
