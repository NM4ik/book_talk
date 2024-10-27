import 'dart:async';
import 'package:book_talk/src/common/utils/interface/closable.dart';
import 'package:book_talk/src/common/utils/preferences_storage/preferences_entry.dart';
import 'package:book_talk/src/common/utils/preferences_storage/preferences_storage.dart';

abstract interface class AuthStorage<T> implements Closable {
  /// Load auth token from storage
  ///
  /// If null -> user not authenticated
  Future<T?> get();

  Future<void> save(T data);

  Future<void> clear();

  /// Auth changes notifier
  Stream<T?> authStream();
}

final class AuthStorageImpl implements AuthStorage<String> {
  AuthStorageImpl({required PreferencesStorage preferencesStorage})
      : _tokenEntry = StringPreferencesStorageEntry(
          preferencesStorage: preferencesStorage,
          key: 'auth.token',
        );

  final PreferencesStorageEntry<String> _tokenEntry;
  final _streamController = StreamController<String?>.broadcast();

  @override
  Future<String?> get() async => await _tokenEntry.get();

  @override
  Future<void> save(String data) async => await _tokenEntry.set(data);

  @override
  Future<void> clear() async => await _tokenEntry.remove();

  @override
  Future<void> close() async {
    await _streamController.close();
  }

  @override
  Stream<String?> authStream() => _streamController.stream;
}
