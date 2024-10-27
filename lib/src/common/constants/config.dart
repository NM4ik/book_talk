/// [Config] Main information about the application configuration.
class Config {
  const Config();

  /// environment from starter
  Environment get environment => Environment.from(
        const String.fromEnvironment('ENVIRONMENT'),
      );
}

/// [Environment] describes in what mode the app was started.
enum Environment {
  dev,
  prod,
  unknown;

  static from(
    String env,
  ) =>
      switch (env) {
        'dev' => Environment.dev,
        'prod' => Environment.prod,
        _ => Environment.unknown,
      };

  bool get isDev => this == dev;
  bool get isProd => this == prod;
}
