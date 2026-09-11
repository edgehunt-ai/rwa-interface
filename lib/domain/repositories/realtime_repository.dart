import '../models/realtime_replay_page.dart';

final class TypedRealtimeEvent {
  const TypedRealtimeEvent({
    required this.id,
    required this.kind,
    required this.entityId,
    required this.sequence,
    required this.payload,
  });
  final String id;
  final String kind;
  final String? entityId;
  final int? sequence;
  final Map<String, Object?> payload;
}

abstract interface class RealtimeRepository {
  Stream<TypedRealtimeEvent> subscribe({required Set<String> channels});

  Future<RealtimeReplayPage> replay({
    required Set<String> channels,
    String? cursor,
    int limit = 50,
  }) => throw UnsupportedError('Realtime replay is not available');

  Stream<TypedRealtimeEvent> subscribeWithRecovery({
    required Set<String> channels,
    required Future<void> Function() refreshSnapshot,
  }) => throw UnsupportedError('Realtime recovery is not available');
}
