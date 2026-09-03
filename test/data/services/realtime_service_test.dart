import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/reconnect_policy.dart';
import 'package:rwa_interface/data/services/dio_realtime_service.dart';

void main() {
  test('重连携带 Last-Event-ID、去重并在 resync 停止', () async {
    final adapter = _SseAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    final service = DioRealtimeService(
      dio,
      reconnectPolicy: const ReconnectPolicy(
        maxAttempts: 2,
        baseDelay: Duration.zero,
      ),
      delay: (_) async {},
    );
    final events = await service.subscribe(channels: {'orders'}).toList();
    expect(events.map((event) => event.eventId), ['1', '2']);
    expect(adapter.lastEventIds, [null, '1']);
    expect(adapter.calls, 2);
  });

  test('backoff 有界', () {
    const policy = ReconnectPolicy(
      baseDelay: Duration(seconds: 1),
      maxDelay: Duration(seconds: 3),
    );
    expect(policy.delayFor(0), const Duration(seconds: 1));
    expect(policy.delayFor(10), const Duration(seconds: 3));
  });

  test('调用方取消会取消 Dio 长连接且不重连', () async {
    final adapter = _CancelableAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    final service = DioRealtimeService(dio, delay: (_) async {});
    final first = await service.subscribe(channels: {'prices'}).first;
    expect(first.eventId, '1');
    await Future<void>.delayed(Duration.zero);
    expect(adapter.cancelled, isTrue);
    expect(adapter.calls, 1);
  });
}

final class _SseAdapter implements HttpClientAdapter {
  var calls = 0;
  final lastEventIds = <String?>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastEventIds.add(options.headers['Last-Event-ID'] as String?);
    calls++;
    final frames = calls == 1
        ? [_priceFrame('1')]
        : [_priceFrame('1'), _resyncFrame('2')];
    return ResponseBody(
      Stream.value(Uint8List.fromList(utf8.encode(frames.join()))),
      200,
      headers: {
        Headers.contentTypeHeader: ['text/event-stream'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

String _priceFrame(String id) =>
    'id: $id\nevent: price\ndata: {"event_id":"$id","emitted_at":"2026-09-03T00:00:00Z","event":"price","data":{"symbol":"NVDA","kind":"bstock","price":"1.0","change_24h_percent":"0.0","updated_at":"2026-09-03T00:00:00Z"}}\n\n';

String _resyncFrame(String id) =>
    'id: $id\nevent: resync_required\ndata: {"event_id":"$id","emitted_at":"2026-09-03T00:00:00Z","event":"resync_required","data":{"reason":"event_retention_expired"}}\n\n';

final class _CancelableAdapter implements HttpClientAdapter {
  var calls = 0;
  var cancelled = false;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls++;
    cancelFuture?.then((_) => cancelled = true);
    return ResponseBody(
      Stream.value(Uint8List.fromList(utf8.encode(_priceFrame('1')))),
      200,
      headers: {
        Headers.contentTypeHeader: ['text/event-stream'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
