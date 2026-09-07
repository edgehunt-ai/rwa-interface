import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/repositories/realtime_repository_impl.dart';
import 'package:rwa_interface/data/services/realtime_service.dart';
import 'package:rwa_interface/domain/models/realtime_envelope.dart';

void main() {
  test('maps envelope to typed entity and sequence', () async {
    final event = await RealtimeRepositoryImpl(_Realtime())
        .subscribe(channels: {'orders'})
        .single;
    expect(event.entityId, 'order-1');
    expect(event.sequence, 7);
  });
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
