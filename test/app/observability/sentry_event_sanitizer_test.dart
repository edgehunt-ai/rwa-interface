import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/sentry_event_sanitizer.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  test('removes request data and redacts event content', () {
    final event = SentryEvent(
      user: SentryUser(
        id: 'user-1',
        email: 'person@example.com',
        data: {'wallet_address': '0xabc'},
      ),
      request: SentryRequest(
        url: 'https://api.example.test/orders?token=secret',
        headers: {'Authorization': 'Bearer secret'},
      ),
      tags: {'operation': 'create_order', 'wallet_address': '0xabc'},
      message: SentryMessage('person@example.com Bearer secret'),
      breadcrumbs: [
        Breadcrumb(
          message: 'token=secret',
          data: {'amount': '100', 'address': '0xabc'},
        ),
      ],
      exceptions: [
        SentryException(type: 'StateError', value: 'email=person@example.com'),
      ],
      contexts: Contexts()..['funding'] = {'amount': '100'},
    );

    final sanitized = SentryEventSanitizer.sanitize(event, Hint());

    expect(sanitized.request, isNull);
    expect(sanitized.user?.toJson(), {'id': 'user-1'});
    expect(sanitized.tags, {'operation': 'create_order'});
    expect(sanitized.contexts.containsKey('funding'), isFalse);
    expect(sanitized.message?.formatted, contains('<redacted-email>'));
    expect(sanitized.breadcrumbs!.single.data, isNull);
    expect(sanitized.breadcrumbs!.single.message, 'token=<redacted>');
    expect(sanitized.exceptions!.single.value, contains('<redacted-email>'));
  });

  test('redacts credential and wallet secret formats', () {
    const privateKey = '0x0123456789abcdef';
    const mnemonic = 'alpha beta gamma delta';
    const password = 'correct-horse-battery-staple';
    const clientSecret = 'client-secret-value';
    final value = SentryEventSanitizer.redact(
      'private_key=$privateKey '
      'mnemonic="$mnemonic" '
      'password:$password '
      '{"client_secret":"$clientSecret"} '
      'https://example.test/callback?api_key=api-key-value',
    );

    expect(value, isNot(contains(privateKey)));
    expect(value, isNot(contains(mnemonic)));
    expect(value, isNot(contains(password)));
    expect(value, isNot(contains(clientSecret)));
    expect(value, isNot(contains('api-key-value')));
    expect('<redacted>'.allMatches(value), hasLength(5));
  });

  test('drops tags whose keys identify secrets', () {
    final event = SentryEvent(
      tags: {
        'operation': 'sign_in',
        'private_key': 'private',
        'mnemonic_phrase': 'words',
        'client_secret': 'secret',
        'password_reset': 'password',
      },
    );

    final sanitized = SentryEventSanitizer.sanitize(event, Hint());

    expect(sanitized.tags, {'operation': 'sign_in'});
  });
}
