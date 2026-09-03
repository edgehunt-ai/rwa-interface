import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_environment.dart';

void main() {
  test('production rejects missing, HTTP, and staging URLs', () {
    for (final url in [
      '',
      'http://api.example.com',
      'https://api-staging.example.com',
    ]) {
      expect(
        () => ApiEnvironment(
          baseUrl: url,
          environment: AppEnvironment.production,
        ).validate(),
        throwsStateError,
      );
    }
  });

  test('production accepts explicit HTTPS URL', () {
    expect(
      ApiEnvironment(
        baseUrl: 'https://api.example.com',
        environment: AppEnvironment.production,
      ).validate().host,
      'api.example.com',
    );
  });
}
