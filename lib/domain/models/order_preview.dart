import 'decimal_value.dart';
import 'order_intent.dart';
import 'hip3_opening_protection.dart';

final class OrderPreview {
  const OrderPreview({
    required this.previewId,
    required this.intent,
    required this.orderValue,
    this.marketPrice,
    this.estimatedPrice,
    this.estimatedQuantity,
    this.estimatedReceive,
    this.fee,
    this.marginRequired,
    this.liquidationPrice,
    this.settlementAsset,
    this.settlementChain,
    this.priceUpdated = false,
    this.expiresAt,
    this.hip3Execution,
    this.feeRate,
    this.feeNote,
    this.details = const [],
    this.executionReady = true,
  });
  final String previewId;
  final OrderIntent intent;
  final DecimalValue orderValue;
  final DecimalValue? marketPrice;
  final DecimalValue? estimatedPrice;
  final DecimalValue? estimatedQuantity;
  final DecimalValue? estimatedReceive;
  final DecimalValue? fee;
  final DecimalValue? marginRequired;
  final DecimalValue? liquidationPrice;
  final String? settlementAsset;
  final String? settlementChain;
  final bool priceUpdated;
  final DateTime? expiresAt;
  final Hip3PreviewExecution? hip3Execution;
  final DecimalValue? feeRate;
  final String? feeNote;
  final List<PreviewDetail> details;
  final bool executionReady;
  bool get isExpired => expiresAt?.isBefore(DateTime.now().toUtc()) ?? false;
  bool get openingProtectionMatchesIntent {
    final requested = intent.openingProtection;
    final actual = hip3Execution?.openingProtection;
    if (requested == null) return actual == null;
    return actual != null &&
        hip3Execution != null &&
        actual.matches(requested, hip3Execution!.quantity);
  }
}

/// Frozen execution conditions, not a guarantee of fill price or liquidation.
final class Hip3PreviewExecution {
  const Hip3PreviewExecution({
    required this.contextId,
    required this.productId,
    required this.environment,
    required this.quantity,
    required this.type,
    required this.timeInForce,
    required this.limitPrice,
    required this.leverage,
    required this.marginMode,
    required this.reduceOnly,
    required this.notional,
    required this.marginRequired,
    required this.availableMargin,
    required this.maximumQuantity,
    required this.estimatedFee,
    required this.slippagePercent,
    this.liquidationPrice,
    this.liquidationPriceUnavailableReason,
    this.openingProtection,
    this.crossLiquidationImpacts = const [],
  });
  final String contextId;
  final String productId;
  final String environment;
  final DecimalValue quantity;
  final TradingOrderType type;
  final String timeInForce;
  final DecimalValue limitPrice;
  final DecimalValue leverage;
  final TradingMarginMode marginMode;
  final bool reduceOnly;
  final DecimalValue notional;
  final DecimalValue marginRequired;
  final DecimalValue availableMargin;
  final DecimalValue maximumQuantity;
  final DecimalValue estimatedFee;
  final DecimalValue slippagePercent;
  final DecimalValue? liquidationPrice;
  final String? liquidationPriceUnavailableReason;
  final Hip3OpeningProtectionConfirmation? openingProtection;
  final List<Hip3CrossLiquidationImpact> crossLiquidationImpacts;
}

final class Hip3CrossLiquidationImpact {
  const Hip3CrossLiquidationImpact({
    required this.productId,
    required this.side,
    this.beforeLiquidationPrice,
    this.afterLiquidationPrice,
    this.unavailableReason,
  });

  final String productId;
  final TradingSide side;
  final DecimalValue? beforeLiquidationPrice;
  final DecimalValue? afterLiquidationPrice;
  final String? unavailableReason;
}

final class PreviewDetail {
  const PreviewDetail(this.label, this.value, {this.tone});
  final String label;
  final String value;
  final String? tone;
}
