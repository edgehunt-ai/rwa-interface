import '../models/order.dart';

abstract interface class BstocksOrderActionRepository {
  Future<BstocksOrderAction> create({
    required String orderId,
    required String previewId,
    required String idempotencyKey,
  });

  Future<BstocksOrderAction> get({
    required String orderId,
    required String actionId,
  });

  Future<BstocksWalletActionSubmission> submit({
    required String orderId,
    required String actionId,
    required String transactionHash,
    required String idempotencyKey,
  });
}
