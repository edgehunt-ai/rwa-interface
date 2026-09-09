import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/services/orders_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';

void main() {
  test('pending signature is a non-retryable wait capability', () async {
    final result = await OrdersRepositoryImpl(_Orders()).create(
      OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: TradingOrderType.market,
        quantity: DecimalValue('0.000000000000000001', unit: 'quantity'),
      ),
      idempotencyKey: 'key-1',
    );
    expect(result.resource.quantity?.value, '0.000000000000000001');
    expect(result.capability?.code, 'order_signature_not_supported');
    expect(result.capability?.userAction, 'wait_for_feature');
    expect(result.capability?.retryable, isFalse);
  });
}

final class _Orders implements OrdersService {
  @override
  Future<api.Order> createOrder(
    api.CreateOrderRequest request, {
    required String idempotencyKey,
  }) async => api.Order(
    (order) => order
      ..orderId = 'order-1'
      ..symbol = 'NVDA'
      ..kind = api.ProductKind.bstock
      ..side = api.OrderSide.buy
      ..type = api.OrderType.market
      ..status = api.OrderStatus.pendingSignature
      ..quantity = '0.000000000000000001'
      ..createdAt = DateTime.utc(2026),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
