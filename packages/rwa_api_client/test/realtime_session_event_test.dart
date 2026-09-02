import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

// tests for RealtimeSessionEvent
void main() {
  final instance = RealtimeSessionEventBuilder();
  // TODO add properties to the builder and call build()

  group(RealtimeSessionEvent, () {
    // 同时作为 SSE `id:` 字段发送的单调递增事件标识，用于断线续传和去重
    // String eventId
    test('to test the property `eventId`', () async {
      // TODO
    });

    // DateTime emittedAt
    test('to test the property `emittedAt`', () async {
      // TODO
    });

    // String event
    test('to test the property `event`', () async {
      // TODO
    });

    // MarketSessionInfo data
    test('to test the property `data`', () async {
      // TODO
    });

  });
}
