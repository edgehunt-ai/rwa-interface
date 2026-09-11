import '../../domain/models/realtime_envelope.dart';
import '../../domain/models/realtime_replay_page.dart';

abstract interface class RealtimeService {
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels});
}

abstract interface class RealtimeRecoveryService {
  Future<RealtimeReplayPage> replay({
    required Set<String> channels,
    String? cursor,
    int limit = 50,
  });

  Stream<RealtimeEnvelope> subscribeWithRecovery({
    required Set<String> channels,
    required Future<void> Function() refreshSnapshot,
  });
}
