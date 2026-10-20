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
    this.sourceWalletId,
    this.assetId,
    this.walletActionExecutionId,
    this.userOperationHash,
    this.manualReviewReason,
    this.createdAt,
    this.updatedAt,
    this.submittedAt,
    this.confirmedAt,
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
  final String? sourceWalletId;
  final String? assetId;
  final String? walletActionExecutionId;
  final String? userOperationHash;
  final String? manualReviewReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? submittedAt;
  final DateTime? confirmedAt;

  bool get isCompleted => status == SelfCustodialWithdrawalState.confirmed &&
      manualReviewReason == null;

  bool get shouldPoll => manualReviewReason == null &&
      (status == SelfCustodialWithdrawalState.submitted ||
       status == SelfCustodialWithdrawalState.confirming);
}
