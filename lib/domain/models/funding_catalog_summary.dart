final class FundingCatalogSummary {
  const FundingCatalogSummary({
    required this.catalogVersion,
    required this.depositRailCount,
    required this.updatedAt,
    this.transferTarget,
  });
  final String catalogVersion;
  final int depositRailCount;
  final DateTime updatedAt;
  final FundingTransferTarget? transferTarget;
}

final class FundingTransferTarget {
  const FundingTransferTarget({required this.token, required this.network});
  final String token;
  final String network;
}
