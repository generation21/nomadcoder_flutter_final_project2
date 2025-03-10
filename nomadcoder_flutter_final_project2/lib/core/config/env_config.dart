import 'package:flutter_dotenv/flutter_dotenv.dart';

enum Environment { local, dev, prod }

class EnvConfig {
  final String apiBaseUrl;
  final Environment environment;

  EnvConfig({required this.apiBaseUrl, required this.environment});

  factory EnvConfig.local() => EnvConfig(
    apiBaseUrl:
        "http://localhost:8000", //dotenv.get("API_URL", fallback: "http://localhost:8000"),
    environment: Environment.local,
  );

  factory EnvConfig.dev() => EnvConfig(
    apiBaseUrl: dotenv.get("API_URL", fallback: "http://localhost:8000"),
    environment: Environment.dev,
  );

  factory EnvConfig.prod() => EnvConfig(
    apiBaseUrl: dotenv.get("API_URL", fallback: "http://localhost:8000"),
    environment: Environment.prod,
  );

  static late EnvConfig _instance;

  static void init({required Environment env}) {
    switch (env) {
      case Environment.local:
        _instance = EnvConfig.local();
      case Environment.dev:
        _instance = EnvConfig.dev();
      case Environment.prod:
        _instance = EnvConfig.prod();
    }
  }

  static EnvConfig get instance => _instance;
}
