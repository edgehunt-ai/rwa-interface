import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/api_environment.dart';

void main() {
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
