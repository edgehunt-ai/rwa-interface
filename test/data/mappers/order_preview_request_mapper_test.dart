import 'package:flutter_test/flutter_test.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/mappers/order_preview_request_mapper.dart';
import 'package:rwa_interface/data/repositories/orders_repository_impl.dart';
import 'package:rwa_interface/data/services/orders_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';

void main() {
  OrderIntent bstockIntent({TradingOrderType type = TradingOrderType.market}) =>
      OrderIntent(
        symbol: 'NVDA',
        kind: MarketProductKind.bstock,
        side: TradingSide.buy,
        type: type,
        amount: type == TradingOrderType.market ? DecimalValue('15') : null,
        quantity: type == TradingOrderType.limit ? DecimalValue('1') : null,
        limitPrice: type == TradingOrderType.limit ? DecimalValue('100') : null,
        // A resting limit order is GTC and must not carry a slippage
        // tolerance; only the IOC market order does.
        slippage: type == TradingOrderType.market
            ? DecimalValue('0.12', unit: 'percent')
            : null,
      );

  OrderIntent perpIntent({TradingOrderType type = TradingOrderType.market}) =>
      OrderIntent(
        symbol: 'TSLA',
        kind: MarketProductKind.perp,
        side: TradingSide.long,
        type: type,
        amount: type == TradingOrderType.market ? DecimalValue('15') : null,
        quantity: type == TradingOrderType.limit ? DecimalValue('1') : null,
        limitPrice: type == TradingOrderType.limit ? DecimalValue('100') : null,
        leverage: DecimalValue('2', asset: 'x', unit: 'multiple'),
        marginMode: TradingMarginMode.cross,
      );

  Map<String, Object?> previewWire(OrderIntent intent) =>
      api.standardSerializers.serializeWith(
        api.OrderPreviewRequest.serializer,
        orderPreviewRequest(intent),
      ) as Map<String, Object?>;

  test('bStocks preview never serializes tp_sl', () {
    final wire = previewWire(bstockIntent());
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

  test('bStocks sends GTC for limit orders and IOC for market orders', () {
    expect(previewWire(bstockIntent())['time_in_force'], 'ioc');
    expect(
      previewWire(bstockIntent(type: TradingOrderType.limit))['time_in_force'],
      'gtc',
    );
  });

  test('limit previews never serialize slippage_percent', () {
    // The provider rejects a non-null slippage tolerance on a GTC limit order.
    expect(previewWire(bstockIntent())['slippage_percent'], '0.12');
    expect(
      previewWire(bstockIntent(type: TradingOrderType.limit))
          .containsKey('slippage_percent'),
      isFalse,
    );
    expect(
      previewWire(perpIntent(type: TradingOrderType.limit))
          .containsKey('slippage_percent'),
      isFalse,
    );
  });

  test('HIP3 sends GTC for limit orders and omits TIF for market orders', () {
    // Market orders keep the provider default (IOC); only a resting limit
    // order pins GTC explicitly.
    expect(previewWire(perpIntent()).containsKey('time_in_force'), isFalse);
    expect(
      previewWire(perpIntent(type: TradingOrderType.limit))['time_in_force'],
      'gtc',
    );
  });

  test('create mirrors the preview time_in_force for both products', () async {
    final service = _CapturingOrders();
    final repository = OrdersRepositoryImpl(service);

    await repository.create(
      bstockIntent(),
      idempotencyKey: 'bstock-market',
      previewId: 'preview-1',
    );
    expect(service.createWire!['time_in_force'], 'ioc');

    await repository.create(
      bstockIntent(type: TradingOrderType.limit),
      idempotencyKey: 'bstock-limit',
      previewId: 'preview-1',
    );
    expect(service.createWire!['time_in_force'], 'gtc');
    expect(service.createWire!.containsKey('slippage_percent'), isFalse);

    await repository.create(
      perpIntent(),
      idempotencyKey: 'perp-market',
      previewId: 'preview-1',
    );
    expect(service.createWire!.containsKey('time_in_force'), isFalse);
    expect(service.createWire!['kind'], 'perp');

    await repository.create(
      perpIntent(type: TradingOrderType.limit),
      idempotencyKey: 'perp-limit',
      previewId: 'preview-1',
    );
    expect(service.createWire!['time_in_force'], 'gtc');
    expect(service.createWire!.containsKey('slippage_percent'), isFalse);
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
    final value = api.BstockOrder(
      (b) => b
        ..orderId = 'order-1'
        ..symbol = 'NVDA'
        ..kind = api.BstockOrderWalletActionStateKindEnum.bstock
        ..side = api.OrderSide.buy
        ..type = api.OrderType.market
        ..status = api.BstockOrderStatus.pending
        ..walletActionBlocker = api
            .BstockOrderWalletActionStateWalletActionBlockerEnum
            .actionNotReady
        ..quantity = '1'
        ..createdAt = DateTime.utc(2026),
    );
    return api.Order(
      (b) => b.oneOf = OneOfDynamic(
        typeIndex: 0,
        types: const [api.BstockOrder, api.PerpOrder],
        value: value,
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
