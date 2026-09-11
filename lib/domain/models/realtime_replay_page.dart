import 'realtime_envelope.dart';

final class RealtimeReplayPage {
  const RealtimeReplayPage({
    required this.items,
    required this.nextCursor,
    required this.hasMore,
    required this.resyncRequired,
  });

  final List<RealtimeEnvelope> items;
  final String nextCursor;
  final bool hasMore;
  final bool resyncRequired;
}
