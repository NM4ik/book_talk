import 'package:flutter/foundation.dart';

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
  prod;

  static from(
    String env,
  ) =>
      switch (env) {
        'dev' => Environment.dev,
        'prod' => Environment.prod,
        _ => kReleaseMode ? Environment.prod : Environment.dev,
      };

  bool get isDev => this == dev;
  bool get isProd => this == prod;
}
