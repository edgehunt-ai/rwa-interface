import '../../domain/models/realtime_envelope.dart';

abstract interface class RealtimeService {
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels});
}
