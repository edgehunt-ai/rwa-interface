import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/api/reconnect_policy.dart';
import 'package:nobell/data/services/dio_realtime_service.dart';
import 'package:nobell/domain/models/api_failure.dart';

void main() {
  for (final recovery in [false, true]) {
    test('closes unfinished HTTP error responses before retrying '
        '(recovery: $recovery)', () async {
      final adapter = _OpenResponseAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter;
      final service = DioRealtimeService(
        dio,
        reconnectPolicy: const ReconnectPolicy(maxAttempts: 2),
        delay: (_) async {},
      );
      final received = Completer<void>();
      final stream = recovery
          ? service.subscribeWithRecovery(
              channels: {'prices'},
              refreshSnapshot: () async {},
            )
          : service.subscribe(channels: {'prices'});
      final subscription = stream.listen(
        (_) => received.complete(),
        onError: received.completeError,
      );
      addTearDown(() async {
        await subscription.cancel();
        await adapter.closeResponses();
        dio.close(force: true);
      });

      await received.future;

      // The successful SSE connection stays open. Both incomplete 503 bodies
      // must already be disposed before the next connection is attempted.
      expect(adapter.cancelledBeforeRequest, [
        <int>[],
        [1],
        [1, 2],
      ]);
      expect(adapter.cancelledResponses, [1, 2]);
      expect(adapter.closedResponses, [1, 2]);

      await subscription.cancel();
      expect(adapter.cancelledResponses, [1, 2, 3]);
      expect(adapter.closedResponses, [1, 2, 3]);
    });
  }

  for (final maxAttempts in [0, 2]) {
    for (final recovery in [false, true]) {
      test('cancelling a pending subscription contains a late HTTP failure '
          '(attempts: $maxAttempts, recovery: $recovery)', () async {
        final adapter = _PendingFailureAdapter();
        final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
          ..httpClientAdapter = adapter;
        final service = DioRealtimeService(
          dio,
          reconnectPolicy: ReconnectPolicy(maxAttempts: maxAttempts),
          delay: (_) async {},
        );
        final errors = <Object>[];
        final stream = recovery
            ? service.subscribeWithRecovery(
                channels: {'balances'},
                refreshSnapshot: () async {},
              )
            : service.subscribe(channels: {'balances'});
        final subscription = stream.listen(
          (_) {},
          onError: (Object error) => errors.add(error),
        );
        await adapter.started.future;

        final cancellation = subscription.cancel();
        await expectLater(
          cancellation.timeout(const Duration(seconds: 1)),
          completes,
        );
        adapter.response.complete(
          ResponseBody.fromString(
            '{"code":"postgres","message":"Database unavailable"}',
            503,
            headers: {
              Headers.contentTypeHeader: ['application/json'],
              'x-request-id': ['sse-late-failure'],
            },
          ),
        );

        await expectLater(cancellation, completes);
        await pumpEventQueue();
        expect(errors, isEmpty);
        expect(adapter.calls, 1);
      });
    }
  }

  test('cancelling during backoff stops without another request', () async {
    final adapter = _PendingFailureAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    final backoffStarted = Completer<void>();
    final backoff = Completer<void>();
    final service = DioRealtimeService(
      dio,
      delay: (_) {
        backoffStarted.complete();
        return backoff.future;
      },
    );
    final subscription = service
        .subscribe(channels: {'balances'})
        .listen(
          (_) {},
          onError: (Object error) => fail('Unexpected error: $error'),
        );
    await adapter.started.future;
    adapter.response.complete(ResponseBody.fromString('', 503));
    await backoffStarted.future;

    await expectLater(
      subscription.cancel().timeout(const Duration(seconds: 1)),
      completes,
    );
    backoff.complete();
    await pumpEventQueue();
    expect(adapter.calls, 1);
  });

  for (final recovery in [false, true]) {
    test('SSE HTTP failures retain the API reason and request ID '
        '(recovery: $recovery)', () async {
      final adapter = _HttpFailureAdapter(
        '{"code":"postgres","message":"Database unavailable",'
        '"retryable":true,"request_id":"sse-body-request"}',
      );
      final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
        ..httpClientAdapter = adapter;
      final service = DioRealtimeService(
        dio,
        reconnectPolicy: const ReconnectPolicy(maxAttempts: 0),
      );

      await expectLater(
        (recovery
                ? service.subscribeWithRecovery(
                    channels: {'balances'},
                    refreshSnapshot: () async {},
                  )
                : service.subscribe(channels: {'balances'}))
            .toList(),
        throwsA(
          isA<ServerFailure>()
              .having((f) => f.code, 'code', 'postgres')
              .having((f) => f.requestId, 'request ID', 'sse-body-request')
              .having((f) => f.retryable, 'retryable', isTrue)
              .having(
                (f) => apiFailureMessage(f, fallback: 'fallback'),
                'visible reason',
                'Database unavailable',
              ),
        ),
      );
    });
  }

  test('recovery refreshes, replays and resumes with the server cursor', () async {
    final adapter = _RecoveryAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    // Focused data-boundary test: use the generated client with an in-memory
    // transport to exercise the real replay contract without application APIs.
    final service = DioRealtimeService(
      dio,
      systemApi: api.SystemApi(dio, api.standardSerializers),
      reconnectPolicy: const ReconnectPolicy(maxAttempts: 0),
    );
    var refreshes = 0;
    final events = await service
        .subscribeWithRecovery(
          channels: {'prices'},
          refreshSnapshot: () async {
            refreshes++;
          },
        )
        .toList();

    expect(refreshes, 1);
    expect(adapter.replayCursor, '2');
    expect(adapter.lastEventIds, [null, 'replay-cursor']);
    expect(events.map((e) => e.eventId), ['2', '3']);
  });

  test('cancellation aborts a pending replay request', () async {
    final response = Completer<ResponseBody>();
    final adapter = _RecoveryAdapter(replayResponse: response);
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    final service = DioRealtimeService(
      dio,
      systemApi: api.SystemApi(dio, api.standardSerializers),
      reconnectPolicy: const ReconnectPolicy(maxAttempts: 0),
    );
    final subscription = service
        .subscribeWithRecovery(
          channels: {'prices'},
          refreshSnapshot: () async {},
        )
        .listen(
          (_) {},
          onError: (Object error) => fail('Unexpected error: $error'),
        );
    await adapter.replayStarted.future;

    await expectLater(
      subscription.cancel().timeout(const Duration(seconds: 1)),
      completes,
    );
    response.complete(ResponseBody.fromString('', 503));
    await pumpEventQueue();
    expect(adapter.lastEventIds, [null]);
  });

  test('cancellation contains a late snapshot recovery failure', () async {
    final adapter = _RecoveryAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    final service = DioRealtimeService(
      dio,
      reconnectPolicy: const ReconnectPolicy(maxAttempts: 0),
    );
    final started = Completer<void>();
    final snapshot = Completer<void>();
    final subscription = service
        .subscribeWithRecovery(
          channels: {'prices'},
          refreshSnapshot: () {
            started.complete();
            return snapshot.future;
          },
        )
        .listen(
          (_) {},
          onError: (Object error) => fail('Unexpected error: $error'),
        );
    await started.future;
    final cancellation = subscription.cancel();
    snapshot.completeError(
      const ServerFailure(
        statusCode: 503,
        code: 'postgres',
        message: 'Database unavailable',
      ),
    );

    await expectLater(cancellation, completes);
    expect(adapter.lastEventIds, [null]);
    expect(adapter.replayCursor, isNull);
  });

  test('SSE malformed error bodies retain the HTTP status', () async {
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = _HttpFailureAdapter('<html>Unavailable</html>');
    final service = DioRealtimeService(
      dio,
      reconnectPolicy: const ReconnectPolicy(maxAttempts: 0),
    );

    await expectLater(
      service.subscribe(channels: {'balances'}).toList(),
      throwsA(
        isA<ServerFailure>().having(
          (f) => apiFailureMessage(f, fallback: 'fallback'),
          'visible reason',
          'HTTP 503 http_503',
        ),
      ),
    );
  });

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

  test('频道按 contract canonical tuple 发送', () async {
    final adapter = _SseAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    await DioRealtimeService(
      dio,
      delay: (_) async {},
    ).subscribe(channels: {' Positions ', 'orders'}).first;
    expect(adapter.channels, ['orders,positions']);
  });

  test('响应流连接异常会重连并恢复订阅', () async {
    final adapter = _StreamFailureAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    final service = DioRealtimeService(
      dio,
      reconnectPolicy: const ReconnectPolicy(
        maxAttempts: 1,
        baseDelay: Duration.zero,
      ),
      delay: (_) async {},
    );

    final events = await service.subscribe(channels: {'balances'}).toList();

    expect(events.map((event) => event.eventId), ['2']);
    expect(adapter.calls, 2);
  });

  test('响应流持续失败会转换为 NetworkFailure', () async {
    final adapter = _StreamFailureAdapter(alwaysFail: true);
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    final service = DioRealtimeService(
      dio,
      reconnectPolicy: const ReconnectPolicy(
        maxAttempts: 1,
        baseDelay: Duration.zero,
      ),
      delay: (_) async {},
    );

    await expectLater(
      service.subscribe(channels: {'balances'}).toList(),
      throwsA(isA<NetworkFailure>()),
    );
    expect(adapter.calls, 2);
  });

  test('事件去重窗口有界并在淘汰最旧 ID 后允许再次投递', () async {
    final adapter = _BoundedDedupAdapter();
    final dio = Dio(BaseOptions(baseUrl: 'https://fixture.example'))
      ..httpClientAdapter = adapter;
    final service = DioRealtimeService(
      dio,
      maxDeliveredEventIds: 2,
      reconnectPolicy: const ReconnectPolicy(
        maxAttempts: 2,
        baseDelay: Duration.zero,
      ),
      delay: (_) async {},
    );

    final events = await service.subscribe(channels: {'prices'}).toList();

    expect(events.map((event) => event.eventId), ['1', '2', '3', '1', '4']);
    expect(adapter.calls, 3);
  });
}

