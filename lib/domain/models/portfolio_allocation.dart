import 'decimal_value.dart';

final class PortfolioRailAllocation {
  const PortfolioRailAllocation({
    required this.items,
    required this.valuedTotalUsd,
    required this.unvaluedAssetCount,
    this.spot,
    this.perps,
    this.hasCompleteValuation = true,
  });

  final bool hasCompleteValuation;
  final List<PortfolioRailAllocationItem> items;
  final DecimalValue valuedTotalUsd;
  final int unvaluedAssetCount;
  final PortfolioAccountAllocation? spot;
  final PortfolioAccountAllocation? perps;
}

final class PortfolioAccountAllocation {
  const PortfolioAccountAllocation({
    required this.valueUsd,
    required this.percent,
    this.perpsBreakdown,
  });

  final DecimalValue valueUsd;
  final DecimalValue? percent;
  final PortfolioPerpsAllocationBreakdown? perpsBreakdown;
}

final class PortfolioPerpsAllocationBreakdown {
  const PortfolioPerpsAllocationBreakdown({
    this.crossMargin,
    this.crossMarginPool,
    this.crossMarginPoolQuantity,
    this.isolatedMargin,
    this.openOrderMargin,
    this.estimatedWithdrawable,
    this.crossLiquidationRisk,
  });

  /// Position margin already used; distinct from the asset page pool.
  final PortfolioAllocationAmount? crossMargin;
  final PortfolioAllocationAmount? crossMarginPool;
  final DecimalValue? crossMarginPoolQuantity;
  final PortfolioAllocationAmount? isolatedMargin;
  final PortfolioAllocationAmount? openOrderMargin;
  final PortfolioAllocationAmount? estimatedWithdrawable;
  final PortfolioCrossLiquidationRisk? crossLiquidationRisk;
}

final class PortfolioAllocationAmount {
  const PortfolioAllocationAmount({
    required this.valueUsd,
    required this.percent,
  });

  final DecimalValue valueUsd;
  final DecimalValue percent;
}

enum PortfolioLiquidationRiskLevel {
  safe,
  liquidationRisk,
  highLiquidationRisk,
  unavailable,
}

final class PortfolioCrossLiquidationRisk {
  const PortfolioCrossLiquidationRisk({
    required this.level,
    this.closestDistancePercent,
    this.crossPositionCount,
  });

  final PortfolioLiquidationRiskLevel level;
  final DecimalValue? closestDistancePercent;
  final int? crossPositionCount;
}

final class PortfolioRailAllocationItem {
  const PortfolioRailAllocationItem({
    required this.rail,
    required this.valueUsd,
    required this.percent,
  });

  final String rail;
  final DecimalValue valueUsd;
  final DecimalValue percent;
}
