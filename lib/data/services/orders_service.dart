import 'package:rwa_api_client/rwa_api_client.dart';

abstract interface class OrdersService {
  Future<Order> createOrder(
    CreateOrderRequest request, {
    required String idempotencyKey,
  });
}