final class _OpenResponseAdapter implements HttpClientAdapter {
  final _responses = <StreamController<Uint8List>>[];
  final cancelledResponses = <int>[];
  final closedResponses = <int>[];
  final cancelledBeforeRequest = <List<int>>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final attempt = _responses.length + 1;
    cancelledBeforeRequest.add([...cancelledResponses]);
    final source = StreamController<Uint8List>(
      onCancel: () => cancelledResponses.add(attempt),
    );
    _responses.add(source);
    final failing = attempt <= 2;
    // No EOF: model a chunked HTTP error followed by a long-lived SSE stream.
    source.add(
      Uint8List.fromList(
        utf8.encode(failing ? '{"code":"postgres",' : _priceFrame('3')),
      ),
    );
    return ResponseBody(
      source.stream,
      failing ? 503 : 200,
      headers: {
        Headers.contentTypeHeader: [
          failing ? 'application/json' : 'text/event-stream',
        ],
      },
      onClose: () => closedResponses.add(attempt),
    );
  }

  Future<void> closeResponses() async {
    for (final response in _responses) {
      await response.close();
    }
  }

  @override
  void close({bool force = false}) {}
}

final class _PendingFailureAdapter implements HttpClientAdapter {
  final started = Completer<void>();
  final response = Completer<ResponseBody>();
  var calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    calls++;
    started.complete();
    return response.future;
  }

  @override
  void close({bool force = false}) {}
}

