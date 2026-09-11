import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/reconnect_policy.dart';
import 'package:rwa_interface/data/services/dio_realtime_service.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';

void main() {
  test('cancellation removes the production backoff timer', () async {
    final waiting = Completer<void>();
    Timer? backoff;
    final adapter = _ScriptedAdapter([[]]);
    final service = DioRealtimeService(
      Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter,
      reconnectPolicy: const ReconnectPolicy(
        baseDelay: Duration(hours: 1),
        maxDelay: Duration(hours: 1),
      ),
    );
    await runZoned(
      () async {
        final subscription = service
            .subscribe(channels: {'hip3:orders'})
            .listen((_) {});
        await waiting.future.timeout(const Duration(seconds: 2));
        try {
          expect(backoff!.isActive, isTrue);
          await subscription.cancel().timeout(const Duration(seconds: 1));
          expect(backoff!.isActive, isFalse);
          expect(adapter.lastEventIds, hasLength(1));
        } finally {
          backoff?.cancel();
        }
      },
      zoneSpecification: ZoneSpecification(
        createTimer: (self, parent, zone, duration, callback) {
          final timer = parent.createTimer(zone, duration, callback);
          if (duration == const Duration(hours: 1)) {
            backoff = timer;
            waiting.complete();
          }
          return timer;
        },
      ),
    );
  });

  test('cancellation interrupts a pending reconnect delay', () async {
    final waiting = Completer<void>();
    final release = Completer<void>();
    final adapter = _ScriptedAdapter([[]]);
    final service = DioRealtimeService(
      Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter,
      delay: (_) {
        if (!waiting.isCompleted) waiting.complete();
        return release.future;
      },
    );
    final subscription = service
        .subscribe(channels: {'hip3:orders'})
        .listen((_) {});
    await waiting.future;
    try {
      await subscription.cancel().timeout(const Duration(seconds: 1));
      expect(adapter.lastEventIds, hasLength(1));
    } finally {
      release.complete();
    }
  });

  test('cancellation aborts request before response headers arrive', () async {
    final adapter = _PendingAdapter();
    final service = DioRealtimeService(
      Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter,
    );
    final subscription = service
        .subscribe(channels: {'hip3:orders'})
        .listen((_) {});
    await adapter.started.future;
    try {
      await subscription.cancel().timeout(const Duration(seconds: 1));
      expect(adapter.cancelled, isTrue);
    } finally {
      adapter.release.complete(ResponseBody.fromString('', 200));
    }
  });

  for (final contentType in [null, 'text/html', 'application/json']) {
    test('rejects non-SSE success response: $contentType', () async {
      final adapter = _ScriptedAdapter([[]], contentType: contentType);
      final service = DioRealtimeService(
        Dio(BaseOptions(baseUrl: 'https://fixture.example'))
          ..httpClientAdapter = adapter,
        reconnectPolicy: const ReconnectPolicy(maxAttempts: 2),
        delay: (_) async {},
      );
      await expectLater(
        service.subscribe(channels: {'orders'}).toList(),
        throwsA(isA<DecodingFailure>()),
      );
      expect(adapter.lastEventIds, hasLength(1));
    });
  }

  test(
    '204 stops with an explicit unavailable failure, without retry',
    () async {
      final adapter = _ScriptedAdapter([[]], status: 204);
      final service = DioRealtimeService(
        Dio(BaseOptions(baseUrl: 'https://fixture.example'))
          ..httpClientAdapter = adapter,
        delay: (_) async {},
      );
      await expectLater(
        service.subscribe(channels: {'orders'}).toList(),
        throwsA(
          isA<ServerFailure>().having(
            (e) => e.code,
            'code',
            'realtime_disabled',
          ),
        ),
      );
      expect(adapter.lastEventIds, hasLength(1));
    },
  );

  test('new data restores retry budget after a recovered disconnect', () async {
    final adapter = _ScriptedAdapter([
      [],
      [_priceFrame('1')],
      [],
      [_resyncFrame('2')],
    ], contentType: 'Text/Event-Stream; charset=utf-8');
    final delays = <Duration>[];
    final service = DioRealtimeService(
      Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter,
      reconnectPolicy: const ReconnectPolicy(maxAttempts: 2),
      delay: (value) async {
        delays.add(value);
      },
    );
    final events = await service.subscribe(channels: {'orders'}).toList();
    expect(events.map((e) => e.eventId), ['1', '2']);
    expect(adapter.lastEventIds, [null, null, '1', '1']);
    expect(delays, [
      const Duration(milliseconds: 250),
      const Duration(milliseconds: 250),
      const Duration(milliseconds: 500),
    ]);
  });

  test(
    'duplicate-only reconnects exhaust budget and surface lost stream',
    () async {
      final adapter = _ScriptedAdapter([
        [_priceFrame('1')],
        [_priceFrame('1')],
        [_priceFrame('1')],
      ]);
      final service = DioRealtimeService(
        Dio(BaseOptions(baseUrl: 'https://fixture.example'))
          ..httpClientAdapter = adapter,
        reconnectPolicy: const ReconnectPolicy(maxAttempts: 2),
        delay: (_) async {},
      );
      await expectLater(
        service.subscribe(channels: {'orders'}).toList(),
        throwsA(isA<NetworkFailure>()),
      );
      expect(adapter.lastEventIds, [null, '1', '1']);
    },
  );

  test('reconnect freezes the subscription channel set', () async {
    final adapter = _ScriptedAdapter([
      [_priceFrame('1')],
      [_resyncFrame('2')],
    ]);
    final service = DioRealtimeService(
      Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter,
      reconnectPolicy: const ReconnectPolicy(maxAttempts: 1),
      delay: (_) async {},
    );
    final channels = {'orders'};
    await for (final event in service.subscribe(channels: channels)) {
      if (event.eventName == 'price') channels.add('positions');
    }
    expect(adapter.channels, ['orders', 'orders']);
  });
  test('resync is delivered even when its cursor was already seen', () async {
    final adapter = _ScriptedAdapter([
      [_priceFrame('1'), _resyncFrame('1')],
    ]);
    final service = DioRealtimeService(
      Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter,
      reconnectPolicy: const ReconnectPolicy(maxAttempts: 0),
    );
    final events = await service.subscribe(channels: {'orders'}).toList();
    expect(events.map((event) => event.eventName), [
      'price',
      'resync_required',
    ]);
  });

  test('duplicate replay never moves the reconnect cursor backwards', () async {
    final adapter = _ScriptedAdapter([
      [_priceFrame('1'), _priceFrame('2'), _priceFrame('1')],
      [_resyncFrame('3')],
    ]);
    final service = DioRealtimeService(
      Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter,
      reconnectPolicy: const ReconnectPolicy(maxAttempts: 1),
      delay: (_) async {},
    );
    await service.subscribe(channels: {'orders'}).toList();
    expect(adapter.lastEventIds, [null, '2']);
  });

  test(
    'authentication failure is surfaced without retrying the invalid session',
    () async {
      final adapter = _ScriptedAdapter([[]], status: 401);
      final service = DioRealtimeService(
        Dio(BaseOptions(baseUrl: 'https://fixture.example'))
          ..httpClientAdapter = adapter,
        reconnectPolicy: const ReconnectPolicy(maxAttempts: 2),
        delay: (_) async {},
      );
      await expectLater(
        service.subscribe(channels: {'orders'}).toList(),
        throwsA(isA<AuthenticationFailure>()),
      );
      expect(adapter.lastEventIds, hasLength(1));
    },
  );
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

final class _PendingAdapter implements HttpClientAdapter {
  final started = Completer<void>();
  final release = Completer<ResponseBody>();
  var cancelled = false;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    cancelFuture?.then((_) => cancelled = true);
    started.complete();
    return release.future;
  }

  @override
  void close({bool force = false}) {}
}

final class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(
    this.streams, {
    this.status = 200,
    this.contentType = 'text/event-stream',
  });
  final List<List<String>> streams;
  final int status;
  final String? contentType;
  final lastEventIds = <String?>[];
  final channels = <String>[];
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final index = lastEventIds.length;
    channels.add(options.queryParameters['channels'] as String);
    lastEventIds.add(options.headers['Last-Event-ID'] as String?);
    return ResponseBody(
      Stream.value(
        Uint8List.fromList(
          utf8.encode(streams[index.clamp(0, streams.length - 1)].join()),
        ),
      ),
      status,
      headers: {
        if (contentType != null) Headers.contentTypeHeader: [contentType!],
      },
    );
  }

  @override
  void close({bool force = false}) {}
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
