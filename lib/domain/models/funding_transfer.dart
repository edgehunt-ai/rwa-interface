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
    this.legs = const [],
    this.blocker,
  });

  final String planId;
  final String tradePreviewId;
  final DecimalValue shortfall;
  final FundingPlanState status;
  final String? sourceWalletId;
  final String? sourceAsset;
  final DecimalValue? sourceMaximum;
  final List<FundingLeg> legs;
  final String? blocker;

  bool get isActionable =>
      status == FundingPlanState.ready && nextActionableLeg != null;

  FundingLeg? get nextActionableLeg =>
      legs.where((leg) => leg.isActionable).firstOrNull;
}

final class FundingLeg {
  const FundingLeg({
    required this.legId,
    required this.walletId,
    required this.asset,
    required this.maximumAmount,
    required this.outputAmount,
    required this.status,
    this.transferId,
  });

  final String legId;
  final String walletId;
  final String asset;
  final DecimalValue maximumAmount;
  final DecimalValue outputAmount;
  final FundingLegState status;
  final String? transferId;

  bool get isActionable => status == FundingLegState.actionReleased;
}

enum FundingLegState {
  planned,
  actionReleased,
  submitted,
  completed,
  failed,
  ambiguous,
  manualReview,
  unknown,
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
