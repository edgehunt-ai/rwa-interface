import 'decimal_value.dart';
import 'deposit.dart';

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

final class DepositDirectory {
  const DepositDirectory({
    required this.instructions,
    required this.updatedAt,
    this.walletAddress,
  });

  final String? walletAddress;
  final List<DepositInstruction> instructions;
  final DateTime updatedAt;
}

final class UnifiedFundingAccountSummary {
  const UnifiedFundingAccountSummary({
    required this.totalUsd,
    required this.availableToFundUsd,
    required this.reservedUsd,
    required this.inTransitUsd,
    required this.dataStatus,
    required this.calculatedAt,
  });

  final DecimalValue totalUsd;
  final DecimalValue availableToFundUsd;
  final DecimalValue reservedUsd;
  final DecimalValue inTransitUsd;
  final String dataStatus;
  final DateTime calculatedAt;
}
