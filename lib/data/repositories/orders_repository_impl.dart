import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_intent.dart';
import '../../domain/models/order_preview.dart';
import '../../domain/models/resource_result.dart';
import '../../domain/models/unsupported_capability.dart';
import '../../domain/repositories/orders_repository.dart';
import '../services/orders_service.dart';

final class OrdersRepositoryImpl implements OrdersRepository {
  OrdersRepositoryImpl(this._service);
  final OrdersService _service;

  @override
  Future<OrderPreview> preview(
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    final wire = await _service.previewOrder(
      _previewRequest(intent),
      idempotencyKey: idempotencyKey,
    );
    final value = wire.oneOf.value;
    final common = value as api.OrderPreviewCommon;
    return OrderPreview(
      previewId: common.previewId,
      intent: intent,
      orderValue: _value(common.orderValue, 'notional'),
      marketPrice: _optional(common.marketPrice, 'price'),
      estimatedPrice: _optional(common.estimatedPrice, 'price'),
      estimatedQuantity: _optional(common.estimatedQuantity, 'quantity'),
      estimatedReceive: _optional(
        common.estimatedReceive,
        common.estimatedReceiveUnit ?? 'quantity',
      ),
      fee: _optional(common.fee, 'fee'),
      marginRequired: _optional(common.marginRequired, 'margin'),
      liquidationPrice: _optional(common.liquidationPrice, 'price'),
      settlementAsset: switch (value) {
        api.BstockOrderPreview(:final settlementAsset) => settlementAsset.name,
        api.PerpOrderPreview(:final settlementAsset) => settlementAsset.name,
        _ => null,
      },
      priceUpdated: common.priceUpdated ?? false,
      expiresAt: common.quoteExpiresAt?.toUtc(),
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> create(
    OrderIntent intent, {
    required String idempotencyKey,
    String? previewId,
  }) async => _result(
    await _service.createOrder(
      _createRequest(intent, previewId),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<DomainPage<ResourceResult<TradingOrder>>> list({
    String? cursor,
    MarketProductKind? kind,
  }) async {
    final page = await _service.listOrders(
      cursor: cursor,
      kind: kind == MarketProductKind.perp ? api.ProductKind.perp : null,
    );
    return DomainPage(
      items: page.items.map(_result).toList(),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> get(String orderId) async =>
      _result(await _service.getOrder(orderId));

  @override
  Future<ResourceResult<TradingOrder>> cancel(
    String orderId, {
    required String idempotencyKey,
  }) async => _result(
    await _service.cancelOrder(orderId, idempotencyKey: idempotencyKey),
  );

  api.OrderPreviewRequest _previewRequest(OrderIntent intent) {
    final value = intent.kind == MarketProductKind.bstock
        ? api.BstockOrderPreviewRequest((builder) {
            builder
              ..symbol = intent.symbol
              ..kind = api.BstockOrderPreviewRequestKindEnum.bstock
              ..side = intent.side == TradingSide.buy
                  ? api.BstockOrderPreviewRequestSideEnum.buy
                  : api.BstockOrderPreviewRequestSideEnum.sell
              ..type = _type(intent.type)
              ..amount = intent.amount?.value
              ..quantity = intent.quantity?.value
              ..limitPrice = intent.limitPrice?.value
              ..slippagePercent = intent.slippage?.value;
            _tpSl(builder.tpSl, intent.tpSl);
          })
        : api.PerpOrderPreviewRequest((builder) {
            builder
              ..symbol = intent.symbol
              ..kind = api.PerpOrderPreviewRequestKindEnum.perp
              ..side = intent.side == TradingSide.long
                  ? api.PerpOrderPreviewRequestSideEnum.long
                  : api.PerpOrderPreviewRequestSideEnum.short
              ..type = _type(intent.type)
              ..amount = intent.amount?.value
              ..quantity = intent.quantity?.value
              ..limitPrice = intent.limitPrice?.value
              ..leverage = intent.leverage?.value
              ..marginMode = _margin(intent.marginMode)
              ..reduceOnly = intent.reduceOnly
              ..slippagePercent = intent.slippage?.value;
            _tpSl(builder.tpSl, intent.tpSl);
          });
    return api.OrderPreviewRequest(
      (builder) => builder.oneOf = OneOfDynamic(
        typeIndex: intent.kind == MarketProductKind.bstock ? 0 : 1,
        types: const [
          api.BstockOrderPreviewRequest,
          api.PerpOrderPreviewRequest,
        ],
        value: value,
      ),
    );
  }

  api.CreateOrderRequest _createRequest(OrderIntent intent, String? previewId) {
    final value = intent.kind == MarketProductKind.bstock
        ? api.BstockCreateOrderRequest((builder) {
            builder
              ..symbol = intent.symbol
              ..kind = api.BstockCreateOrderRequestKindEnum.bstock
              ..side = intent.side == TradingSide.buy
                  ? api.BstockCreateOrderRequestSideEnum.buy
                  : api.BstockCreateOrderRequestSideEnum.sell
              ..type = _type(intent.type)
              ..amount = intent.amount?.value
              ..quantity = intent.quantity?.value
              ..limitPrice = intent.limitPrice?.value
              ..slippagePercent = intent.slippage?.value
              ..previewId = previewId;
            _tpSl(builder.tpSl, intent.tpSl);
          })
        : api.PerpCreateOrderRequest((builder) {
            builder
              ..symbol = intent.symbol
              ..kind = api.PerpCreateOrderRequestKindEnum.perp
              ..side = intent.side == TradingSide.long
                  ? api.PerpCreateOrderRequestSideEnum.long
                  : api.PerpCreateOrderRequestSideEnum.short
              ..type = _type(intent.type)
              ..amount = intent.amount?.value
              ..quantity = intent.quantity?.value
              ..limitPrice = intent.limitPrice?.value
              ..leverage = intent.leverage?.value
              ..marginMode = _margin(intent.marginMode)
              ..reduceOnly = intent.reduceOnly
              ..slippagePercent = intent.slippage?.value
              ..previewId = previewId;
            _tpSl(builder.tpSl, intent.tpSl);
          });
    return api.CreateOrderRequest(
      (builder) => builder.oneOf = OneOfDynamic(
        typeIndex: intent.kind == MarketProductKind.bstock ? 0 : 1,
        types: const [api.BstockCreateOrderRequest, api.PerpCreateOrderRequest],
        value: value,
      ),
    );
  }

  void _tpSl(api.TpSlSpecBuilder builder, TakeProfitStopLoss? value) {
    if (value == null) return;
    builder
      ..enabled = true
      ..takeProfitPrice = value.takeProfit?.value
      ..stopLossPrice = value.stopLoss?.value
      ..stopLimitPrice = value.stopLimit?.value;
  }

  ResourceResult<TradingOrder> _result(api.Order value) {
    final order = mapOrder(value);
    return ResourceResult(
      resource: order,
      capability:
          order.status == TradingOrderStatus.pendingSignature &&
              order.kind != MarketProductKind.perp
          ? UnsupportedCapability.orderSignature(resourceId: order.orderId)
          : null,
    );
  }

  api.OrderType _type(TradingOrderType value) =>
      value == TradingOrderType.market
      ? api.OrderType.market
      : api.OrderType.limit;
  api.MarginMode? _margin(TradingMarginMode? value) => switch (value) {
    TradingMarginMode.isolated => api.MarginMode.isolated,
    TradingMarginMode.cross => api.MarginMode.cross,
    null => null,
  };
  DecimalValue _value(String value, String unit) =>
      DecimalValue(value, asset: 'USDC', unit: unit);
  DecimalValue? _optional(String? value, String unit) =>
      value == null ? null : _value(value, unit);
}

TradingOrder mapOrder(api.Order value) => TradingOrder(
  orderId: value.orderId,
  clientOrderId: value.clientOrderId,
  symbol: value.symbol,
  kind: value.kind == api.ProductKind.bstock
      ? MarketProductKind.bstock
      : MarketProductKind.perp,
  side: switch (value.side) {
    api.OrderSide.buy => TradingSide.buy,
    api.OrderSide.sell => TradingSide.sell,
    api.OrderSide.long => TradingSide.long,
    api.OrderSide.short => TradingSide.short,
    _ => throw const FormatException('Unknown order side'),
  },
  type: value.type == api.OrderType.market
      ? TradingOrderType.market
      : TradingOrderType.limit,
  status: _status(value.status),
  quantity: _orderValue(value.quantity, 'quantity'),
  filledQuantity: _orderValue(value.filledQuantity, 'quantity'),
  limitPrice: _orderValue(value.limitPrice, 'price'),
  averageFillPrice: _orderValue(value.averageFillPrice, 'price'),
  orderValue: _orderValue(value.orderValue, 'notional'),
  fee: _orderValue(value.fee, 'fee'),
  positionId: value.positionId,
  txHash: value.txHash,
  failureReason: value.failureReason,
  createdAt: value.createdAt.toUtc(),
  updatedAt: value.updatedAt?.toUtc(),
);

TradingOrderStatus _status(api.OrderStatus value) => switch (value) {
  api.OrderStatus.pendingSignature => TradingOrderStatus.pendingSignature,
  api.OrderStatus.submitted => TradingOrderStatus.submitted,
  api.OrderStatus.open => TradingOrderStatus.open,
  api.OrderStatus.partiallyFilled => TradingOrderStatus.partiallyFilled,
  api.OrderStatus.filled => TradingOrderStatus.filled,
  api.OrderStatus.cancelled => TradingOrderStatus.cancelled,
  api.OrderStatus.failed => TradingOrderStatus.failed,
  api.OrderStatus.ambiguous => TradingOrderStatus.ambiguous,
  api.OrderStatus.manualReview => TradingOrderStatus.manualReview,
  _ => TradingOrderStatus.unknown,
};

DecimalValue? _orderValue(String? value, String unit) =>
    value == null ? null : DecimalValue(value, asset: 'USDC', unit: unit);
