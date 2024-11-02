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

  Map<String, String> convertHeaders() => {
        'X-Meta-Environment': environment,
        'X-Meta-App-Version': appVersion,
        'X-Meta-Operating-System': operatingSystem,
        'X-Meta-Locale': locale,
      };
}
