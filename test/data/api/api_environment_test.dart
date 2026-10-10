import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/api/api_environment.dart';

void main() {
  test('uses the shared API timeout defaults', () {
    const environment = ApiEnvironment(baseUrl: 'https://api.example.com');

    expect(environment.connectTimeout, const Duration(seconds: 7));
    expect(environment.sendTimeout, const Duration(seconds: 10));
    expect(environment.receiveTimeout, const Duration(seconds: 15));
  });

  test('rejects missing and relative URLs', () {
    for (final url in ['', '/v1']) {
      expect(() => ApiEnvironment(baseUrl: url).validate(), throwsStateError);
    }
  });

  test('accepts an absolute URL without environment policy', () {
    expect(
      const ApiEnvironment(baseUrl: 'http://api-staging.example.com')
          .validate()
          .host,
      'api-staging.example.com',
    );
  });
}
