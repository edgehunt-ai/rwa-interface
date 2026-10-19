import 'decimal_value.dart';
import 'funding_catalog.dart';
import 'order_preview.dart';

final class FundingSessionSummary {
  const FundingSessionSummary({
    required this.sessionId,
    required this.status,
    required this.version,
    required this.canConfirmTransfer,
    required this.expiresAt,
    this.requiredTargetBalance,
    this.targetAvailableAmount,
    this.remainingMinimumTopUp,
    this.selectedTargetAmount,
    this.estimatedReceived,
    this.minimumReceived,
    this.slippageBps,
    this.fees,
    this.etaSeconds,
    this.targetToken,
    this.targetNetwork,
    this.allocations = const {},
    this.positions = const [],
    this.crossLiquidationImpacts = const [],
  });
  final String sessionId;
  final String status;
  final int version;
  final bool canConfirmTransfer;
  final DateTime expiresAt;
  final String? requiredTargetBalance;
  final String? targetAvailableAmount;
  final String? remainingMinimumTopUp;
  final String? selectedTargetAmount;
  final String? estimatedReceived;
  final String? minimumReceived;
  final int? slippageBps;
  final FundingSessionFees? fees;
  final int? etaSeconds;
  final String? targetToken;
  final String? targetNetwork;
  final Map<String, String> allocations;
  final List<FundingSourcePosition> positions;
  final List<Hip3CrossLiquidationImpact> crossLiquidationImpacts;
}

final class FundingSessionFees {
  const FundingSessionFees({
    required this.asset,
    required this.providerFee,
    required this.bridgeFee,
    required this.swapFee,
    required this.networkFee,
    required this.totalFee,
    required this.totalCostUsd,
  });

  final String asset;
  final String providerFee;
  final String bridgeFee;
  final String swapFee;
  final String networkFee;
  final String totalFee;
  final String totalCostUsd;

  /// Combined route costs, excluding the separately displayed network fee.
  String get crossChainFee => DecimalValue(providerFee, asset: asset)
      .plus(DecimalValue(bridgeFee, asset: asset))
      .plus(DecimalValue(swapFee, asset: asset))
      .value;
}
