import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/repositories/order_command_repository.dart';
import 'package:rwa_interface/ui/features/api_example/providers/order_command_provider.dart';

void main() {
  test('same intent retry preserves idempotency key', () async {
    final repository = _FakeOrders();
    final container = ProviderContainer(
      overrides: [orderCommandRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(orderCommandProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(orderCommandProvider.future);
    final notifier = container.read(orderCommandProvider.notifier);
    await notifier.submit(intentId: 'intent', idempotencyKey: 'key-1');
    await notifier.submit(intentId: 'intent', idempotencyKey: 'key-2');
    expect(repository.keys, ['key-1', 'key-1']);
  });

  test('20 次并发提交同一 intent 只执行一次命令', () async {
    final repository = _FakeOrders(delay: const Duration(milliseconds: 10));
    final container = ProviderContainer(
      overrides: [orderCommandRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(orderCommandProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(orderCommandProvider.future);
    final notifier = container.read(orderCommandProvider.notifier);
    await Future.wait(
      List.generate(
        20,
        (_) => notifier.submit(intentId: 'intent', idempotencyKey: 'key-1'),
      ),
    );
    expect(repository.keys, ['key-1']);
  });
}

final class _FakeOrders implements OrderCommandRepository {
  _FakeOrders({this.delay = Duration.zero});
  final Duration delay;
  final keys = <String>[];
  @override
  Future<String> submit({
    required String intentId,
    required String idempotencyKey,
  }) async {
    keys.add(idempotencyKey);
    await Future<void>.delayed(delay);
    return 'order-${keys.length}';
  }
}
