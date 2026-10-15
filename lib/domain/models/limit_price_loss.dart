enum LimitPriceLossDirection { aboveMarket, belowMarket }

final class LimitPriceLoss {
  const LimitPriceLoss({
    required this.direction,
    required this.deviationPercent,
    required this.estimatedLoss,
  });

  final LimitPriceLossDirection direction;
  final double deviationPercent;
  final double estimatedLoss;
}

LimitPriceLoss? assessLimitPriceLoss({
  required bool isBuy,
  required double limitPrice,
  required double marketPrice,
  required double quantity,
}) {
  if (!limitPrice.isFinite ||
      !marketPrice.isFinite ||
      !quantity.isFinite ||
      limitPrice <= 0 ||
      marketPrice <= 0 ||
      quantity < 0) {
    return null;
  }

  final adverseDifference = isBuy
      ? limitPrice - marketPrice
      : marketPrice - limitPrice;
  if (adverseDifference <= 0) return null;

  final deviationPercent = adverseDifference / marketPrice * 100;
  final estimatedLoss = adverseDifference * quantity;
  if (!deviationPercent.isFinite || !estimatedLoss.isFinite) return null;
  return LimitPriceLoss(
    direction: isBuy
        ? LimitPriceLossDirection.aboveMarket
        : LimitPriceLossDirection.belowMarket,
    deviationPercent: deviationPercent,
    estimatedLoss: estimatedLoss,
  );
}
