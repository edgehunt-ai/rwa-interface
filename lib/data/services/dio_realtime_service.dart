import 'dart:async';

import 'package:dio/dio.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/realtime_envelope.dart';
import '../api/api_failure_mapper.dart';
import '../api/realtime_event_decoder.dart';
import '../api/reconnect_policy.dart';
import '../api/realtime_replay_guard.dart';
import '../api/sse_parser.dart';
import 'realtime_service.dart';

final class DioRealtimeService implements RealtimeService {
  DioRealtimeService(
    this._dio, {
    this._parser = const SseParser(),
    this._decoder = const RealtimeEventDecoder(),
    ReconnectPolicy reconnectPolicy = const ReconnectPolicy(),
    this.delay,
  }) : _policy = reconnectPolicy;

  final Dio _dio;
  final SseParser _parser;
  final RealtimeEventDecoder _decoder;
  final ReconnectPolicy _policy;
  final Future<void> Function(Duration)? delay;

  Future<void> _wait(Duration duration, _SubscriptionLifetime lifetime) async {
    if (lifetime.cancelled) return;
    // A per-wait signal avoids retaining a listener for every past reconnect
    // on a single never-completed lifetime future.
    final stopped = Completer<void>();
    lifetime.waiting = stopped;
    Timer? timer;
    try {
      final injected = delay;
      final Future<void> elapsed;
      if (injected != null) {
        elapsed = injected(duration);
      } else {
        final completion = Completer<void>();
        timer = Timer(duration, completion.complete);
        elapsed = completion.future;
      }
      await Future.any<void>([elapsed, stopped.future]);
    } finally {
      lifetime.waiting = null;
      timer?.cancel();
    }
  }

  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) {
    final channelsKey = (channels.toList()..sort()).join(',');
    final lifetime = _SubscriptionLifetime();
    late final StreamController<RealtimeEnvelope> controller;
    StreamSubscription<RealtimeEnvelope>? subscription;
    controller = StreamController<RealtimeEnvelope>(
      onListen: () {
        subscription = _subscribe(channelsKey, lifetime).listen(
          controller.add,
          onError: controller.addError,
          onDone: controller.close,
        );
      },
      onPause: () => subscription?.pause(),
      onResume: () => subscription?.resume(),
      onCancel: () async {
        // async* cancellation alone cannot interrupt an awaited HTTP request
        // or backoff. Signal those waits before awaiting generator teardown.
        lifetime.cancel();
        await subscription?.cancel();
      },
    );
    return controller.stream;
  }

  Stream<RealtimeEnvelope> _subscribe(
    String channelsKey,
    _SubscriptionLifetime lifetime,
  ) async* {
    String? lastEventId;
    final replay = RealtimeReplayGuard();
    var attempt = 0;
    while (!lifetime.cancelled) {
      final cancelToken = CancelToken();
      lifetime.request = cancelToken;
      try {
        final response = await _dio.get<ResponseBody>(
          '/v1/events',
          queryParameters: {'channels': channelsKey},
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
        if (lifetime.cancelled) return;
        if (response.statusCode == 204) {
          throw const ServerFailure(statusCode: 503, code: 'realtime_disabled');
        }
        final mediaType = response.headers
            .value(Headers.contentTypeHeader)
            ?.split(';')
            .first
            .trim()
            .toLowerCase();
        if (response.statusCode != 200 || mediaType != 'text/event-stream') {
          throw const DecodingFailure();
        }
        final body = response.data;
        if (body == null) throw const DecodingFailure();
        await for (final frame in _parser.bind(body.stream)) {
          if (lifetime.cancelled) return;
          final event = _decoder.decode(frame);
          if (!replay.accept(event)) continue;
          yield event;
          if (event.eventName == 'resync_required') return;
          lastEventId = event.eventId;
          // New delivered data proves recovery. Replays and keepalives do not.
          attempt = 0;
        }
        if (attempt >= _policy.maxAttempts) throw const NetworkFailure();
      } on DioException catch (error) {
        if (CancelToken.isCancel(error)) return;
        final status = error.response?.statusCode;
        if (attempt >= _policy.maxAttempts ||
            status == 401 ||
            status == 403 ||
            status == 400 ||
            status == 422) {
          throw const ApiFailureMapper().fromDio(error);
        }
      } on FormatException {
        throw const DecodingFailure();
      } finally {
        lifetime.request = null;
        if (!cancelToken.isCancelled) {
          cancelToken.cancel('SSE subscription closed');
        }
      }
      if (lifetime.cancelled) return;
      await _wait(_policy.delayFor(attempt++), lifetime);
    }
  }
}

final class _SubscriptionLifetime {
  Completer<void>? waiting;
  CancelToken? request;
  bool cancelled = false;

  void cancel() {
    if (cancelled) return;
    cancelled = true;
    waiting?.complete();
    request?.cancel('SSE subscription cancelled');
  }
}
