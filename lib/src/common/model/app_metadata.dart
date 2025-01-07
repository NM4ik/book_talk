/// {@category common}
/// Contains metadata about the app environment, version, operating system, and locale.
///
/// The [AppMetadata] class is used to represent and organize key information
/// about the app's runtime environment. This data can be converted to a
/// header-friendly format using [convertHeaders], making it easy to include
/// as metadata in HTTP requests or logs.
class AppMetadata {
  const AppMetadata({
    required this.environment,
    required this.appVersion,
    required this.operatingSystem,
    required this.locale,
  });

  final String environment;
  final String appVersion;
  final String operatingSystem;
  final String locale;

  /// Converts metadata fields into a map of headers.
  Map<String, String> convertHeaders() => {
        'X-Meta-Environment': environment,
        'X-Meta-App-Version': appVersion,
        'X-Meta-Operating-System': operatingSystem,
        'X-Meta-Locale': locale,
      };
}
