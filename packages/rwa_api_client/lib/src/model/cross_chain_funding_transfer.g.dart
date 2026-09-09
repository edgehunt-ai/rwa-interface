// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cross_chain_funding_transfer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CrossChainFundingTransfer extends CrossChainFundingTransfer {
  @override
  final TransferStatus status;
  @override
  final TransferSourceExecutionStatus sourceExecutionStatus;
  @override
  final TransferProviderStatus providerStatus;
  @override
  final JsonObject? providerObservation;
  @override
  final TransferTargetCreditStatus targetCreditStatus;
  @override
  final JsonObject? sourceTransaction;
  @override
  final JsonObject? targetCredit;
  @override
  final TransferRecoveryStatus recoveryStatus;
  @override
  final DateTime? completedAt;
  @override
  final JsonObject? nextAction;
  @override
  final ProductKind rail;
  @override
  final FundingTargetBalanceSnapshot target;
  @override
  final DateTime? routeLockedAt;
  @override
  final DateTime? walletActionReleasedAt;
  @override
  final String transferId;
  @override
  final String planId;
  @override
  final String amount;
  @override
  final FundingSourceBalanceSnapshot source_;
  @override
  final FundingProvider provider;
  @override
  final TransferRefundStatus refundStatus;
  @override
  final JsonObject? refund;
  @override
  final String? failureReason;
  @override
  final String? ambiguousReason;
  @override
  final String? manualReviewReason;
  @override
  final String? activityId;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$CrossChainFundingTransfer(
          [void Function(CrossChainFundingTransferBuilder)? updates]) =>
      (CrossChainFundingTransferBuilder()..update(updates))._build();

  _$CrossChainFundingTransfer._(
      {required this.status,
      required this.sourceExecutionStatus,
      required this.providerStatus,
      this.providerObservation,
      required this.targetCreditStatus,
      this.sourceTransaction,
      this.targetCredit,
      required this.recoveryStatus,
      this.completedAt,
      this.nextAction,
      required this.rail,
      required this.target,
      this.routeLockedAt,
      this.walletActionReleasedAt,
      required this.transferId,
      required this.planId,
      required this.amount,
      required this.source_,
      required this.provider,
      required this.refundStatus,
      this.refund,
      this.failureReason,
      this.ambiguousReason,
      this.manualReviewReason,
      this.activityId,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  CrossChainFundingTransfer rebuild(
          void Function(CrossChainFundingTransferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CrossChainFundingTransferBuilder toBuilder() =>
      CrossChainFundingTransferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CrossChainFundingTransfer &&
        status == other.status &&
        sourceExecutionStatus == other.sourceExecutionStatus &&
        providerStatus == other.providerStatus &&
        providerObservation == other.providerObservation &&
        targetCreditStatus == other.targetCreditStatus &&
        sourceTransaction == other.sourceTransaction &&
        targetCredit == other.targetCredit &&
        recoveryStatus == other.recoveryStatus &&
        completedAt == other.completedAt &&
        nextAction == other.nextAction &&
        rail == other.rail &&
        target == other.target &&
        routeLockedAt == other.routeLockedAt &&
        walletActionReleasedAt == other.walletActionReleasedAt &&
        transferId == other.transferId &&
        planId == other.planId &&
        amount == other.amount &&
        source_ == other.source_ &&
        provider == other.provider &&
        refundStatus == other.refundStatus &&
        refund == other.refund &&
        failureReason == other.failureReason &&
        ambiguousReason == other.ambiguousReason &&
        manualReviewReason == other.manualReviewReason &&
        activityId == other.activityId &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, sourceExecutionStatus.hashCode);
    _$hash = $jc(_$hash, providerStatus.hashCode);
    _$hash = $jc(_$hash, providerObservation.hashCode);
    _$hash = $jc(_$hash, targetCreditStatus.hashCode);
    _$hash = $jc(_$hash, sourceTransaction.hashCode);
    _$hash = $jc(_$hash, targetCredit.hashCode);
    _$hash = $jc(_$hash, recoveryStatus.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jc(_$hash, nextAction.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, target.hashCode);
    _$hash = $jc(_$hash, routeLockedAt.hashCode);
    _$hash = $jc(_$hash, walletActionReleasedAt.hashCode);
    _$hash = $jc(_$hash, transferId.hashCode);
    _$hash = $jc(_$hash, planId.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, provider.hashCode);
    _$hash = $jc(_$hash, refundStatus.hashCode);
    _$hash = $jc(_$hash, refund.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, ambiguousReason.hashCode);
    _$hash = $jc(_$hash, manualReviewReason.hashCode);
    _$hash = $jc(_$hash, activityId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CrossChainFundingTransfer')
          ..add('status', status)
          ..add('sourceExecutionStatus', sourceExecutionStatus)
          ..add('providerStatus', providerStatus)
          ..add('providerObservation', providerObservation)
          ..add('targetCreditStatus', targetCreditStatus)
          ..add('sourceTransaction', sourceTransaction)
          ..add('targetCredit', targetCredit)
          ..add('recoveryStatus', recoveryStatus)
          ..add('completedAt', completedAt)
          ..add('nextAction', nextAction)
          ..add('rail', rail)
          ..add('target', target)
          ..add('routeLockedAt', routeLockedAt)
          ..add('walletActionReleasedAt', walletActionReleasedAt)
          ..add('transferId', transferId)
          ..add('planId', planId)
          ..add('amount', amount)
          ..add('source_', source_)
          ..add('provider', provider)
          ..add('refundStatus', refundStatus)
          ..add('refund', refund)
          ..add('failureReason', failureReason)
          ..add('ambiguousReason', ambiguousReason)
          ..add('manualReviewReason', manualReviewReason)
          ..add('activityId', activityId)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class CrossChainFundingTransferBuilder
    implements
        Builder<CrossChainFundingTransfer, CrossChainFundingTransferBuilder> {
  _$CrossChainFundingTransfer? _$v;

  TransferStatus? _status;
  TransferStatus? get status => _$this._status;
  set status(TransferStatus? status) => _$this._status = status;

  TransferSourceExecutionStatus? _sourceExecutionStatus;
  TransferSourceExecutionStatus? get sourceExecutionStatus =>
      _$this._sourceExecutionStatus;
  set sourceExecutionStatus(
          TransferSourceExecutionStatus? sourceExecutionStatus) =>
      _$this._sourceExecutionStatus = sourceExecutionStatus;

  TransferProviderStatus? _providerStatus;
  TransferProviderStatus? get providerStatus => _$this._providerStatus;
  set providerStatus(TransferProviderStatus? providerStatus) =>
      _$this._providerStatus = providerStatus;

  JsonObject? _providerObservation;
  JsonObject? get providerObservation => _$this._providerObservation;
  set providerObservation(JsonObject? providerObservation) =>
      _$this._providerObservation = providerObservation;

  TransferTargetCreditStatus? _targetCreditStatus;
  TransferTargetCreditStatus? get targetCreditStatus =>
      _$this._targetCreditStatus;
  set targetCreditStatus(TransferTargetCreditStatus? targetCreditStatus) =>
      _$this._targetCreditStatus = targetCreditStatus;

  JsonObject? _sourceTransaction;
  JsonObject? get sourceTransaction => _$this._sourceTransaction;
  set sourceTransaction(JsonObject? sourceTransaction) =>
      _$this._sourceTransaction = sourceTransaction;

  JsonObject? _targetCredit;
  JsonObject? get targetCredit => _$this._targetCredit;
  set targetCredit(JsonObject? targetCredit) =>
      _$this._targetCredit = targetCredit;

  TransferRecoveryStatus? _recoveryStatus;
  TransferRecoveryStatus? get recoveryStatus => _$this._recoveryStatus;
  set recoveryStatus(TransferRecoveryStatus? recoveryStatus) =>
      _$this._recoveryStatus = recoveryStatus;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  JsonObject? _nextAction;
  JsonObject? get nextAction => _$this._nextAction;
  set nextAction(JsonObject? nextAction) => _$this._nextAction = nextAction;

  ProductKind? _rail;
  ProductKind? get rail => _$this._rail;
  set rail(ProductKind? rail) => _$this._rail = rail;

  FundingTargetBalanceSnapshotBuilder? _target;
  FundingTargetBalanceSnapshotBuilder get target =>
      _$this._target ??= FundingTargetBalanceSnapshotBuilder();
  set target(FundingTargetBalanceSnapshotBuilder? target) =>
      _$this._target = target;

  DateTime? _routeLockedAt;
  DateTime? get routeLockedAt => _$this._routeLockedAt;
  set routeLockedAt(DateTime? routeLockedAt) =>
      _$this._routeLockedAt = routeLockedAt;

  DateTime? _walletActionReleasedAt;
  DateTime? get walletActionReleasedAt => _$this._walletActionReleasedAt;
  set walletActionReleasedAt(DateTime? walletActionReleasedAt) =>
      _$this._walletActionReleasedAt = walletActionReleasedAt;

  String? _transferId;
  String? get transferId => _$this._transferId;
  set transferId(String? transferId) => _$this._transferId = transferId;

  String? _planId;
  String? get planId => _$this._planId;
  set planId(String? planId) => _$this._planId = planId;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  FundingSourceBalanceSnapshotBuilder? _source_;
  FundingSourceBalanceSnapshotBuilder get source_ =>
      _$this._source_ ??= FundingSourceBalanceSnapshotBuilder();
  set source_(FundingSourceBalanceSnapshotBuilder? source_) =>
      _$this._source_ = source_;

  FundingProvider? _provider;
  FundingProvider? get provider => _$this._provider;
  set provider(FundingProvider? provider) => _$this._provider = provider;

  TransferRefundStatus? _refundStatus;
  TransferRefundStatus? get refundStatus => _$this._refundStatus;
  set refundStatus(TransferRefundStatus? refundStatus) =>
      _$this._refundStatus = refundStatus;

  JsonObject? _refund;
  JsonObject? get refund => _$this._refund;
  set refund(JsonObject? refund) => _$this._refund = refund;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  String? _ambiguousReason;
  String? get ambiguousReason => _$this._ambiguousReason;
  set ambiguousReason(String? ambiguousReason) =>
      _$this._ambiguousReason = ambiguousReason;

  String? _manualReviewReason;
  String? get manualReviewReason => _$this._manualReviewReason;
  set manualReviewReason(String? manualReviewReason) =>
      _$this._manualReviewReason = manualReviewReason;

  String? _activityId;
  String? get activityId => _$this._activityId;
  set activityId(String? activityId) => _$this._activityId = activityId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  CrossChainFundingTransferBuilder() {
    CrossChainFundingTransfer._defaults(this);
  }

  CrossChainFundingTransferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _sourceExecutionStatus = $v.sourceExecutionStatus;
      _providerStatus = $v.providerStatus;
      _providerObservation = $v.providerObservation;
      _targetCreditStatus = $v.targetCreditStatus;
      _sourceTransaction = $v.sourceTransaction;
      _targetCredit = $v.targetCredit;
      _recoveryStatus = $v.recoveryStatus;
      _completedAt = $v.completedAt;
      _nextAction = $v.nextAction;
      _rail = $v.rail;
      _target = $v.target.toBuilder();
      _routeLockedAt = $v.routeLockedAt;
      _walletActionReleasedAt = $v.walletActionReleasedAt;
      _transferId = $v.transferId;
      _planId = $v.planId;
      _amount = $v.amount;
      _source_ = $v.source_.toBuilder();
      _provider = $v.provider;
      _refundStatus = $v.refundStatus;
      _refund = $v.refund;
      _failureReason = $v.failureReason;
      _ambiguousReason = $v.ambiguousReason;
      _manualReviewReason = $v.manualReviewReason;
      _activityId = $v.activityId;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CrossChainFundingTransfer other) {
    _$v = other as _$CrossChainFundingTransfer;
  }

  @override
  void update(void Function(CrossChainFundingTransferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CrossChainFundingTransfer build() => _build();

  _$CrossChainFundingTransfer _build() {
    _$CrossChainFundingTransfer _$result;
    try {
      _$result = _$v ??
          _$CrossChainFundingTransfer._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'CrossChainFundingTransfer', 'status'),
            sourceExecutionStatus: BuiltValueNullFieldError.checkNotNull(
                sourceExecutionStatus,
                r'CrossChainFundingTransfer',
                'sourceExecutionStatus'),
            providerStatus: BuiltValueNullFieldError.checkNotNull(
                providerStatus, r'CrossChainFundingTransfer', 'providerStatus'),
            providerObservation: providerObservation,
            targetCreditStatus: BuiltValueNullFieldError.checkNotNull(
                targetCreditStatus,
                r'CrossChainFundingTransfer',
                'targetCreditStatus'),
            sourceTransaction: sourceTransaction,
            targetCredit: targetCredit,
            recoveryStatus: BuiltValueNullFieldError.checkNotNull(
                recoveryStatus, r'CrossChainFundingTransfer', 'recoveryStatus'),
            completedAt: completedAt,
            nextAction: nextAction,
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'CrossChainFundingTransfer', 'rail'),
            target: target.build(),
            routeLockedAt: routeLockedAt,
            walletActionReleasedAt: walletActionReleasedAt,
            transferId: BuiltValueNullFieldError.checkNotNull(
                transferId, r'CrossChainFundingTransfer', 'transferId'),
            planId: BuiltValueNullFieldError.checkNotNull(
                planId, r'CrossChainFundingTransfer', 'planId'),
            amount: BuiltValueNullFieldError.checkNotNull(
                amount, r'CrossChainFundingTransfer', 'amount'),
            source_: source_.build(),
            provider: BuiltValueNullFieldError.checkNotNull(
                provider, r'CrossChainFundingTransfer', 'provider'),
            refundStatus: BuiltValueNullFieldError.checkNotNull(
                refundStatus, r'CrossChainFundingTransfer', 'refundStatus'),
            refund: refund,
            failureReason: failureReason,
            ambiguousReason: ambiguousReason,
            manualReviewReason: manualReviewReason,
            activityId: activityId,
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'CrossChainFundingTransfer', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'CrossChainFundingTransfer', 'updatedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'target';
        target.build();

        _$failedField = 'source_';
        source_.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CrossChainFundingTransfer', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
