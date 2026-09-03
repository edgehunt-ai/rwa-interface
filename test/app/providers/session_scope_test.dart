import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/repositories/order_command_repository.dart';
import 'package:rwa_interface/ui/features/api_example/providers/order_command_provider.dart';

void main() {
  test('clearing user scope advances session generation', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(sessionGenerationProvider).value, 0);
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    expect(container.read(sessionGenerationProvider).value, 1);
  });

  test('logout 清空用户 command 状态且 public generation 可继续读取', () async {
    final container = ProviderContainer(
      overrides: [orderCommandRepositoryProvider.overrideWithValue(_Orders())],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(orderCommandProvider, (_, _) {});
    addTearDown(subscription.close);
    await container.read(orderCommandProvider.future);
    await container
        .read(orderCommandProvider.notifier)
        .submit(intentId: 'old-user', idempotencyKey: 'old-key');
    expect(container.read(orderCommandProvider).value, 'order-old-user');
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    expect(await container.read(orderCommandProvider.future), isNull);
    expect(container.read(sessionGenerationProvider).value, 1);
  });
}

final class _Orders implements OrderCommandRepository {
  @override
  Future<String> submit({
    required String intentId,
    required String idempotencyKey,
  }) async => 'order-$intentId';
}
