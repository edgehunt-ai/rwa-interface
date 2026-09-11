import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/observability/sentry_event_sanitizer.dart';
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
}
