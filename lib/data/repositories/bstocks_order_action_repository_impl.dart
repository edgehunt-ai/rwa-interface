import '../../domain/models/order.dart';
import '../../domain/repositories/bstocks_order_action_repository.dart';
import '../services/orders_service.dart';
import 'orders_repository_impl.dart';

final class BstocksOrderActionRepositoryImpl
    implements BstocksOrderActionRepository {
  const BstocksOrderActionRepositoryImpl(this._service);

  final OrdersService _service;

  @override
  Future<BstocksOrderAction> create({
    required String orderId,
    required String previewId,
    required String idempotencyKey,
  }) async => mapBstocksOrderAction(
    await _service.createBstocksOrderAction(
      orderId: orderId,
      previewId: previewId,
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<BstocksOrderAction> get({
    required String orderId,
    required String actionId,
  }) async => mapBstocksOrderAction(
    await _service.getBstocksOrderAction(orderId: orderId, actionId: actionId),
  );

  @override
  Future<BstocksWalletActionSubmission> submit({
    required String orderId,
    required String actionId,
    required String transactionHash,
    required String idempotencyKey,
  }) async {
    final value = await _service.submitBstocksWalletAction(
      orderId: orderId,
      actionId: actionId,
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
