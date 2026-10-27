import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../../domain/models/realtime_envelope.dart';
import '../../domain/models/realtime_replay_page.dart';
import '../api/api_failure_mapper.dart';
import '../api/realtime_event_decoder.dart';
import '../api/reconnect_policy.dart';
import '../api/sse_parser.dart';
import 'realtime_service.dart';

final class DioRealtimeService
    implements RealtimeService, RealtimeRecoveryService {
  DioRealtimeService(
    this._dio, {
    this.systemApi,
    this._parser = const SseParser(),
    this._decoder = const RealtimeEventDecoder(),
    ReconnectPolicy reconnectPolicy = const ReconnectPolicy(),
    Future<void> Function(Duration)? delay,
    this.maxDeliveredEventIds = 512,
  }) : assert(maxDeliveredEventIds > 0),
       _policy = reconnectPolicy,
       _delay = delay ?? Future<void>.delayed;

  final Dio _dio;
  final api.SystemApi? systemApi;
  final SseParser _parser;
  final RealtimeEventDecoder _decoder;
  final ReconnectPolicy _policy;
  final Future<void> Function(Duration) _delay;
  final int maxDeliveredEventIds;

  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) =>
      _withCancellation(
        (cancelToken) =>
            _subscribe(channels: channels, cancelToken: cancelToken),
      );

  /// Unlike async*'s onCancel, this callback runs while a request is pending.
  /// Abort the transport before awaiting the generator's cancellation so late
  /// failures cannot escape through StreamSubscription.cancel().
  Stream<RealtimeEnvelope> _withCancellation(
    Stream<RealtimeEnvelope> Function(CancelToken) create,
  ) {
    final cancelToken = CancelToken();
    StreamSubscription<RealtimeEnvelope>? subscription;
    late final StreamController<RealtimeEnvelope> controller;
    controller = StreamController<RealtimeEnvelope>(
      onListen: () {
        subscription = create(cancelToken).listen(
          controller.add,
          onError: controller.addError,
          onDone: controller.close,
        );
      },
      onCancel: () {
        cancelToken.cancel('SSE subscription closed');
        return subscription?.cancel();
      },
      onPause: () => subscription?.pause(),
      onResume: () => subscription?.resume(),
    );
    return controller.stream;
  }

  Stream<RealtimeEnvelope> _subscribe({
    required Set<String> channels,
    required CancelToken cancelToken,
    String? initialCursor,
  }) async* {
    final canonicalChannels = _canonicalizeChannels(channels);
    String? lastEventId = initialCursor;
    final deliveredEventIds = _RecentEventIds(maxDeliveredEventIds);
    for (var attempt = 0; attempt <= _policy.maxAttempts; attempt++) {
      if (cancelToken.isCancelled) return;
      final attemptToken = CancelToken();
      final cancellation = cancelToken.whenCancel.asStream().listen((_) {
        if (!attemptToken.isCancelled) {
          attemptToken.cancel('SSE subscription closed');
        }
      });
      try {
        final response = await _dio.get<ResponseBody>(
          '/v1/events',
          queryParameters: {'channels': canonicalChannels},
          options: Options(
            responseType: ResponseType.stream,
            receiveTimeout: Duration.zero,
            headers: {
              'Accept': 'text/event-stream',
              'Last-Event-ID': ?lastEventId,
            },
          ),
          cancelToken: attemptToken,
        );
        final body = response.data;
        if (body == null) throw const DecodingFailure();
        await for (final frame in _parser.bind(body.stream)) {
          final event = _decoder.decode(frame);
          lastEventId = event.eventId;
          if (!deliveredEventIds.add(event.eventId)) {
            continue;
          }
          yield event;
          if (event.eventName == 'resync_required') return;
        }
        if (attempt == _policy.maxAttempts) return;
      } on DioException catch (error, stackTrace) {
        if (cancelToken.isCancelled || CancelToken.isCancel(error)) return;
        if (attempt == _policy.maxAttempts) {
          yield* Stream<RealtimeEnvelope>.error(
            await _mapStreamFailure(error),
            stackTrace,
          );
          return;
        }
      } on ApiFailure catch (error, stackTrace) {
        if (cancelToken.isCancelled) return;
        yield* Stream<RealtimeEnvelope>.error(error, stackTrace);
        return;
      } on Object catch (error, stackTrace) {
        if (cancelToken.isCancelled) return;
        // Once Dio has returned a streaming response, socket failures surface
        // from ResponseBody.stream instead of as DioException instances.
        if (attempt == _policy.maxAttempts) {
          yield* Stream<RealtimeEnvelope>.error(
            NetworkFailure(userAction: error.toString()),
            stackTrace,
          );
          return;
        }
      } finally {
        // Dispose this response before backoff/retry, including unfinished HTTP
        // error bodies. Detach the parent listener so completed attempts are
        // not retained for the lifetime of a successful SSE connection.
        if (!attemptToken.isCancelled) {
          attemptToken.cancel('SSE attempt closed');
        }
        await cancellation.cancel();
      }
      await _waitToReconnect(attempt, cancelToken);
    }
  }

  Future<void> _waitToReconnect(int attempt, CancelToken cancelToken) =>
      Future.any([
        _delay(_policy.delayFor(attempt)),
        cancelToken.whenCancel.then<void>((_) {}),
      ]);

  Future<ApiFailure> _mapStreamFailure(DioException error) async {
    final response = error.response;
    final body = response?.data;
    if (response == null || body is! ResponseBody) {
      return const ApiFailureMapper().fromDio(error);
    }

    // ResponseType.stream also leaves unsuccessful HTTP bodies as streams.
    // Decode only a bounded error envelope; never surface a raw response body.
    Object? data;
    try {
      final bytes = await body.stream
          .timeout(const Duration(seconds: 5))
          .expand((chunk) => chunk)
          .take(64 * 1024)
          .toList();
      data = jsonDecode(utf8.decode(bytes));
    } on Object {
      // Retain HTTP status and request ID if the error envelope is unreadable.
    }
    return const ApiFailureMapper().fromDio(
      error.copyWith(
        response: Response<Object?>(
          requestOptions: response.requestOptions,
          statusCode: response.statusCode,
          headers: response.headers,
          data: data,
        ),
      ),
    );
  }

  @override
  Future<RealtimeReplayPage> replay({
    required Set<String> channels,
    String? cursor,
    int limit = 50,
  }) => _replay(channels: channels, cursor: cursor, limit: limit);

  Future<RealtimeReplayPage> _replay({
    required Set<String> channels,
    String? cursor,
    int limit = 50,
    CancelToken? cancelToken,
  }) async {
    final apiClient = systemApi;
    if (apiClient == null) {
      throw UnsupportedError('Realtime replay is not configured');
    }
    final canonicalChannels = _canonicalizeChannels(channels);
    try {
      final response = await apiClient.replayEvents(
        channels: canonicalChannels,
        cursor: cursor,
        limit: limit,
        cancelToken: cancelToken,
      );
      final page = response.data;
      if (page == null) throw const DecodingFailure();
      return RealtimeReplayPage(
        items: List.unmodifiable(page.items.map(_decodeReplayEvent)),
        nextCursor: page.nextCursor,
        hasMore: page.hasMore,
        resyncRequired: page.resyncRequired,
      );
    } on DioException catch (error) {
      throw const ApiFailureMapper().fromDio(error);
    }
  }

  @override
  Stream<RealtimeEnvelope> subscribeWithRecovery({
    required Set<String> channels,
    required Future<void> Function() refreshSnapshot,
  }) => _withCancellation(
    (cancelToken) => _subscribeWithRecovery(
      channels: channels,
      refreshSnapshot: refreshSnapshot,
      cancelToken: cancelToken,
    ),
  );

  Stream<RealtimeEnvelope> _subscribeWithRecovery({
    required Set<String> channels,
    required Future<void> Function() refreshSnapshot,
    required CancelToken cancelToken,
  }) async* {
    try {
      var cursor = '';
      while (!cancelToken.isCancelled) {
        var resync = false;
        await for (final event in _subscribe(
          channels: channels,
          cancelToken: cancelToken,
          initialCursor: cursor.isEmpty ? null : cursor,
        )) {
          yield event;
          if (event.eventName == 'resync_required') {
            cursor = event.eventId;
            resync = true;
            break;
          }
        }
        if (!resync) return;

        await refreshSnapshot();
        if (cancelToken.isCancelled) return;
        do {
          final page = await _replay(
            channels: channels,
            cursor: cursor,
            cancelToken: cancelToken,
          );
          if (cancelToken.isCancelled) return;
          if (page.resyncRequired) {
            await refreshSnapshot();
          }
          for (final event in page.items) {
            yield event;
          }
          cursor = page.nextCursor;
          if (!page.hasMore && !page.resyncRequired) break;
        } while (true);
      }
    } on Object catch (error, stackTrace) {
      if (cancelToken.isCancelled) return;
      yield* Stream<RealtimeEnvelope>.error(error, stackTrace);
    }
  }

  RealtimeEnvelope _decodeReplayEvent(api.RealtimeEvent event) {
    final json = api.standardSerializers.serializeWith(
      api.RealtimeEvent.serializer,
      event,
    );
    if (json is! Iterable) throw const DecodingFailure();
    final values = json.toList(growable: false);
    if (values.length.isOdd) throw const DecodingFailure();
    final map = <String, Object?>{
      for (var index = 0; index < values.length; index += 2)
        if (values[index] is String) values[index] as String: values[index + 1],
    };
    final eventId = map['event_id']?.toString();
    final eventName = map['event']?.toString();
    if (eventId == null || eventName == null) throw const DecodingFailure();
    return RealtimeEnvelope(
      eventId: eventId,
      eventName: eventName,
      data: Map.unmodifiable(map),
    );
  }

  String _canonicalizeChannels(Iterable<String> channels) {
    final values = channels
        .map((channel) => channel.trim().toLowerCase())
        .toSet();
    if (values.any((channel) => channel.isEmpty)) {
      throw ArgumentError.value(
        channels,
        'channels',
        'must not contain empty values',
      );
    }
    if (values.isEmpty) {
      throw ArgumentError.value(channels, 'channels', 'must not be empty');
    }
    final sorted = values.toList()..sort();
    return sorted.join(',');
  }
}

final class _RecentEventIds {
  _RecentEventIds(this.capacity) : assert(capacity > 0);

  final int capacity;
  final Queue<String> _insertionOrder = Queue<String>();
  final Set<String> _ids = <String>{};

  bool add(String id) {
    if (!_ids.add(id)) return false;
    _insertionOrder.addLast(id);
    if (_insertionOrder.length > capacity) {
      _ids.remove(_insertionOrder.removeFirst());
    }
    return true;
  }
}
