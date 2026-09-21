import 'decimal_value.dart';

final class PortfolioRailAllocation {
  const PortfolioRailAllocation({
    required this.items,
    required this.valuedTotalUsd,
    required this.unvaluedAssetCount,
  });

  final List<PortfolioRailAllocationItem> items;
  final DecimalValue valuedTotalUsd;
  final int unvaluedAssetCount;
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
