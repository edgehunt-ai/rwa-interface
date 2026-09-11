import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/repositories/realtime_repository_impl.dart';
import 'package:rwa_interface/data/services/realtime_service.dart';
import 'package:rwa_interface/domain/models/realtime_envelope.dart';

void main() {
  test(
    'HIP3 resource identity comes from nested typed data, not envelope aliases',
    () async {
      final fixtures = [
        ('hip3_order', {'order_id': 'order-hip3'}, 'order-hip3'),
        ('hip3_position', {'position_id': 'position-hip3'}, 'position-hip3'),
        ('hip3_price', {'product_id': 'frce:US30YFRM'}, 'frce:US30YFRM'),
        ('hip3_candle', {'product_id': 'xyz:TSLA'}, 'xyz:TSLA'),
        ('hip3_balance', {'scope': 'hyperliquid_wallet'}, 'hyperliquid_wallet'),
      ];
      for (final (kind, data, id) in fixtures) {
        final event = await RealtimeRepositoryImpl(_Nested(kind, data))
            .subscribe(channels: {'hip3:orders'})
            .single;
        expect(event.entityId, id);
        expect(
          event.sequence,
          isNull,
          reason: 'stream cursors are not per-entity versions',
        );
      }
    },
  );
  test('maps envelope to typed entity and sequence', () async {
    final event = await RealtimeRepositoryImpl(_Realtime())
        .subscribe(channels: {'orders'})
        .single;
    expect(event.entityId, 'order-1');
    expect(event.sequence, 7);
  });
}

final class _Nested implements RealtimeService {
  _Nested(this.kind, this.payload);
  final String kind;
  final Map<String, Object?> payload;
  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) =>
      Stream.value(
        RealtimeEnvelope(
          eventId: 'h3.11111111111111111111111111111111.1',
          eventName: kind,
          data: {
            'order_id': 'untrusted-top-level-alias',
            'sequence': 99,
            'data': payload,
          },
        ),
      );
}

final class _Realtime implements RealtimeService {
  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) =>
      Stream.value(
        const RealtimeEnvelope(
          eventId: 'event-1',
          eventName: 'order.updated',
          data: {'order_id': 'order-1', 'sequence': 7},
        ),
      );
}
