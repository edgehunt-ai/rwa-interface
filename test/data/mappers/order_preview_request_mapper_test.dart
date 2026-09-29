import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/mappers/order_preview_request_mapper.dart';
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/services/orders_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';

void main() {
  OrderIntent bstockIntent() => OrderIntent(
    symbol: 'NVDA',
    kind: MarketProductKind.bstock,
    side: TradingSide.buy,
    type: TradingOrderType.market,
    amount: DecimalValue('15'),
    slippage: DecimalValue('0.12', unit: 'percent'),
  );

  test('bStocks preview never serializes tp_sl', () {
    final wire = api.standardSerializers.serializeWith(
      api.OrderPreviewRequest.serializer,
      orderPreviewRequest(bstockIntent()),
    ) as Map;
    // The generated builder's `tpSl` getter lazily instantiates an empty
    // TpSlSpec, so an unconditional `_tpSl(builder.tpSl, ...)` call leaked
    // `tp_sl: {enabled: false}` onto a plain bStocks preview.
    expect(wire.containsKey('tp_sl'), isFalse);
    expect(wire['kind'], 'bstock');
  });

  test('bStocks create never serializes tp_sl', () async {
    final service = _CapturingOrders();
    await OrdersRepositoryImpl(
      service,
    ).create(bstockIntent(), idempotencyKey: 'key-1', previewId: 'preview-1');
    expect(service.createWire!.containsKey('tp_sl'), isFalse);
    expect(service.createWire!['preview_id'], 'preview-1');
    expect(service.createWire!['kind'], 'bstock');
  });
}

final class _CapturingOrders implements OrdersService {
  Map<String, Object?>? createWire;

  @override
  Future<api.Order> createOrder(
    api.CreateOrderRequest request, {
    required String idempotencyKey,
  }) async {
    createWire = Map<String, Object?>.from(
      api.standardSerializers.serializeWith(
        api.CreateOrderRequest.serializer,
        request,
      ) as Map,
    );
    return api.Order(
      (b) => b
        ..orderId = 'order-1'
        ..symbol = 'NVDA'
        ..kind = api.ProductKind.bstock
        ..side = api.OrderSide.buy
        ..type = api.OrderType.market
        ..status = api.OrderStatus.pendingSignature
        ..quantity = '1'
        ..createdAt = DateTime.utc(2026),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
