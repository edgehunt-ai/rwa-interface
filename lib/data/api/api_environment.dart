final class ApiEnvironment {
  const ApiEnvironment({
    required this.baseUrl,
    this.connectTimeout = const Duration(seconds: 7),
    this.sendTimeout = const Duration(seconds: 10),
    // Dio treats zero as unlimited: wait for the server's response while
    // retaining separate limits for establishing and sending the request.
    this.receiveTimeout = Duration.zero,
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
