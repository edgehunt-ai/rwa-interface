import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/session_scope.dart';
import '../../../../domain/repositories/order_command_repository.dart';

final orderCommandRepositoryProvider = Provider<OrderCommandRepository>(
  (ref) =>
      throw UnimplementedError('OrderCommandRepository must be overridden'),
);
final orderCommandProvider =
    AsyncNotifierProvider.autoDispose<OrderCommandNotifier, String?>(
      OrderCommandNotifier.new,
    );

final class OrderCommandNotifier extends AsyncNotifier<String?> {
  String? _intentId;
  String? _idempotencyKey;
  @override
  Future<String?> build() async {
    ref.watch(sessionGenerationProvider);
    _intentId = null;
    _idempotencyKey = null;
    return null;
  }

  Future<void> submit({
    required String intentId,
    required String idempotencyKey,
  }) async {
    if (state.isLoading) return;
    if (_intentId != intentId) {
      _intentId = intentId;
      _idempotencyKey = idempotencyKey;
    }
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref
          .read(orderCommandRepositoryProvider)
          .submit(intentId: intentId, idempotencyKey: _idempotencyKey!),
    );
  }
}
