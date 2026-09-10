import 'decimal_value.dart';
import 'order_intent.dart';

final class Hip3OpeningContext {
  const Hip3OpeningContext({
    required this.contextId,
    required this.productId,
    required this.environment,
    required this.currentLeverage,
    required this.maximumLeverage,
    required this.currentMarginMode,
    required this.marginModes,
    required this.orderTypes,
    required this.timeInForce,
    required this.availableMargin,
    required this.minimumNotional,
    required this.maximumNotional,
    required this.sizeDecimals,
    required this.validUntil,
    required this.operations,
    this.blocker,
    this.venue,
    this.settlementAsset,
  });
  final String contextId;
  final String productId;
  final String environment;
  final String? venue, settlementAsset;
  final int? currentLeverage;
  final int maximumLeverage;
  final TradingMarginMode? currentMarginMode;
  final Set<TradingMarginMode> marginModes;
  final Set<TradingOrderType> orderTypes;
  final Set<String> timeInForce;
  final DecimalValue availableMargin;
  final DecimalValue minimumNotional;
  final DecimalValue? maximumNotional;
  final int sizeDecimals;
  final DateTime validUntil;
  final Set<String> operations;
  final String? blocker;
  bool get isExpired => !validUntil.isAfter(DateTime.now().toUtc());
}
