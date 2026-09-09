final class ApiEnvironment {
  const ApiEnvironment({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 5),
    this.sendTimeout = const Duration(seconds: 10),
    this.receiveTimeout = const Duration(seconds: 15),
  });

  factory ApiEnvironment.fromEnvironment() {
    const baseUrl = String.fromEnvironment('API_BASE_URL');
    return const ApiEnvironment(baseUrl: baseUrl);
  }

  final String baseUrl;
  final Duration connectTimeout;
  final Duration sendTimeout;
  final Duration receiveTimeout;

  Uri validate() {
    final uri = Uri.tryParse(baseUrl);
    if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
      throw StateError('API_BASE_URL must be an absolute URL.');
    }
    return uri;
  }
}
