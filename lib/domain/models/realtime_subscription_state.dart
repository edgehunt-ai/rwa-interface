enum RealtimeConnectionStatus {
  idle,
  connecting,
  connected,
  reconnecting,
  resyncRequired,
  failed,
  cancelled,
}

final class RealtimeSubscriptionState {
  const RealtimeSubscriptionState({
    required this.status,
    this.lastEventId,
    this.attempt = 0,
  });
  final RealtimeConnectionStatus status;
  final String? lastEventId;
  final int attempt;
}
