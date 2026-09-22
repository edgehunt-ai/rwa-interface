import 'decimal_value.dart';
import 'market_product.dart';
import 'hip3_opening_protection.dart';

enum TradingSide { buy, sell, long, short }

enum TradingOrderType { market, limit }

enum TradingMarginMode { isolated, cross }

final class TakeProfitStopLoss {
  const TakeProfitStopLoss({this.takeProfit, this.stopLoss, this.stopLimit});
  final DecimalValue? takeProfit;
  final DecimalValue? stopLoss;
  final DecimalValue? stopLimit;
}

final class OrderIntent {
  factory OrderIntent({
    required String symbol,
    required MarketProductKind kind,
    required TradingSide side,
    required TradingOrderType type,
    DecimalValue? amount,
    DecimalValue? quantity,
    DecimalValue? limitPrice,
    DecimalValue? slippage,
    DecimalValue? leverage,
    TradingMarginMode? marginMode,
    bool reduceOnly = false,
    TakeProfitStopLoss? tpSl,
    Hip3OpeningProtection? openingProtection,
  }) {
    final spotSide = side == TradingSide.buy || side == TradingSide.sell;
    if (kind == MarketProductKind.bstock && !spotSide ||
        kind == MarketProductKind.perp && spotSide) {
      throw ArgumentError('Side does not match product kind');
    }
    if (type == TradingOrderType.limit &&
        (limitPrice == null ||
            (kind == MarketProductKind.bstock && quantity == null))) {
      throw ArgumentError(
        'Limit orders require a limit price; spot orders require quantity',
      );
    }
    if (amount != null && quantity != null) {
      throw ArgumentError('Amount and quantity are mutually exclusive');
    }
    if (amount == null && quantity == null) {
      throw ArgumentError('Amount or quantity is required');
    }
    if (kind == MarketProductKind.bstock &&
        (leverage != null || marginMode != null || reduceOnly)) {
      throw ArgumentError('Spot orders cannot carry perpetual fields');
    }
    if (openingProtection != null &&
        (kind != MarketProductKind.perp || reduceOnly || tpSl != null)) {
      throw ArgumentError(
        'Opening protection requires a HIP3 opening order without legacy TP/SL',
      );
    }
    return OrderIntent._(
      symbol: symbol,
      kind: kind,
      side: side,
      type: type,
      amount: amount,
      quantity: quantity,
      limitPrice: limitPrice,
      slippage: slippage,
      leverage: leverage,
      marginMode: marginMode,
      reduceOnly: reduceOnly,
      tpSl: tpSl,
      openingProtection: openingProtection,
    );
  }

  const OrderIntent._({
    required this.symbol,
    required this.kind,
    required this.side,
    required this.type,
    required this.amount,
    required this.quantity,
    required this.limitPrice,
    required this.slippage,
    required this.leverage,
    required this.marginMode,
    required this.reduceOnly,
    required this.tpSl,
    required this.openingProtection,
  });

  final String symbol;
  final MarketProductKind kind;
  final TradingSide side;
  final TradingOrderType type;
  final DecimalValue? amount;
  final DecimalValue? quantity;
  final DecimalValue? limitPrice;
  final DecimalValue? slippage;
  final DecimalValue? leverage;
  final TradingMarginMode? marginMode;
  final bool reduceOnly;
  final TakeProfitStopLoss? tpSl;
  final Hip3OpeningProtection? openingProtection;

  /// The same order at a different slippage tolerance.
  ///
  /// Changing it invalidates the server's frozen terms, so the caller must
  /// re-quote rather than reuse the preview this intent produced.
  OrderIntent withSlippage(DecimalValue? value) => OrderIntent(
    symbol: symbol,
    kind: kind,
    side: side,
    type: type,
    amount: amount,
    quantity: quantity,
    limitPrice: limitPrice,
    slippage: value,
    leverage: leverage,
    marginMode: marginMode,
    reduceOnly: reduceOnly,
    tpSl: tpSl,
    openingProtection: openingProtection,
  );

  String get fingerprint => [
    symbol,
    kind.name,
    side.name,
    type.name,
    amount,
    quantity,
    limitPrice,
    slippage,
    leverage,
    marginMode?.name,
    reduceOnly,
    tpSl?.takeProfit,
    tpSl?.stopLoss,
    tpSl?.stopLimit,
    openingProtection?.fingerprint,
  ].join('|');
}
