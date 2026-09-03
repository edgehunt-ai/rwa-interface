import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/realtime_providers.dart';
import 'package:rwa_interface/data/services/realtime_service.dart';
import 'package:rwa_interface/domain/models/realtime_envelope.dart';

void main() {
  test('canonical channel key prevents order-dependent state', () {
    expect(
      canonicalChannels(['positions', 'orders', 'orders']),
      'orders,positions',
    );
  });

  test('stream provider can be overridden without network', () async {
    final container = ProviderContainer(
      overrides: [realtimeServiceProvider.overrideWithValue(_FakeRealtime())],
    );
    addTearDown(container.dispose);
    final provider = realtimeEventsProvider('orders');
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);
    expect((await container.read(provider.future)).eventId, '1');
  });

  test('实体 provider 只交付匹配实体的最小更新', () async {
    final container = ProviderContainer(
      overrides: [realtimeServiceProvider.overrideWithValue(_EntityRealtime())],
    );
    addTearDown(container.dispose);
    final key = (channelsKey: 'orders', entityId: 'wanted');
    final subscription = container.listen(
      realtimeEntityProvider(key),
      (_, _) {},
    );
    addTearDown(subscription.close);
    final event = await container.read(realtimeEntityProvider(key).future);
    expect(event.data['order_id'], 'wanted');
  });
}

final class _EntityRealtime implements RealtimeService {
  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) =>
      Stream.fromIterable(const [
        RealtimeEnvelope(
          eventId: '1',
          eventName: 'order',
          data: {'order_id': 'other'},
        ),
        RealtimeEnvelope(
          eventId: '2',
          eventName: 'order',
          data: {'order_id': 'wanted'},
        ),
      ]);
}

final class _FakeRealtime implements RealtimeService {
  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) =>
      Stream.value(
        const RealtimeEnvelope(eventId: '1', eventName: 'order', data: {}),
      );
}
