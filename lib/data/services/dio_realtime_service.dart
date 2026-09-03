import 'package:dio/dio.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/realtime_envelope.dart';
import '../api/api_failure_mapper.dart';
import '../api/realtime_event_decoder.dart';
import '../api/reconnect_policy.dart';
import '../api/sse_parser.dart';
import 'realtime_service.dart';

final class DioRealtimeService implements RealtimeService {
  DioRealtimeService(
    this._dio, {
    this._parser = const SseParser(),
    this._decoder = const RealtimeEventDecoder(),
    ReconnectPolicy reconnectPolicy = const ReconnectPolicy(),
    Future<void> Function(Duration)? delay,
  }) : _policy = reconnectPolicy,
       _delay = delay ?? Future<void>.delayed;

  final Dio _dio;
  final SseParser _parser;
  final RealtimeEventDecoder _decoder;
  final ReconnectPolicy _policy;
  final Future<void> Function(Duration) _delay;

  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) async* {
    String? lastEventId;
    final deliveredEventIds = <String>{};
    for (var attempt = 0; attempt <= _policy.maxAttempts; attempt++) {
      final cancelToken = CancelToken();
      try {
        final response = await _dio.get<ResponseBody>(
          '/v1/events',
          queryParameters: {'channels': channels.join(',')},
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
}
