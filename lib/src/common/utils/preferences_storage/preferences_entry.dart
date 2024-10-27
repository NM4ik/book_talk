import 'package:book_talk/src/common/utils/preferences_storage/preferences_storage.dart';

/// Class represents an entry in the preferences storage.
/// It defines methods to get, set, and remove values of type [T].
abstract class PreferencesStorageEntry<T extends Object> {
  const PreferencesStorageEntry({
    required this.key,
    required this.preferencesStorage,
  });

  final String key;
  final PreferencesStorage preferencesStorage;

  /// Retrieves the value of type [T] from the storage.
  /// Returns `null` if the value does not exist.
  Future<T?> get();

  /// Stores the given [value] of type [T] in the storage.
  Future<void> set(T value);

  /// Removes the value associated with this entry from the storage.
  Future<void> remove();
}

/// A concrete implementation of [PreferencesStorageEntry] for storing and
/// retrieving `String` values in the preferences storage.
class StringPreferencesStorageEntry extends PreferencesStorageEntry<String> {
  const StringPreferencesStorageEntry({
    required super.preferencesStorage,
    required super.key,
  });

  @override
  Future<String?> get() async => preferencesStorage.getString(key);

  @override
  Future<void> remove() async => preferencesStorage.remove(key);

  @override
  Future<void> set(String value) async =>
      preferencesStorage.setString(key, value);
}
