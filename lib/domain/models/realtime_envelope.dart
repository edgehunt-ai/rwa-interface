final class RealtimeEnvelope {
  const RealtimeEnvelope({
    required this.eventId,
    required this.eventName,
    required this.data,
  });
  final String eventId;
  final String eventName;
  final Map<String, Object?> data;
}
