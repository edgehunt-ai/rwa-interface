import 'decimal_value.dart';
import 'funding_session.dart';
import 'wallet_action_execution.dart';

/// A server-frozen route for covering the shortfall of an immutable trade preview.
final class FundingPlan {
  const FundingPlan({
    required this.planId,
    required this.tradePreviewId,
    required this.shortfall,
    required this.status,
    this.requiredTargetAmount,
    this.targetAvailableAmount,
    this.targetAsset,
    this.targetNetwork,
    this.targetEnvironment,
    this.sourceWalletId,
    this.sourceAsset,
    this.sourceMaximum,
    this.legs = const [],
    this.blocker,
    this.fundingSessionId,
    this.createdAt,
    this.expiresAt,
  });

  final String planId;
  final String tradePreviewId;
  final DecimalValue shortfall;
  final DecimalValue? requiredTargetAmount;
  final DecimalValue? targetAvailableAmount;
  final String? targetAsset;
  final String? targetNetwork;
  final String? targetEnvironment;
  final FundingPlanState status;
  final String? sourceWalletId;
  final String? sourceAsset;
  final DecimalValue? sourceMaximum;
  final List<FundingLeg> legs;
  final String? blocker;
  final String? fundingSessionId;
  final DateTime? createdAt;
  final DateTime? expiresAt;

  bool get shouldPoll =>
      (status == FundingPlanState.executing || isActionable ||
          ((status == FundingPlanState.ready ||
                  status == FundingPlanState.partiallyFunded) &&
              legs.any((leg) => leg.isInTransit))) &&
      !legs.any((leg) =>
          leg.status == FundingLegState.failed ||
          leg.status == FundingLegState.ambiguous ||
          leg.status == FundingLegState.manualReview);

  bool get isActionable =>
      status == FundingPlanState.ready && nextActionableLeg != null;

  bool get isExecuting =>
      status == FundingPlanState.executing ||
      status == FundingPlanState.partiallyFunded;

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
    this.sourcePositionId,
    this.network,
    this.etaSeconds,
    this.bridgeFee,
    this.networkFee,
    this.feeAsset,
    this.transferId,
    this.fees,
    this.refundAsset,
    this.targetEnvironment,
  });

  final String legId;
  final String walletId;
  final String asset;

  /// Account position ID used to match the live funding-account balance.
  final String? sourcePositionId;

  /// Network from the server-frozen source position snapshot.
  final String? network;

  final DecimalValue maximumAmount;
  final DecimalValue outputAmount;
  final FundingLegState status;
  final int? etaSeconds;
  final DecimalValue? bridgeFee;
  final DecimalValue? networkFee;
  final String? feeAsset;
  final String? transferId;
  final FundingSessionFees? fees;
  /// Exact route-frozen refund identity; never inferred from the source symbol.
  final Map<String, Object?>? refundAsset;
  final String? targetEnvironment;

  bool get isInTransit => switch (status) {
    FundingLegState.submitted ||
    FundingLegState.originConfirmed ||
    FundingLegState.providerConfirmed ||
    FundingLegState.targetConfirmed => true,
    _ => false,
  };

  bool get isActionable =>
      transferId == null &&
      (status == FundingLegState.planned ||
          status == FundingLegState.actionReleased);
}

enum FundingLegState {
  planned,
  actionReleased,
  submitted,
  originConfirmed,
  providerConfirmed,
  targetConfirmed,
  cancelledAsUnneeded,
  completed,
  failed,
  ambiguous,
  manualReview,
  unknown,
}

enum FundingPlanState {
  ready,
  executing,
  partiallyFunded,
  alreadyFunded,
  blocked,
  failed,
  expired,
  consumed,
  cancelled,
  manualReview,
  unknown,
}

final class FundingTransfer {
  const FundingTransfer({
    required this.transferId,
    required this.planId,
    required this.amount,
    required this.status,
    this.nextActionId,
    this.nextAction,
    this.failureReason,
    this.legId,
    this.activityId,
    this.sourceExecutionStatus,
    this.providerStatus,
    this.targetCreditStatus,
    this.refundStatus,
    this.recoveryStatus,
    this.sourceTransaction,
    this.providerObservation,
    this.targetCredit,
    this.targetReceivedAmount,
    this.targetEnvironment,
    this.refund,
    this.ambiguousReason,
    this.manualReviewReason,
    this.createdAt,
    this.updatedAt,
    this.completedAt,
    this.routeLockedAt,
    this.walletActionReleasedAt,
  });

  final String transferId;
  final String planId;
  final DecimalValue amount;
  final FundingTransferState status;
  final String? nextActionId;
  final FundingTransferAction? nextAction;
  final String? failureReason;
  final String? legId;
  final String? activityId;
  final String? sourceExecutionStatus;
  final String? providerStatus;
  final String? targetCreditStatus;
  final String? refundStatus;
  final String? recoveryStatus;
  // Preserve server evidence verbatim; balances never establish settlement.
  final Map<String, Object?>? sourceTransaction;
  final Map<String, Object?>? providerObservation;
  final Map<String, Object?>? targetCredit;
  /// Current distinct-event aggregate, not the latest credit or wallet balance.
  final DecimalValue? targetReceivedAmount;
  final String? targetEnvironment;
  final Map<String, Object?>? refund;
  final String? ambiguousReason;
  final String? manualReviewReason;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? completedAt;
  final DateTime? routeLockedAt;
  final DateTime? walletActionReleasedAt;

  bool get canExecuteNextAction =>
      nextActionId != null &&
      (status == FundingTransferState.awaitingAuthorization ||
          status == FundingTransferState.awaitingWallet ||
          status == FundingTransferState.originConfirmed ||
          status == FundingTransferState.filling) &&
      recoveryStatus != 'manualReview' &&
      recoveryStatus != 'ambiguous';

  bool get isCompleted => status == FundingTransferState.completed;

  String? get reason => manualReviewReason ?? ambiguousReason ?? failureReason;
}

/// The server-released call and gas choice; never inferred from transfer status.
final class FundingTransferAction {
  const FundingTransferAction({
    required this.actionId,
    required this.status,
    required this.mode,
    required this.chainId,
    required this.from,
    required this.transaction,
    required this.validUntil,
  });

  final String actionId;
  final String status;
  final GasPaymentMode? mode;
  final int chainId;
  final String from;
  final FrozenTransaction transaction;
  final DateTime validUntil;
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
