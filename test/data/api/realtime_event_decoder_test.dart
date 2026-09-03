import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/realtime_event_decoder.dart';
import 'package:rwa_interface/data/api/sse_frame.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

void main() {
  const decoder = RealtimeEventDecoder();

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
