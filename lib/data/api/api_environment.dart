enum AppEnvironment { development, staging, production, test }

final class ApiEnvironment {
  const ApiEnvironment({
    required this.baseUrl,
    required this.environment,
    this.connectTimeout = const Duration(seconds: 5),
    this.sendTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 15),
  });

  factory ApiEnvironment.fromEnvironment() {
    const baseUrl = String.fromEnvironment('API_BASE_URL');
    const name = String.fromEnvironment(
      'APP_ENVIRONMENT',
      defaultValue: 'development',
    );
    final environment = AppEnvironment.values.firstWhere(
      (value) => value.name == name,
      orElse: () => AppEnvironment.development,
    );
    return ApiEnvironment(baseUrl: baseUrl, environment: environment);
  }

  final String baseUrl;
  final AppEnvironment environment;
  final Duration connectTimeout;
  final Duration sendTimeout;
  final Duration receiveTimeout;

  Uri validate() {
    final uri = Uri.tryParse(baseUrl);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      throw StateError('API_BASE_URL must be an absolute URL.');
    }
    if (environment == AppEnvironment.production &&
        (uri.scheme != 'https' || uri.host.contains('staging'))) {
      throw StateError(
        'Production API_BASE_URL must be HTTPS and non-staging.',
      );
    }
    return uri;
  }
}
