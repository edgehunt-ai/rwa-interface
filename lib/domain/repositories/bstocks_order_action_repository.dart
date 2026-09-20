import '../models/order.dart';

abstract interface class BstocksOrderActionRepository {
  Future<BstocksWalletActionSubmission> submit({
    required String orderId,
    required String stepId,
    required String transactionHash,
    required String idempotencyKey,
  });
}
