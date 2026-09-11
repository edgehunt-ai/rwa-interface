import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/realtime_event_decoder.dart';
import 'package:rwa_interface/data/api/sse_frame.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

void main() {
  const decoder = RealtimeEventDecoder();

  test(
    'checked-in SDK decodes HIP3 snapshot members and enforces cursor format',
    () {
      const cursor = 'h3.11111111111111111111111111111111.9007199254740993';
      final payload = {
        'event': 'hip3_snapshot',
        'event_id': cursor,
        'emitted_at': '2026-09-11T00:00:00Z',
        'data': {
          'channels': ['hip3:price:testnet:frce:US30YFRM'],
          'signer': '0x1111111111111111111111111111111111111111',
          'environment': 'testnet',
          'completed_at': '2026-09-11T00:00:00Z',
          'items': [
            {
              'event': 'hip3_price',
              'data': {
                'product_id': 'frce:US30YFRM',
                'venue': 'frce',
                'environment': 'testnet',
                'settlement_asset': 'USDC',
                'tradable': false,
                'unavailable_reason': 'hip3_client_execution_unconfigured',
                'symbol': 'US30YFRM',
                'kind': 'perp',
                'price': '12.123456789',
                'change_24h_percent': '21',
                'updated_at': '2026-09-11T00:00:00Z',
                'source': 'hyperliquid_testnet',
                'fresh_until': '2026-09-11T00:00:30Z',
                'price_label': 'Mark price',
              },
            },
          ],
        },
      };
      final event = decoder.decode(
        SseFrame(id: cursor, event: 'hip3_snapshot', data: jsonEncode(payload)),
      );
      expect(event.eventId, cursor);
      final body = event.data['data'] as Map;
      expect(
        ((body['items'] as List).single as Map)['data']['price'],
        '12.123456789',
      );
      payload['event_id'] = '9007199254740993';
      expect(
        () => decoder.decode(SseFrame(data: jsonEncode(payload))),
        throwsA(isA<CompatibilityFailure>()),
      );
    },
  );

  test('SSE headers cannot contradict the validated JSON envelope', () {
    const json =
        '{"event_id":"42","emitted_at":"2026-09-03T00:00:00Z","event":"price","data":{"symbol":"NVDA","kind":"bstock","price":"1","change_24h_percent":"0","updated_at":"2026-09-03T00:00:00Z"}}';
    for (final frame in [
      const SseFrame(id: '43', event: 'price', data: json),
      const SseFrame(id: '42', event: 'hip3_snapshot', data: json),
    ]) {
      expect(() => decoder.decode(frame), throwsA(isA<CompatibilityFailure>()));
    }
  });

  test('generated serializer 验证 typed price event', () {
    const json =
        '''{"event_id":"42","emitted_at":"2026-09-03T00:00:00Z","event":"price","data":{"symbol":"NVDA","kind":"bstock","price":"123.4500","change_24h_percent":"1.2300","updated_at":"2026-09-03T00:00:00Z"}}''';
    final event = decoder.decode(
      const SseFrame(id: '42', event: 'price', data: json),
    );
    expect(event.eventId, '42');
    expect(event.eventName, 'price');
    expect((event.data['data'] as Map)['price'], '123.4500');
  });

  test('unknown variant 与 malformed JSON 映射 compatibility failure', () {
    expect(
      () => decoder.decode(const SseFrame(data: '{"event":"future"}')),
      throwsA(isA<CompatibilityFailure>()),
    );
    expect(
      () => decoder.decode(const SseFrame(data: '{broken')),
      throwsA(isA<CompatibilityFailure>()),
    );
  });
}
