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
import '../api/order_preview_payload.dart';
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
    final response = await _service.previewOrder(
      _previewRequest(intent),
      idempotencyKey: idempotencyKey,
    );
    return _mapPreview(response.value, intent);
  }

  @override
  Future<OrderPreview> previewContinuation(
    String orderId,
    OrderIntent intent, {
    required String idempotencyKey,
  }) async {
    final response = await _service.previewBstocksOrderContinuation(
      orderId: orderId,
      idempotencyKey: idempotencyKey,
    );
    if (response.boundOrderId != orderId) {
      throw const FormatException('Continuation preview order mismatch');
    }
    return _mapPreview(response.preview, intent);
  }

  OrderPreview _mapPreview(api.OrderPreview value, OrderIntent intent) {
    final payload = value.oneOf.value as OrderPreviewPayload;
    final common = payload.common;
    // Settlement identity is read as text: the generated enums fall back to
    // `unknown_default_open_api`, which would make testnet TUSDT and mainnet
    // USDT indistinguishable.
    final settlementAsset = payload.text('settlement_asset');
    final network = payload.text('network');
    final isBstock = payload.text('kind') == 'bstock';
    final settlementChain = network == null
        ? null
        : isBstock
        ? canonicalSettlementChainName(network: network)
        : canonicalChainName(network);
    final approvalRequired =
        common.approvalRequired ??
        (payload.fields['approval_required'] == true);
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
      // Only bStocks submission depends on a confirmation binding.
      executionReady: !isBstock || _hasBstocksExecutionBinding(payload.fields),
      approvalRequired: isBstock && approvalRequired,
    );
    if (!preview.openingProtectionMatchesIntent) {
      throw const FormatException(
        'Opening protection confirmation is missing or differs from the order',
      );
    }
    return preview;
  }

  bool _hasBstocksExecutionBinding(Map<String, Object?> raw) {
    final bstocks = raw['bstocks'];
    final binding = bstocks is Map ? bstocks['confirmation_binding'] : null;
    return binding is Map &&
        binding['maximum_input_raw'] is String &&
        binding['expires_at'] is String;
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
    maximumQuantity: value.maximumQuantity == null
        ? null
        : DecimalValue(value.maximumQuantity!, unit: 'quantity'),
    maximumQuantityUnavailableReason: value.maximumQuantityUnavailableReason,
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
    blockers: List.unmodifiable(value.blockers ?? const <String>[]),
    crossLiquidationImpacts: List.unmodifiable(
      value.crossLiquidationImpacts.map(
        (impact) => Hip3CrossLiquidationImpact(
          productId: impact.productId,
          side: switch (impact.side) {
            api.Hip3CrossLiquidationImpactSideEnum.long => TradingSide.long,
            api.Hip3CrossLiquidationImpactSideEnum.short => TradingSide.short,
            _ => throw const FormatException(
              'Unsupported cross liquidation impact side',
            ),
          },
          markPrice: impact.markPrice == null
              ? null
              : DecimalValue(impact.markPrice!, asset: 'USDC', unit: 'price'),
          beforeLiquidationPrice: impact.beforeLiquidationPrice == null
              ? null
              : DecimalValue(
                  impact.beforeLiquidationPrice!,
                  asset: 'USDC',
                  unit: 'price',
                ),
          afterLiquidationPrice: impact.afterLiquidationPrice == null
              ? null
              : DecimalValue(
                  impact.afterLiquidationPrice!,
                  asset: 'USDC',
                  unit: 'price',
                ),
          unavailableReason: impact.unavailableReason?.name,
        ),
      ),
    ),
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
              ..timeInForce = intent.type == TradingOrderType.limit
                  ? api.BstocksTimeInForce.gtc
                  : api.BstocksTimeInForce.ioc
              ..amount = intent.amount?.value
              ..quantity = intent.quantity?.value
              ..limitPrice = intent.limitPrice?.value
              // A resting limit order is GTC, which the contract forbids from
              // carrying a slippage tolerance; only the IOC market order does.
              ..slippagePercent = intent.type == TradingOrderType.limit
                  ? null
                  : intent.slippage?.value
              ..previewId = previewId;
            if (intent.tpSl != null) {
              // bStocks does not support TP/SL. Reading builder.tpSl would
              // instantiate an empty TpSlSpec and leak `tp_sl:{enabled:false}`
              // onto the wire, so fail closed instead of touching the builder.
              throw ArgumentError('bStocks orders do not support TP/SL');
            }
          })
        : api.PerpCreateOrderRequest((builder) {
            builder
              ..symbol = intent.symbol
              ..kind = api.PerpCreateOrderRequestKindEnum.perp
              ..side = intent.side == TradingSide.long
                  ? api.PerpCreateOrderRequestSideEnum.long
                  : api.PerpCreateOrderRequestSideEnum.short
              ..type = _type(intent.type)
              // A resting limit order must be GTC. Market orders keep the
              // provider default (IOC); sending IOC on a limit order would
              // cancel an unfilled quote immediately.
              ..timeInForce = intent.type == TradingOrderType.limit
                  ? api.Hip3TimeInForce.gtc
                  : null
              ..amount = intent.amount?.value
              ..quantity = intent.quantity?.value
              ..limitPrice = intent.limitPrice?.value
              ..leverage = intent.leverage?.value
              ..marginMode = _margin(intent.marginMode)
              ..reduceOnly = intent.reduceOnly
              // A resting limit order is GTC, which the contract forbids from
              // carrying a slippage tolerance; only the IOC market order does.
              ..slippagePercent = intent.type == TradingOrderType.limit
                  ? null
                  : intent.slippage?.value
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

TradingOrder mapOrder(api.Order value) => switch (value.oneOf.value) {
  final api.BstockOrder order => _mapBstockOrder(order),
  final api.PerpOrder order => _mapPerpOrder(order),
  _ => throw const FormatException('Unsupported order variant'),
};

TradingOrder _mapBstockOrder(api.BstockOrder value) => TradingOrder(
  nextAction: value.nextAction == null
      ? null
      : mapBstocksOrderAction(value.nextAction!),
  walletActionBlocker: value.walletActionBlocker?.name,
  currentActionId: value.currentActionId,
  settlementAsset: value.settlementAsset,
  requestedAmount: _orderValue(
    value.requestedAmount,
    'notional',
    asset: value.settlementAsset,
  ),
  productId: value.productId,
  orderId: value.orderId,
  clientOrderId: value.clientOrderId,
  symbol: value.symbol,
  kind: MarketProductKind.bstock,
  side: _side(value.side),
  type: _orderType(value.type),
  status: _bstockStatus(value.status),
  quantity: _orderValue(value.quantity, 'quantity', asset: value.symbol),
  filledQuantity: _orderValue(
    value.filledQuantity,
    'quantity',
    asset: value.symbol,
  ),
  limitPrice: _orderValue(
    value.limitPrice,
    'price',
    asset: value.settlementAsset,
  ),
  averageFillPrice: _orderValue(
    value.averageFillPrice,
    'price',
    asset: value.settlementAsset,
  ),
  orderValue: _orderValue(
    value.orderValue,
    'notional',
    asset: value.settlementAsset,
  ),
  fee: _orderValue(value.fee, 'fee', asset: value.settlementAsset),
  positionId: value.positionId,
  txHash: value.txHash,
  failureReason: value.failureReason,
  createdAt: value.createdAt.toUtc(),
  updatedAt: value.updatedAt?.toUtc(),
);

TradingOrder _mapPerpOrder(api.PerpOrder value) => TradingOrder(
  walletActionBlocker: value.walletActionBlocker.name,
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
  kind: MarketProductKind.perp,
  side: _side(value.side),
  type: _orderType(value.type),
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

BstocksOrderAction mapBstocksOrderAction(api.OrderAction value) =>
    BstocksOrderAction(
      orderId: value.orderId,
      actionId: value.actionId,
      kind: switch (value.kind) {
        api.OrderActionKindEnum.erc20Approval =>
          BstocksOrderActionKind.erc20Approval,
        api.OrderActionKindEnum.placeGtcOrder =>
          BstocksOrderActionKind.placeGtcOrder,
        api.OrderActionKindEnum.executeIocOrder =>
          BstocksOrderActionKind.executeIocOrder,
        api.OrderActionKindEnum.cancelOrder =>
          BstocksOrderActionKind.cancelOrder,
        _ => BstocksOrderActionKind.unknown,
      },
      status: _bstocksActionStatus(value.status),
      previewId: value.previewId,
      submittedTransactionHash: value.submittedTransactionHash,
      confirmedTransactionHash: value.confirmedTransactionHash,
      failureReason: value.failureReason,
      chainId: switch (value.chainId) {
        api.OrderActionChainIdEnum.number56 => 56,
        api.OrderActionChainIdEnum.number97 => 97,
        api.OrderActionChainIdEnum.number31337 => 31337,
        _ => throw const FormatException('Unsupported bStocks action chain'),
      },
      from: value.from,
      to: value.to,
      data: value.data,
      value: switch (value.value) {
        api.OrderActionValueEnum.n0x0 => '0x0',
        _ => throw const FormatException('Unsupported bStocks action value'),
      },
      payloadHash: value.payloadHash,
      validUntil: value.validUntil.toUtc(),
    );

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

TradingOrderStatus _bstockStatus(api.BstockOrderStatus value) =>
    switch (value) {
      api.BstockOrderStatus.pending => TradingOrderStatus.pending,
      api.BstockOrderStatus.awaitingConfirmation =>
        TradingOrderStatus.awaitingConfirmation,
      api.BstockOrderStatus.submitted => TradingOrderStatus.submitted,
      api.BstockOrderStatus.open => TradingOrderStatus.open,
      api.BstockOrderStatus.partiallyFilled =>
        TradingOrderStatus.partiallyFilled,
      api.BstockOrderStatus.filled => TradingOrderStatus.filled,
      api.BstockOrderStatus.cancelled => TradingOrderStatus.cancelled,
      api.BstockOrderStatus.failed => TradingOrderStatus.failed,
      api.BstockOrderStatus.ambiguous => TradingOrderStatus.ambiguous,
      api.BstockOrderStatus.manualReview => TradingOrderStatus.manualReview,
      _ => TradingOrderStatus.unknown,
    };

TradingSide _side(api.OrderSide value) => switch (value) {
  api.OrderSide.buy => TradingSide.buy,
  api.OrderSide.sell => TradingSide.sell,
  api.OrderSide.long => TradingSide.long,
  api.OrderSide.short => TradingSide.short,
  _ => throw const FormatException('Unknown order side'),
};

TradingOrderType _orderType(api.OrderType value) =>
    value == api.OrderType.market
    ? TradingOrderType.market
    : TradingOrderType.limit;

DecimalValue? _orderValue(
  String? value,
  String unit, {
  String? asset = 'USDC',
}) => value == null ? null : DecimalValue(value, asset: asset, unit: unit);
