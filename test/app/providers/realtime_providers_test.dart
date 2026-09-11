import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/realtime_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/data/services/realtime_service.dart';
import 'package:rwa_interface/domain/models/realtime_envelope.dart';
import 'package:rwa_interface/domain/repositories/realtime_repository.dart';

void main() {
  test(
    'raw and entity subscriptions restart with a fresh scope on session change',
    () async {
      final service = _CountingRealtime();
      final container = ProviderContainer(
        overrides: [realtimeServiceProvider.overrideWithValue(service)],
      );
      addTearDown(container.dispose);
      final raw = container.listen(
        realtimeEventsProvider('hip3:orders'),
        (_, _) {},
      );
      final entity = container.listen(
        realtimeEntityProvider((channelsKey: 'hip3:positions', entityId: 'p')),
        (_, _) {},
      );
      addTearDown(raw.close);
      addTearDown(entity.close);
      await pumpEventQueue();
      expect(service.subscriptions, 2);
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await pumpEventQueue();
      expect(service.cancellations, 2);
      expect(service.subscriptions, 4);
    },
  );
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

  test(
    'session generation cancels the old typed stream before resubscribe',
    () async {
      final repository = _TypedRealtime();
      final container = ProviderContainer(
        overrides: [realtimeRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      const oldKey = (channelsKey: 'orders', generation: 0);
      final old = container.listen(
        typedRealtimeEventsProvider(oldKey),
        (_, _) {},
      );
      addTearDown(old.close);
      await pumpEventQueue();
      expect(repository.subscriptions, 1);

      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await pumpEventQueue();
      expect(repository.cancellations, 1);

      const newKey = (channelsKey: 'orders', generation: 1);
      final current = container.listen(
        typedRealtimeEventsProvider(newKey),
        (_, _) {},
      );
      addTearDown(current.close);
      await pumpEventQueue();
      expect(repository.subscriptions, 2);
    },
  );
}

final class _CountingRealtime implements RealtimeService {
  int subscriptions = 0;
  int cancellations = 0;
  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) {
    late StreamController<RealtimeEnvelope> controller;
    controller = StreamController<RealtimeEnvelope>(
      onListen: () => subscriptions++,
      onCancel: () {
        cancellations++;
        return controller.close();
      },
    );
    return controller.stream;
  }
}

final class _TypedRealtime implements RealtimeRepository {
  int subscriptions = 0;
  int cancellations = 0;

  @override
  Stream<TypedRealtimeEvent> subscribe({required Set<String> channels}) {
    late final StreamController<TypedRealtimeEvent> controller;
    controller = StreamController<TypedRealtimeEvent>(
      onListen: () => subscriptions++,
      onCancel: () {
        cancellations++;
        return controller.close();
      },
    );
    return controller.stream;
  }
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
