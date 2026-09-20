import '../../domain/models/order.dart';
import '../../domain/repositories/bstocks_order_action_repository.dart';
import '../services/orders_service.dart';

final class BstocksOrderActionRepositoryImpl
    implements BstocksOrderActionRepository {
  const BstocksOrderActionRepositoryImpl(this._service);

  final OrdersService _service;

  @override
  Future<BstocksWalletActionSubmission> submit({
    required String orderId,
    required String stepId,
    required String transactionHash,
    required String idempotencyKey,
  }) async {
    final value = await _service.submitBstocksWalletAction(
      orderId: orderId,
      stepId: stepId,
      transactionHash: transactionHash,
      idempotencyKey: idempotencyKey,
    );
    return BstocksWalletActionSubmission(
      orderId: value.orderId,
      actionId: value.actionId,
      status: value.status.name,
      transactionHash: value.submittedTransactionHash,
      updatedAt: value.updatedAt.toUtc(),
    );
  }
}
