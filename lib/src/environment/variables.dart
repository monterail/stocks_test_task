class EnvironmentVariables {
  static const String appName = String.fromEnvironment(
    'APP_NAME',
    defaultValue: 'Unflavored app name',
  );
  static const String appSuffix = String.fromEnvironment('APP_SUFFIX');
  static const String polygonApiKey = String.fromEnvironment('POLYGON_API_KEY');
  static const String baseUrl = String.fromEnvironment('BASE_URL');
}