final class _HttpFailureAdapter implements HttpClientAdapter {
  _HttpFailureAdapter(this.body);
  final String body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString(
    body,
    503,
    headers: {
      Headers.contentTypeHeader: ['application/json'],
    },
  );

  @override
  void close({bool force = false}) {}
}

final class _RecoveryAdapter implements HttpClientAdapter {
  _RecoveryAdapter({this.replayResponse});

  final Completer<ResponseBody>? replayResponse;
  final replayStarted = Completer<void>();
  final lastEventIds = <String?>[];
  String? replayCursor;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    if (options.path == '/v1/events/replay') {
      replayCursor = options.queryParameters['cursor'] as String?;
      replayStarted.complete();
      if (replayResponse case final response?) return response.future;
      return ResponseBody.fromString(
        '{"items":[],"next_cursor":"replay-cursor",'
        '"has_more":false,"resync_required":false}',
        200,
        headers: {
          Headers.contentTypeHeader: ['application/json'],
        },
      );
    }
    lastEventIds.add(options.headers['Last-Event-ID'] as String?);
    return ResponseBody.fromString(
      lastEventIds.length == 1 ? _resyncFrame('2') : _priceFrame('3'),
      200,
      headers: {
        Headers.contentTypeHeader: ['text/event-stream'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final class _SseAdapter implements HttpClientAdapter {
  var calls = 0;
  final lastEventIds = <String?>[];
  final channels = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastEventIds.add(options.headers['Last-Event-ID'] as String?);
    channels.add(options.uri.queryParameters['channels']!);
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

final class _StreamFailureAdapter implements HttpClientAdapter {
  _StreamFailureAdapter({this.alwaysFail = false});

  final bool alwaysFail;
  var calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls++;
    final stream = alwaysFail || calls == 1
        ? Stream<Uint8List>.error(
            StateError('Connection closed while receiving data'),
          )
        : Stream.value(Uint8List.fromList(utf8.encode(_priceFrame('2'))));
    return ResponseBody(
      stream,
      200,
      headers: {
        Headers.contentTypeHeader: ['text/event-stream'],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final class _BoundedDedupAdapter implements HttpClientAdapter {
  var calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls++;
    final frames = switch (calls) {
      1 => [_priceFrame('1'), _priceFrame('2')],
      2 => [_priceFrame('2'), _priceFrame('3')],
      _ => [_priceFrame('1'), _resyncFrame('4')],
    };
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
