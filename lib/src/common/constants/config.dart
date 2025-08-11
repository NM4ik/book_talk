// ignore_for_file: do_not_use_environment

/// {@category common}
/// [Config] provides the main configuration for the application.
class Config {
  /// @nodoc.
  const Config();

  /// {@macro environment}
  Environment get environment =>
      Environment.from(const String.fromEnvironment('ENVIRONMENT'));
}

/// {@template environment}
/// [Environment] specifies the runtime mode of the application.
/// {@endtemplate}
enum Environment {
  dev,
  prod;

  /// Returns an [Environment] instance based on the given environment string.
  static Environment from(String env) => switch (env) {
    'dev' => Environment.dev,
    'prod' => Environment.prod,
    _ => throw ArgumentError.value(env, 'Environment', 'Invalid environment'),
  };

  /// True if the app is running in development mode.
  bool get isDev => this == dev;

  /// True if the app is running in production mode.
  bool get isProd => this == prod;
}
