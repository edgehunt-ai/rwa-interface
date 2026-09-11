import '../../domain/repositories/realtime_repository.dart';
import '../../domain/models/realtime_envelope.dart';
import '../../domain/models/realtime_replay_page.dart';
import '../services/realtime_service.dart';

final class RealtimeRepositoryImpl implements RealtimeRepository {
  RealtimeRepositoryImpl(this._service);
  final RealtimeService _service;
  @override
  Stream<TypedRealtimeEvent> subscribe({required Set<String> channels}) =>
      _map(_service.subscribe(channels: channels));

  @override
  Future<RealtimeReplayPage> replay({
    required Set<String> channels,
    String? cursor,
    int limit = 50,
  }) {
    if (_service is! RealtimeRecoveryService) {
      throw UnsupportedError('Realtime replay is not configured');
    }
    final recovery = _service as RealtimeRecoveryService;
    return recovery.replay(channels: channels, cursor: cursor, limit: limit);
  }

  @override
  Stream<TypedRealtimeEvent> subscribeWithRecovery({
    required Set<String> channels,
    required Future<void> Function() refreshSnapshot,
  }) {
    if (_service is! RealtimeRecoveryService) {
      throw UnsupportedError('Realtime recovery is not configured');
    }
    final recovery = _service as RealtimeRecoveryService;
    return _map(
      recovery.subscribeWithRecovery(
        channels: channels,
        refreshSnapshot: refreshSnapshot,
      ),
    );
  }

  Stream<TypedRealtimeEvent> _map(Stream<RealtimeEnvelope> events) =>
      events.map(
        (event) => TypedRealtimeEvent(
          id: event.eventId,
          kind: event.eventName,
          entityId:
              event.data['entity_id']?.toString() ??
              event.data['order_id']?.toString() ??
              event.data['position_id']?.toString(),
          sequence: int.tryParse(event.data['sequence']?.toString() ?? ''),
          payload: event.data,
        ),
      );
}
