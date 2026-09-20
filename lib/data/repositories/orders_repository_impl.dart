import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_intent.dart';
import '../../domain/models/order_preview.dart';
import '../../domain/models/hip3_opening_protection.dart';
import '../../domain/models/resource_result.dart';
import '../../domain/models/unsupported_capability.dart';
import '../../domain/repositories/orders_repository.dart';
import '../services/orders_service.dart';
import '../mappers/order_preview_request_mapper.dart';
import '../mappers/chain_name_mapper.dart';

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
    final settlementAsset = switch (value) {
      api.BstockOrderPreview(:final settlementAsset) => settlementAsset,
      api.PerpOrderPreview(:final settlementAsset) => settlementAsset,
      _ => null,
    };
    final settlementChain = switch (value) {
      api.BstockOrderPreview(:final network) => canonicalSettlementChainName(
        network: network.name,
      ),
      api.PerpOrderPreview(:final network) => canonicalChainName(network.name),
      _ => null,
    };
    final preview = OrderPreview(
      previewId: common.previewId,
      intent: intent,
      orderValue: _value(common.orderValue, 'notional', asset: settlementAsset),
      marketPrice: _optional(common.marketPrice, 'price', asset: 'USD'),
      estimatedPrice: _optional(common.estimatedPrice, 'price', asset: 'USD'),
      estimatedQuantity: _optional(
        common.estimatedQuantity,
        'quantity',
        asset: intent.symbol,
      ),
      estimatedReceive: _optional(
        common.estimatedReceive,
        'quantity',
        asset: common.estimatedReceiveUnit ?? intent.symbol,
      ),
      fee: _optional(common.fee, 'fee', asset: settlementAsset),
      marginRequired: _optional(
        common.marginRequired,
        'margin',
        asset: settlementAsset,
      ),
      liquidationPrice: _optional(
        common.liquidationPrice,
        'price',
        asset: 'USD',
      ),
      settlementAsset: settlementAsset,
      settlementChain: settlementChain,
      priceUpdated: common.priceUpdated ?? false,
      expiresAt: common.quoteExpiresAt?.toUtc(),
      hip3Execution: common.hip3Execution == null
          ? null
          : _hip3Execution(common.hip3Execution!),
      feeRate: _optional(common.feeRate, 'rate'),
      feeNote: common.feeNote,
      details: List.unmodifiable(
        common.details?.map(
              (entry) => PreviewDetail(
                entry.label,
                entry.value,
                tone: entry.tone?.name,
              ),
            ) ??
            const <PreviewDetail>[],
      ),
    );
    if (!preview.openingProtectionMatchesIntent) {
      throw const FormatException(
        'Opening protection confirmation is missing or differs from the order',
      );
    }
    return preview;
  }

  Hip3PreviewExecution _hip3Execution(
    api.Hip3PreviewExecution value,
  ) => Hip3PreviewExecution(
    openingProtection: value.openingProtection == null
        ? null
        : Hip3OpeningProtectionConfirmation(
            quantity: DecimalValue(
              value.openingProtection!.quantity,
              unit: 'quantity',
            ),
            legs: List.unmodifiable(
              value.openingProtection!.legs.map(
                (leg) => Hip3ConfirmedProtectionLeg(
                  takeProfit: switch (leg.role) {
                    api
                        .Hip3OpeningProtectionConfirmationLegsInnerRoleEnum
                        .takeProfit =>
                      true,
                    api
                        .Hip3OpeningProtectionConfirmationLegsInnerRoleEnum
                        .stopLoss =>
                      false,
                    _ => throw const FormatException('Unknown protection role'),
                  },
                  market: switch (leg.executionType) {
                    api
                        .Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum
                        .market =>
                      true,
                    api
                        .Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum
                        .limit =>
                      false,
                    _ => throw const FormatException(
                      'Unknown protection execution',
                    ),
                  },
                  triggerPrice: DecimalValue(
                    leg.triggerPrice,
                    asset: 'USDC',
                    unit: 'price',
                  ),
                  executionPrice: DecimalValue(
                    leg.executionPrice,
                    asset: 'USDC',
                    unit: 'price',
                  ),
                ),
              ),
            ),
          ),
    contextId: value.contextId,
    productId: value.productId,
    environment: value.environment.name,
    quantity: DecimalValue(value.quantity, unit: 'quantity'),
    type: switch (value.type) {
      api.Hip3PreviewExecutionTypeEnum.market => TradingOrderType.market,
      api.Hip3PreviewExecutionTypeEnum.limit => TradingOrderType.limit,
      _ => throw const FormatException('Unsupported HIP3 execution type'),
    },
    timeInForce: value.timeInForce.name,
    limitPrice: DecimalValue(value.limitPrice, asset: 'USDC', unit: 'price'),
    leverage: DecimalValue(value.leverage, unit: 'multiple'),
    marginMode: switch (value.marginMode) {
      api.MarginMode.cross => TradingMarginMode.cross,
      api.MarginMode.isolated => TradingMarginMode.isolated,
      _ => throw const FormatException('Unsupported HIP3 margin mode'),
    },
    reduceOnly: value.reduceOnly,
    notional: DecimalValue(value.notionalUsdc, asset: 'USDC', unit: 'notional'),
    marginRequired: DecimalValue(
      value.marginRequiredUsdc,
      asset: 'USDC',
      unit: 'margin',
    ),
    availableMargin: DecimalValue(
      value.availableMarginUsdc,
      asset: 'USDC',
      unit: 'margin',
    ),
    maximumQuantity: DecimalValue(value.maximumQuantity, unit: 'quantity'),
    estimatedFee: DecimalValue(
      value.estimatedFeeUsdc,
      asset: 'USDC',
      unit: 'fee',
    ),
    slippagePercent: DecimalValue(value.slippagePercent, unit: 'percent'),
    liquidationPrice: value.liquidationPrice == null
        ? null
        : DecimalValue(value.liquidationPrice!, asset: 'USDC', unit: 'price'),
    liquidationPriceUnavailableReason: value.liquidationPriceUnavailableReason,
  );

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
    String? symbol,
    String? productId,
    String? statusGroup,
  }) async {
    final page = await _service.listOrders(
      cursor: cursor,
      symbol: symbol,
      productId: productId,
      statusGroup: statusGroup,
      kind: switch (kind) {
        MarketProductKind.bstock => api.ProductKind.bstock,
        MarketProductKind.perp => api.ProductKind.perp,
        null => null,
      },
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
    return orderPreviewRequest(intent);
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
              ..timeInForce = api.BstocksTimeInForce.ioc
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
            if (intent.tpSl != null) {
              throw ArgumentError('Use openingProtection for HIP3 orders');
            }
            builder.protection = _openingProtection(intent.openingProtection)
                ?.toBuilder();
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

  api.Hip3OrderProtectionSpec? _openingProtection(
    Hip3OpeningProtection? value,
  ) {
    if (value == null) return null;
    api.Hip3TriggerSpec? leg(Hip3OpeningProtectionLeg? value) => value == null
        ? null
        : api.Hip3TriggerSpec(
            (b) => b
              ..triggerPrice = value.triggerPrice.value
              ..triggerReference = api.Hip3TriggerSpecTriggerReferenceEnum.mark
              ..executionType = value.limitPrice == null
                  ? api.Hip3TriggerSpecExecutionTypeEnum.market
                  : api.Hip3TriggerSpecExecutionTypeEnum.limit
              ..limitPrice = value.limitPrice?.value,
          );
    return api.Hip3OrderProtectionSpec(
      (b) => b
        ..takeProfit = leg(value.takeProfit)?.toBuilder()
        ..stopLoss = leg(value.stopLoss)?.toBuilder(),
    );
  }

  ResourceResult<TradingOrder> _result(api.Order value) {
    final order = mapOrder(value);
    return ResourceResult(
      resource: order,
      capability:
          order.status == TradingOrderStatus.pendingSignature &&
              order.kind != MarketProductKind.perp &&
              order.nextAction == null
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
  DecimalValue _value(String value, String unit, {String? asset}) =>
      DecimalValue(value, asset: asset, unit: unit);
  DecimalValue? _optional(String? value, String unit, {String? asset}) =>
      value == null ? null : _value(value, unit, asset: asset);
}

TradingOrder mapOrder(api.Order value) => TradingOrder(
  nextAction: _bstocksAction(value.nextAction),
  walletActionBlocker: value.walletActionBlocker?.name,
  actionStatus: value.actionStatus == null
      ? null
      : _bstocksActionStatus(value.actionStatus!),
  submittedTransactionHash: value.submittedTransactionHash,
  confirmedTransactionHash: value.confirmedTransactionHash,
  productId: value.productId,
  conditional: value.conditional == null
      ? null
      : ConditionalOrder(
          role: value.conditional!.role.name,
          triggerPrice: DecimalValue(
            value.conditional!.triggerPrice,
            asset: 'USDC',
            unit: 'price',
          ),
          triggerStatus: value.conditional!.triggerStatus.name,
          executionType: value.conditional!.executionType.name,
          sizeMode: value.conditional!.sizeMode.name,
          quantity: value.conditional!.quantity,
          triggerReference: value.conditional!.triggerReference.name,
          activationStatus:
              value.conditional!.activationStatus?.name ?? 'unknown',
          warningCode: value.conditional!.warningCode?.name,
          parentOrderId: value.conditional!.parentOrderId,
        ),
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

BstocksOrderAction? _bstocksAction(dynamic raw) {
  if (raw == null) return null;
  final value = raw.value;
  if (value is! Map) throw const FormatException('Invalid bStocks action');

  // `gas_payment` is not needed to construct or submit the frozen wallet
  // transaction. The staging API currently returns it with a null decision,
  // while the generated contract model declares that field as non-nullable.
  // Parse only the authoritative transaction fields here so an unrelated gas
  // quote cannot block approve/swap execution.
  Object? field(String name) => value[name];
  String stringField(String name) {
    final fieldValue = field(name);
    if (fieldValue is! String || fieldValue.isEmpty) {
      throw FormatException('Invalid bStocks action field: $name');
    }
    return fieldValue;
  }

  final kind = switch (stringField('kind')) {
    'erc20_approval' => BstocksOrderActionKind.erc20Approval,
    'spot_swap' => BstocksOrderActionKind.spotSwap,
    _ => BstocksOrderActionKind.unknown,
  };
  final chainId = field('chain_id');
  final parsedChainId = chainId is int
      ? chainId
      : int.tryParse(chainId.toString());
  if (parsedChainId == null || !const {56, 97, 31337}.contains(parsedChainId)) {
    throw const FormatException('Unsupported bStocks action chain');
  }
  final valueHex = stringField('value');
  if (valueHex != '0x0') {
    throw const FormatException('Unsupported bStocks action value');
  }
  final validUntil = DateTime.tryParse(stringField('valid_until'));
  if (validUntil == null) {
    throw const FormatException('Invalid bStocks action expiry');
  }
  return BstocksOrderAction(
    orderId: stringField('order_id'),
    stepId: stringField('step_id'),
    ordinal: field('ordinal') is int
        ? field('ordinal') as int
        : int.parse(field('ordinal').toString()),
    kind: kind,
    chainId: parsedChainId,
    from: stringField('from'),
    to: stringField('to'),
    data: stringField('data'),
    value: valueHex,
    payloadHash: stringField('payload_hash'),
    validUntil: validUntil.toUtc(),
  );
}

BstocksOrderActionStatus _bstocksActionStatus(api.BstocksActionStatus value) =>
    switch (value) {
      api.BstocksActionStatus.awaitingSignature =>
        BstocksOrderActionStatus.awaitingSignature,
      api.BstocksActionStatus.submitted => BstocksOrderActionStatus.submitted,
      api.BstocksActionStatus.confirmed => BstocksOrderActionStatus.confirmed,
      api.BstocksActionStatus.failed => BstocksOrderActionStatus.failed,
      api.BstocksActionStatus.manualReview =>
        BstocksOrderActionStatus.manualReview,
      _ => BstocksOrderActionStatus.unknown,
    };

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
