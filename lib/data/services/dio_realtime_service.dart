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
  }) : _policy = reconnectPolicy,
       _delay = delay ?? Future<void>.delayed;

  final Dio _dio;
  final api.SystemApi? systemApi;
  final SseParser _parser;
  final RealtimeEventDecoder _decoder;
  final ReconnectPolicy _policy;
  final Future<void> Function(Duration) _delay;

  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) async* {
    yield* _subscribe(channels: channels);
  }

  Stream<RealtimeEnvelope> _subscribe({
    required Set<String> channels,
    String? initialCursor,
  }) async* {
    final canonicalChannels = _canonicalizeChannels(channels);
    String? lastEventId = initialCursor;
    final deliveredEventIds = <String>{};
    for (var attempt = 0; attempt <= _policy.maxAttempts; attempt++) {
      final cancelToken = CancelToken();
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
          cancelToken: cancelToken,
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
        await _delay(_policy.delayFor(attempt));
      } on DioException catch (error) {
        if (CancelToken.isCancel(error)) return;
        if (attempt == _policy.maxAttempts) {
          throw const ApiFailureMapper().fromDio(error);
        }
        await _delay(_policy.delayFor(attempt));
      } finally {
        if (!cancelToken.isCancelled) {
          cancelToken.cancel('SSE subscription closed');
        }
      }
    }
  }

  @override
  Future<RealtimeReplayPage> replay({
    required Set<String> channels,
    String? cursor,
    int limit = 50,
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
  }) async* {
    var cursor = '';
    while (true) {
      var resync = false;
      await for (final event in _subscribe(
        channels: channels,
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
      do {
        final page = await replay(channels: channels, cursor: cursor);
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
