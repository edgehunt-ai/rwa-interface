import 'decimal_value.dart';

/// A server-frozen route for covering the shortfall of an immutable trade preview.
final class FundingPlan {
  const FundingPlan({
    required this.planId,
    required this.tradePreviewId,
    required this.shortfall,
    required this.status,
    this.sourceWalletId,
    this.sourceAsset,
    this.sourceMaximum,
    this.blocker,
  });

  final String planId;
  final String tradePreviewId;
  final DecimalValue shortfall;
  final FundingPlanState status;
  final String? sourceWalletId;
  final String? sourceAsset;
  final DecimalValue? sourceMaximum;
  final String? blocker;

  bool get isActionable =>
      status == FundingPlanState.ready && sourceWalletId != null;
}

enum FundingPlanState {
  ready,
  alreadyFunded,
  blocked,
  expired,
  consumed,
  cancelled,
  unknown,
}

final class FundingTransfer {
  const FundingTransfer({
    required this.transferId,
    required this.planId,
    required this.amount,
    required this.status,
    this.failureReason,
  });

  final String transferId;
  final String planId;
  final DecimalValue amount;
  final FundingTransferState status;
  final String? failureReason;
}

enum FundingTransferState {
  awaitingAuthorization,
  awaitingWallet,
  originSubmitted,
  originConfirmed,
  filling,
  completed,
  refundPending,
  refunded,
  failed,
  ambiguous,
  manualReview,
  unknown,
}
