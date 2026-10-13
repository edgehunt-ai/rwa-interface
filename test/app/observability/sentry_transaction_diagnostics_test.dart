import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/observability/sentry_transaction_diagnostics.dart';

void main() {
  group('Sentry transaction diagnostics', () {
    test('reports Relay-required fields without exposing event data', () {
      final summary = SentryTransactionDiagnostics.summarize({
        'transaction': '/private/wallet/0xsecret',
        'request': {'url': 'https://example.invalid/token=secret'},
        'start_timestamp': '2026-10-13T10:00:00Z',
        'timestamp': '2026-10-13T10:00:02Z',
        'contexts': {
          'trace': {'trace_id': 'sensitive-trace', 'span_id': 'sensitive-span'},
        },
        'spans': [
          {
            'start_timestamp': '2026-10-13T10:00:00Z',
            'timestamp': '2026-10-13T10:00:01Z',
            'trace_id': 'sensitive-trace',
            'span_id': 'sensitive-child',
            'data': {'wallet': '0xsecret'},
          },
        ],
      });

      expect(summary, contains('root_order_valid=true'));
      expect(summary, contains('trace_id_present=true'));
      expect(summary, contains('span_count=1'));
      expect(summary, contains('span_missing_start=0'));
      expect(summary, isNot(contains('secret')));
      expect(summary, isNot(contains('sensitive')));
      expect(summary, isNot(contains('example.invalid')));
    });

    test('counts missing and reversed span fields', () {
      final summary = SentryTransactionDiagnostics.summarize({
        'start_timestamp': '2026-10-13T10:00:02Z',
        'timestamp': '2026-10-13T10:00:01Z',
        'spans': [
          {
            'start_timestamp': '2026-10-13T10:00:02Z',
            'timestamp': '2026-10-13T10:00:01Z',
          },
          {'start_timestamp': 'not-a-timestamp', 'span_id': 'present'},
        ],
      });

      expect(summary, contains('root_order_valid=false'));
      expect(summary, contains('trace_id_present=false'));
      expect(summary, contains('span_count=2'));
      expect(summary, contains('span_missing_start=1'));
      expect(summary, contains('span_missing_end=1'));
      expect(summary, contains('span_reversed=1'));
      expect(summary, contains('span_missing_trace_id=2'));
      expect(summary, contains('span_missing_span_id=1'));
    });
  });
}
