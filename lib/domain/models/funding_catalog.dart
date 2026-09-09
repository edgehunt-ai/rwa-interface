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

final class DepositRoute {
  const DepositRoute({
    required this.chain,
    required this.token,
    required this.minimumAmount,
    required this.confirmationsRequired,
    this.isRecommended = false,
  });

  final String chain;
  final String token;
  final DecimalValue minimumAmount;
  final int confirmationsRequired;
  final bool isRecommended;
}

final class FundingCatalog {
  const FundingCatalog({
    required this.rails,
    this.depositRoutes = const [],
    required this.updatedAt,
  });

  final List<FundingRail> rails;
  final List<DepositRoute> depositRoutes;
  final DateTime updatedAt;
}
