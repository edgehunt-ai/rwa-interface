import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/market_product.dart';
import '../../domain/models/order_intent.dart';
import '../../domain/models/hip3_opening_protection.dart';

api.OrderPreviewRequest orderPreviewRequest(OrderIntent intent) {
  final value = intent.kind == MarketProductKind.bstock
      ? api.BstockOrderPreviewRequest((builder) {
          builder
            ..symbol = intent.symbol
            ..kind = api.BstockOrderPreviewRequestKindEnum.bstock
            ..side = intent.side == TradingSide.buy
                ? api.BstockOrderPreviewRequestSideEnum.buy
                : api.BstockOrderPreviewRequestSideEnum.sell
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
                : intent.slippage?.value;
          if (intent.tpSl != null) {
            // bStocks does not support TP/SL. Reading builder.tpSl would
            // instantiate an empty TpSlSpec and leak `tp_sl:{enabled:false}`
            // onto the wire, so fail closed instead of touching the builder.
            throw ArgumentError('bStocks orders do not support TP/SL');
          }
        })
      : api.PerpOrderPreviewRequest((builder) {
          builder
            ..symbol = intent.symbol
            ..kind = api.PerpOrderPreviewRequestKindEnum.perp
            ..side = intent.side == TradingSide.long
                ? api.PerpOrderPreviewRequestSideEnum.long
                : api.PerpOrderPreviewRequestSideEnum.short
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
                : intent.slippage?.value;
          if (intent.tpSl != null) {
            throw ArgumentError('Use openingProtection for HIP3 orders');
          }
          builder.protection = _openingProtection(intent.openingProtection)
              ?.toBuilder();
        });
  return api.OrderPreviewRequest(
    (builder) => builder.oneOf = OneOfDynamic(
      typeIndex: intent.kind == MarketProductKind.bstock ? 0 : 1,
      types: const [api.BstockOrderPreviewRequest, api.PerpOrderPreviewRequest],
      value: value,
    ),
  );
}

api.Hip3OrderProtectionSpec? _openingProtection(Hip3OpeningProtection? value) {
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

api.OrderType _type(TradingOrderType value) => value == TradingOrderType.market
    ? api.OrderType.market
    : api.OrderType.limit;

api.MarginMode? _margin(TradingMarginMode? value) => switch (value) {
  TradingMarginMode.isolated => api.MarginMode.isolated,
  TradingMarginMode.cross => api.MarginMode.cross,
  null => null,
};
