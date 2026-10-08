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
    this.marketOrderMinimumLong,
    this.marketOrderMinimumShort,
    required this.maximumNotional,
    required this.sizeDecimals,
    required this.validUntil,
    required this.operations,
    this.orderCapacity,
    this.takerFeeRate,
    this.feeReserveMultiplier,
    this.blocker,
  });
  final String contextId;
  final String productId;
  final String environment;
  final int? currentLeverage;
  final int maximumLeverage;
  final TradingMarginMode? currentMarginMode;
  final Set<TradingMarginMode> marginModes;
  final Set<TradingOrderType> orderTypes;
  final Set<String> timeInForce;
  final DecimalValue availableMargin;
  final DecimalValue minimumNotional;
  final DecimalValue? marketOrderMinimumLong;
  final DecimalValue? marketOrderMinimumShort;
  final DecimalValue? maximumNotional;
  final int sizeDecimals;
  final DateTime validUntil;
  final Set<String> operations;
  final Hip3OpeningOrderCapacity? orderCapacity;
  final DecimalValue? takerFeeRate;
  final DecimalValue? feeReserveMultiplier;
  final String? blocker;

  bool get tradingSettingsEnabled =>
      availableMargin.compareMagnitudeTo(
        DecimalValue('0', asset: availableMargin.asset),
      ) >
      0;

  bool get isExpired => !validUntil.isAfter(DateTime.now().toUtc());
}

final class Hip3OpeningOrderCapacity {
  const Hip3OpeningOrderCapacity({required this.long, required this.short});

  final Hip3OpeningDirectionalCapacity long;
  final Hip3OpeningDirectionalCapacity short;

  Hip3OpeningDirectionalCapacity? forSide(TradingSide side) => switch (side) {
    TradingSide.long => long,
    TradingSide.short => short,
    _ => null,
  };
}

final class Hip3OpeningDirectionalCapacity {
  const Hip3OpeningDirectionalCapacity({
    required this.availableMargin,
    required this.venueMaximumQuantity,
  });

  final DecimalValue availableMargin;
  final DecimalValue venueMaximumQuantity;
}
