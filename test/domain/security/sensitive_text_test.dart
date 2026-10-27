import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/security/sensitive_text.dart';

void main() {
  for (final key in [
    'client_secret',
    'client-secret',
    'clientSecret',
    'refresh_token',
    'refresh-token',
    'refreshToken',
    'accessToken',
    'idToken',
    'identityToken',
    'sessionToken',
    'privateKey',
    'apiKey',
  ]) {
    test('redacts $key in plain text, JSON, and URL parameters', () {
      for (final value in [
        'OAuth exchange failed [50152]: $key=demo-credential',
        'OAuth exchange failed [50152]: {"$key":"demo-credential"}',
        'OAuth exchange failed [50152]: https://example.test/?$key=demo-credential&provider=google',
      ]) {
        final safe = SensitiveTextRedactor.redact(value);
        expect(safe, isNot(contains('demo-credential')));
        expect(safe, contains('OAuth exchange failed [50152]'));
        expect(safe, contains('<redacted>'));
      }
    });
  }

  test('quoted values containing escaped quotes are removed completely', () {
    for (final value in [
      r'''OAuth failed: {"client_secret":"demo\"secret-tail"}''',
      r'''OAuth failed: {'refreshToken':'demo\'secret-tail'}''',
      r'''OAuth failed: client_secret="demo\"secret-tail"''',
    ]) {
      final safe = SensitiveTextRedactor.redact(value);
      expect(safe, isNot(contains('demo')));
      expect(safe, isNot(contains('secret-tail')));
      expect(safe, startsWith('OAuth failed:'));
    }
  });

  test('preserves safe status and diagnostic codes', () {
    const reason =
        'Browser unavailable [50152], HTTP 503, failure_code=browser_unavailable';
    expect(SensitiveTextRedactor.redact(reason), reason);
  });
}
