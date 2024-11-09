/// {@category common}
/// [Config] provides the main configuration for the application.
class Config {
  /// @nodoc.
  const Config();

  /// {@macro environment}
  Environment get environment => Environment.from(
        const String.fromEnvironment('ENVIRONMENT'),
      );
}

/// {@template environment}
/// [Environment] specifies the runtime mode of the application.
/// {@endtemplate}
enum Environment {
  dev,
  prod,
  unknown;

  /// Returns an [Environment] instance based on the given environment string.
  static Environment from(String env) => switch (env) {
        'dev' => Environment.dev,
        'prod' => Environment.prod,
        _ => Environment.unknown,
      };

  /// True if the app is running in development mode.
  bool get isDev => this == dev;

  /// True if the app is running in production mode.
  bool get isProd => this == prod;
}
