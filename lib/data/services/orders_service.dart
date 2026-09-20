import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class OrdersService {
  Future<api.OrderPreview> previewOrder(
    api.OrderPreviewRequest request, {
    required String idempotencyKey,
  });
  Future<api.Order> createOrder(
    api.CreateOrderRequest request, {
    required String idempotencyKey,
  });
  Future<api.OrderPage> listOrders({
    String? cursor,
    api.ProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  });
  Future<api.Order> getOrder(String orderId);
  Future<api.Order> cancelOrder(
    String orderId, {
    required String idempotencyKey,
  });
  Future<api.BstocksWalletActionSubmission> submitBstocksWalletAction({
    required String orderId,
    required String stepId,
    required String transactionHash,
    required String idempotencyKey,
  });
}
