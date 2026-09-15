import 'decimal_value.dart';

enum SelfCustodialWithdrawalState {
  awaitingSubmission,
  submitted,
  confirming,
  confirmed,
  failed,
  noncanonical,
  manualReview,
  unknown,
}

final class SelfCustodialWithdrawalSummary {
  const SelfCustodialWithdrawalSummary({
    required this.withdrawalId,
    required this.assetSymbol,
    required this.amount,
    required this.destinationAddress,
    required this.status,
    this.txHash,
    this.failureReason,
    this.confirmations,
    this.requiredConfirmations = 0,
  });
  final String withdrawalId;
  final String assetSymbol;
  final DecimalValue amount;
  final String destinationAddress;
  final SelfCustodialWithdrawalState status;
  final String? txHash;
  final String? failureReason;
  final int? confirmations;
  final int requiredConfirmations;
}
