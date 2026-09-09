import 'decimal_value.dart';

enum FundingRailKind { bstock, perp }

final class FundingRail {
  const FundingRail({
    required this.kind,
    required this.network,
    required this.settlementAsset,
    this.minimumAmount,
  });
  final FundingRailKind kind;
  final String network;
  final String settlementAsset;
  final DecimalValue? minimumAmount;
}

final class FundingCatalog {
  const FundingCatalog({required this.rails, required this.updatedAt});
  final List<FundingRail> rails;
  final DateTime updatedAt;
}
