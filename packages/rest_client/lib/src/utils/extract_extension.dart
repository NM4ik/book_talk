/// Extracts [Map] from [Object]
extension ExtractExtension on Object? {
  Map<String, Object?>? get safeExtract {
    if (this is Map<String, Object?>) {
      return this as Map<String, Object?>;
    } else {
      return null;
    }
  }
}
