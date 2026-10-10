import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/sentry_event_sanitizer.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() {
  test('drops network, timeout, and cancellation events', () {
    for (final failure in const <ApiFailure>[
      NetworkFailure(),
      TimeoutFailure(),
      CancelledFailure(),
    ]) {
      expect(
        SentryEventSanitizer.filterAndSanitize(
          SentryEvent(throwable: failure),
          Hint(),
        ),
        isNull,
      );
    }
  });

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
      contexts: Contexts()
        ..['funding'] = {'amount': '100'}
        ..trace = SentryTraceContext(
          operation: 'ui.action',
          description: 'submit token=secret',
          data: {'payload': 'must-not-survive'},
        )
        ..['business_operation'] = {
          'operation': 'create_order',
          'order_id': 'order-1',
          'amount': '100',
          'unknown': 'drop-me',
        }
        ..['privy_auth'] = {
          'safe_message': 'person@example.com code=123456 Bearer secret',
          'raw_payload': 'must-not-survive',
        },
    );

    final sanitized = SentryEventSanitizer.sanitize(event, Hint());

    expect(sanitized.request, isNull);
    expect(sanitized.user?.toJson(), {'id': 'user-1'});
    expect(sanitized.tags, {'operation': 'create_order'});
    expect(sanitized.contexts.containsKey('funding'), isFalse);
    expect(sanitized.contexts.trace, isNotNull);
    expect(sanitized.contexts.trace!.description, 'submit token=<redacted>');
    expect(sanitized.contexts.trace!.data, isNull);
    expect(sanitized.contexts['business_operation'], {
      'operation': 'create_order',
      'order_id': 'order-1',
    });
    expect(sanitized.contexts['privy_auth'], {
      'safe_message': '<redacted-email> code=<redacted> Bearer <redacted>',
    });
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

  test('keeps only safe structured breadcrumb fields', () {
    final event = SentryEvent(
      breadcrumbs: [
        Breadcrumb(
          category: 'business.operation',
          message: 'create_order:failed',
          data: {
            'operation': 'create_order',
            'outcome': 'failed',
            'request_id': 'request-1',
            'order_id': 'order-1',
            'amount': '100',
            'unknown': 'drop-me',
          },
        ),
        Breadcrumb.http(
          url: Uri.parse('https://api.example.test/orders?token=secret'),
          method: 'POST',
          statusCode: 503,
          requestDuration: const Duration(milliseconds: 125),
        ),
      ],
    );

    final sanitized = SentryEventSanitizer.sanitize(event, Hint());

    expect(sanitized.breadcrumbs![0].data, {
      'operation': 'create_order',
      'outcome': 'failed',
      'request_id': 'request-1',
      'order_id': 'order-1',
    });
    expect(sanitized.breadcrumbs![1].data, containsPair('method', 'POST'));
    expect(sanitized.breadcrumbs![1].data, containsPair('status_code', 503));
    expect(sanitized.breadcrumbs![1].data, isNot(contains('url')));
  });
}
