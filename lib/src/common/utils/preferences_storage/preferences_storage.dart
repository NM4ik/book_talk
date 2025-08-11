import 'package:shared_preferences/shared_preferences.dart';

/// Representing a generic storage interface for preferences.
abstract class PreferencesStorage {
  const PreferencesStorage();

  /// Stores a string value associated with the given [key].
  Future<void> setString(String key, String target);

  /// Retrieves a string value associated with the given [key].
  /// Returns `null` if the key does not exist.
  Future<String?> getString(String key);

  /// Removes the value associated with the given [key].
  Future<void> remove(String key);
}

/// A concrete implementation of [PreferencesStorage] using `SharedPreferencesAsync`.
/// Uses an instance of [SharedPreferencesAsync] to persist and manage data.
final class PreferencesStorage$SharedPref extends PreferencesStorage {
  const PreferencesStorage$SharedPref({
    required SharedPreferencesAsync sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferencesAsync _sharedPreferences;

  @override
  Future<String?> getString(String key) async =>
      _sharedPreferences.getString(key);

  @override
  Future<void> setString(String key, String target) =>
      _sharedPreferences.setString(key, target);

  @override
  Future<void> remove(String key) async => _sharedPreferences.remove(key);
}
