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
}
