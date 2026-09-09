import 'package:rwa_api_client/rwa_api_client.dart';

abstract interface class OrdersService {
  Future<OrderPreview> previewOrder(
    OrderPreviewRequest request, {
    required String idempotencyKey,
  });
  Future<Order> createOrder(
    CreateOrderRequest request, {
    required String idempotencyKey,
  });
  Future<OrderPage> listOrders({String? cursor});
  Future<Order> getOrder(String orderId);
  Future<Order> cancelOrder(String orderId, {required String idempotencyKey});
}
