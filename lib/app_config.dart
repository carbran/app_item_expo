// ignore_for_file: constant_identifier_names

class AppConfig {
  final String appName;
  final Flavor flavor;

  AppConfig({
    required this.appName,
    required this.flavor,
  });
}

enum Flavor {
  PRODUCTION,
  DEVELOPMENT,
}