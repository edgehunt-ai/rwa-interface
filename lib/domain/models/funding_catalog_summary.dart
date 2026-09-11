final class FundingCatalogSummary {
  const FundingCatalogSummary({
    required this.catalogVersion,
    required this.depositRailCount,
    required this.updatedAt,
  });
  final String catalogVersion;
  final int depositRailCount;
  final DateTime updatedAt;
}
