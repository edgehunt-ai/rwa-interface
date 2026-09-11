final class RealtimeEnvelope {
  const RealtimeEnvelope({
    required this.eventId,
    required this.eventName,
    required this.data,
  });
  final String eventId;
  final String eventName;
  final Map<String, Object?> data;

  Map<String, Object?> get resourceData {
    final nested = data['data'];
    return nested is Map<String, Object?> ? nested : data;
  }

  String? get entityId {
    final body = resourceData;
    final value = switch (eventName) {
      'hip3_order' => body['order_id'],
      'hip3_position' => body['position_id'],
      'hip3_price' || 'hip3_candle' => body['product_id'],
      'hip3_balance' => body['scope'],
      'hip3_snapshot' || 'resync_required' => null,
      _ => body['entity_id'] ?? body['order_id'] ?? body['position_id'],
    };
    return value is String ? value : null;
  }
}
