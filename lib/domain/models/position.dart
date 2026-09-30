import 'decimal_value.dart';
import 'market_product.dart';

enum PositionSide { long, short, none }

enum PositionMarginMode { cross, isolated, unknown }

final class Position {
  const Position({
    required this.positionId,
    required this.symbol,
    required this.kind,
    required this.quantity,
    required this.valueUsd,
    this.productId,
    this.positionVersion,
    this.hip3ActionId,
    this.protectionOrderIds = const [],
    this.marginMode,
    this.side = PositionSide.none,
    this.entryPrice,
    this.markPrice,
    this.unrealizedPnl,
    this.unrealizedPnlPercent,
    this.fundingPaid,
    this.realizedPnl,
    this.leverage,
    this.margin,
    this.liquidationPrice,
    this.takeProfitPrice,
    this.stopLossPrice,
    this.stopLimitPrice,
    this.updatedAt,
  });
  final String positionId;

  /// Full venue:coin identifier; never infer this from the display symbol.
  final String? productId;
  final String? positionVersion;
  final String? hip3ActionId;
  final List<String> protectionOrderIds;
  final PositionMarginMode? marginMode;
  final String symbol;
  final MarketProductKind kind;
  final PositionSide side;
  final DecimalValue quantity;
  final DecimalValue valueUsd;
  final DecimalValue? entryPrice;
  final DecimalValue? markPrice;
  final DecimalValue? unrealizedPnl;
  final DecimalValue? unrealizedPnlPercent;

  /// Signed cumulative funding: negative paid, positive received.
  final DecimalValue? fundingPaid;
  final DecimalValue? realizedPnl;
  final DecimalValue? leverage;
  final DecimalValue? margin;
  final DecimalValue? liquidationPrice;
  final DecimalValue? takeProfitPrice;
  final DecimalValue? stopLossPrice;
  final DecimalValue? stopLimitPrice;
  final DateTime? updatedAt;

  /// Current mark-to-market value derived from quantity and mark price.
  DecimalValue? get markValue {
    if (markPrice == null) return null;
    return DecimalValue(
      _multiplyDecimalStrings(quantity.value, markPrice!.value),
      asset: markPrice!.asset ?? 'USD',
      unit: 'notional',
    );
  }

  /// Current HIP-3 position notional.
  ///
  /// `value_usd` has a different contract meaning for perpetual positions
  /// (position equity), so it must not be used where the UI labels the
  /// mark-to-market position value/notional.
  DecimalValue? get markNotional =>
      kind == MarketProductKind.perp ? markValue : null;
}

String _multiplyDecimalStrings(String left, String right) {
  final leftNegative = left.startsWith('-');
  final rightNegative = right.startsWith('-');
  final leftUnsigned = leftNegative ? left.substring(1) : left;
  final rightUnsigned = rightNegative ? right.substring(1) : right;
  final leftParts = leftUnsigned.split('.');
  final rightParts = rightUnsigned.split('.');
  final leftScale = leftParts.length == 1 ? 0 : leftParts.last.length;
  final rightScale = rightParts.length == 1 ? 0 : rightParts.last.length;
  final scale = leftScale + rightScale;
  final leftDigits = BigInt.parse(
    '${leftParts.first}${leftParts.length == 1 ? '' : leftParts.last}',
  );
  final rightDigits = BigInt.parse(
    '${rightParts.first}${rightParts.length == 1 ? '' : rightParts.last}',
  );
  final product = leftDigits * rightDigits;
  final negative = leftNegative != rightNegative && product != BigInt.zero;
  final digits = product.abs().toString().padLeft(scale + 1, '0');
  final unsigned = scale == 0
      ? digits
      : '${digits.substring(0, digits.length - scale)}.${digits.substring(digits.length - scale)}';
  return '${negative ? '-' : ''}$unsigned';
}
