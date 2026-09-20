// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_session.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSession extends FundingSession {
  @override
  final String fundingSessionId;
  @override
  final FundingSessionStatus status;
  @override
  final int version;
  @override
  final OrderPreviewRequest trade;
  @override
  final FundingSessionContinuation continuation;
  @override
  final ProductKind rail;
  @override
  final FundingTargetBalanceSnapshot targetSnapshot;
  @override
  final String requiredTargetBalance;
  @override
  final String minimumTopUp;
  @override
  final String recommendedTopUp;
  @override
  final int safetyBufferBps;
  @override
  final String selectedTargetAmount;
  @override
  final String minimumReceived;
  @override
  final String maximumSelectableTargetAmount;
  @override
  final String totalSourceValueUsd;
  @override
  final FundingFeeBreakdown estimatedFees;
  @override
  final int etaSeconds;
  @override
  final BuiltList<UnifiedFundingPosition> positions;
  @override
  final BuiltList<FundingSessionSourceAllocation> allocations;
  @override
  final bool canConfirmTransfer;
  @override
  final String remainingMinimumTopUp;
  @override
  final DateTime estimateObservedAt;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime expiresAt;

  factory _$FundingSession([void Function(FundingSessionBuilder)? updates]) =>
      (FundingSessionBuilder()..update(updates))._build();

  _$FundingSession._(
      {required this.fundingSessionId,
      required this.status,
      required this.version,
      required this.trade,
      required this.continuation,
      required this.rail,
      required this.targetSnapshot,
      required this.requiredTargetBalance,
      required this.minimumTopUp,
      required this.recommendedTopUp,
      required this.safetyBufferBps,
      required this.selectedTargetAmount,
      required this.minimumReceived,
      required this.maximumSelectableTargetAmount,
      required this.totalSourceValueUsd,
      required this.estimatedFees,
      required this.etaSeconds,
      required this.positions,
      required this.allocations,
      required this.canConfirmTransfer,
      required this.remainingMinimumTopUp,
      required this.estimateObservedAt,
      required this.createdAt,
      required this.updatedAt,
      required this.expiresAt})
      : super._();
  @override
  FundingSession rebuild(void Function(FundingSessionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSessionBuilder toBuilder() => FundingSessionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSession &&
        fundingSessionId == other.fundingSessionId &&
        status == other.status &&
        version == other.version &&
        trade == other.trade &&
        continuation == other.continuation &&
        rail == other.rail &&
        targetSnapshot == other.targetSnapshot &&
        requiredTargetBalance == other.requiredTargetBalance &&
        minimumTopUp == other.minimumTopUp &&
        recommendedTopUp == other.recommendedTopUp &&
        safetyBufferBps == other.safetyBufferBps &&
        selectedTargetAmount == other.selectedTargetAmount &&
        minimumReceived == other.minimumReceived &&
        maximumSelectableTargetAmount == other.maximumSelectableTargetAmount &&
        totalSourceValueUsd == other.totalSourceValueUsd &&
        estimatedFees == other.estimatedFees &&
        etaSeconds == other.etaSeconds &&
        positions == other.positions &&
        allocations == other.allocations &&
        canConfirmTransfer == other.canConfirmTransfer &&
        remainingMinimumTopUp == other.remainingMinimumTopUp &&
        estimateObservedAt == other.estimateObservedAt &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, fundingSessionId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, trade.hashCode);
    _$hash = $jc(_$hash, continuation.hashCode);
    _$hash = $jc(_$hash, rail.hashCode);
    _$hash = $jc(_$hash, targetSnapshot.hashCode);
    _$hash = $jc(_$hash, requiredTargetBalance.hashCode);
    _$hash = $jc(_$hash, minimumTopUp.hashCode);
    _$hash = $jc(_$hash, recommendedTopUp.hashCode);
    _$hash = $jc(_$hash, safetyBufferBps.hashCode);
    _$hash = $jc(_$hash, selectedTargetAmount.hashCode);
    _$hash = $jc(_$hash, minimumReceived.hashCode);
    _$hash = $jc(_$hash, maximumSelectableTargetAmount.hashCode);
    _$hash = $jc(_$hash, totalSourceValueUsd.hashCode);
    _$hash = $jc(_$hash, estimatedFees.hashCode);
    _$hash = $jc(_$hash, etaSeconds.hashCode);
    _$hash = $jc(_$hash, positions.hashCode);
    _$hash = $jc(_$hash, allocations.hashCode);
    _$hash = $jc(_$hash, canConfirmTransfer.hashCode);
    _$hash = $jc(_$hash, remainingMinimumTopUp.hashCode);
    _$hash = $jc(_$hash, estimateObservedAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSession')
          ..add('fundingSessionId', fundingSessionId)
          ..add('status', status)
          ..add('version', version)
          ..add('trade', trade)
          ..add('continuation', continuation)
          ..add('rail', rail)
          ..add('targetSnapshot', targetSnapshot)
          ..add('requiredTargetBalance', requiredTargetBalance)
          ..add('minimumTopUp', minimumTopUp)
          ..add('recommendedTopUp', recommendedTopUp)
          ..add('safetyBufferBps', safetyBufferBps)
          ..add('selectedTargetAmount', selectedTargetAmount)
          ..add('minimumReceived', minimumReceived)
          ..add('maximumSelectableTargetAmount', maximumSelectableTargetAmount)
          ..add('totalSourceValueUsd', totalSourceValueUsd)
          ..add('estimatedFees', estimatedFees)
          ..add('etaSeconds', etaSeconds)
          ..add('positions', positions)
          ..add('allocations', allocations)
          ..add('canConfirmTransfer', canConfirmTransfer)
          ..add('remainingMinimumTopUp', remainingMinimumTopUp)
          ..add('estimateObservedAt', estimateObservedAt)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class FundingSessionBuilder
    implements Builder<FundingSession, FundingSessionBuilder> {
  _$FundingSession? _$v;

  String? _fundingSessionId;
  String? get fundingSessionId => _$this._fundingSessionId;
  set fundingSessionId(String? fundingSessionId) =>
      _$this._fundingSessionId = fundingSessionId;

  FundingSessionStatus? _status;
  FundingSessionStatus? get status => _$this._status;
  set status(FundingSessionStatus? status) => _$this._status = status;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  OrderPreviewRequestBuilder? _trade;
  OrderPreviewRequestBuilder get trade =>
      _$this._trade ??= OrderPreviewRequestBuilder();
  set trade(OrderPreviewRequestBuilder? trade) => _$this._trade = trade;

  FundingSessionContinuationBuilder? _continuation;
  FundingSessionContinuationBuilder get continuation =>
      _$this._continuation ??= FundingSessionContinuationBuilder();
  set continuation(FundingSessionContinuationBuilder? continuation) =>
      _$this._continuation = continuation;

  ProductKind? _rail;
  ProductKind? get rail => _$this._rail;
  set rail(ProductKind? rail) => _$this._rail = rail;

  FundingTargetBalanceSnapshotBuilder? _targetSnapshot;
  FundingTargetBalanceSnapshotBuilder get targetSnapshot =>
      _$this._targetSnapshot ??= FundingTargetBalanceSnapshotBuilder();
  set targetSnapshot(FundingTargetBalanceSnapshotBuilder? targetSnapshot) =>
      _$this._targetSnapshot = targetSnapshot;

  String? _requiredTargetBalance;
  String? get requiredTargetBalance => _$this._requiredTargetBalance;
  set requiredTargetBalance(String? requiredTargetBalance) =>
      _$this._requiredTargetBalance = requiredTargetBalance;

  String? _minimumTopUp;
  String? get minimumTopUp => _$this._minimumTopUp;
  set minimumTopUp(String? minimumTopUp) => _$this._minimumTopUp = minimumTopUp;

  String? _recommendedTopUp;
  String? get recommendedTopUp => _$this._recommendedTopUp;
  set recommendedTopUp(String? recommendedTopUp) =>
      _$this._recommendedTopUp = recommendedTopUp;

  int? _safetyBufferBps;
  int? get safetyBufferBps => _$this._safetyBufferBps;
  set safetyBufferBps(int? safetyBufferBps) =>
      _$this._safetyBufferBps = safetyBufferBps;

  String? _selectedTargetAmount;
  String? get selectedTargetAmount => _$this._selectedTargetAmount;
  set selectedTargetAmount(String? selectedTargetAmount) =>
      _$this._selectedTargetAmount = selectedTargetAmount;

  String? _minimumReceived;
  String? get minimumReceived => _$this._minimumReceived;
  set minimumReceived(String? minimumReceived) =>
      _$this._minimumReceived = minimumReceived;

  String? _maximumSelectableTargetAmount;
  String? get maximumSelectableTargetAmount =>
      _$this._maximumSelectableTargetAmount;
  set maximumSelectableTargetAmount(String? maximumSelectableTargetAmount) =>
      _$this._maximumSelectableTargetAmount = maximumSelectableTargetAmount;

  String? _totalSourceValueUsd;
  String? get totalSourceValueUsd => _$this._totalSourceValueUsd;
  set totalSourceValueUsd(String? totalSourceValueUsd) =>
      _$this._totalSourceValueUsd = totalSourceValueUsd;

  FundingFeeBreakdownBuilder? _estimatedFees;
  FundingFeeBreakdownBuilder get estimatedFees =>
      _$this._estimatedFees ??= FundingFeeBreakdownBuilder();
  set estimatedFees(FundingFeeBreakdownBuilder? estimatedFees) =>
      _$this._estimatedFees = estimatedFees;

  int? _etaSeconds;
  int? get etaSeconds => _$this._etaSeconds;
  set etaSeconds(int? etaSeconds) => _$this._etaSeconds = etaSeconds;

  ListBuilder<UnifiedFundingPosition>? _positions;
  ListBuilder<UnifiedFundingPosition> get positions =>
      _$this._positions ??= ListBuilder<UnifiedFundingPosition>();
  set positions(ListBuilder<UnifiedFundingPosition>? positions) =>
      _$this._positions = positions;

  ListBuilder<FundingSessionSourceAllocation>? _allocations;
  ListBuilder<FundingSessionSourceAllocation> get allocations =>
      _$this._allocations ??= ListBuilder<FundingSessionSourceAllocation>();
  set allocations(ListBuilder<FundingSessionSourceAllocation>? allocations) =>
      _$this._allocations = allocations;

  bool? _canConfirmTransfer;
  bool? get canConfirmTransfer => _$this._canConfirmTransfer;
  set canConfirmTransfer(bool? canConfirmTransfer) =>
      _$this._canConfirmTransfer = canConfirmTransfer;

  String? _remainingMinimumTopUp;
  String? get remainingMinimumTopUp => _$this._remainingMinimumTopUp;
  set remainingMinimumTopUp(String? remainingMinimumTopUp) =>
      _$this._remainingMinimumTopUp = remainingMinimumTopUp;

  DateTime? _estimateObservedAt;
  DateTime? get estimateObservedAt => _$this._estimateObservedAt;
  set estimateObservedAt(DateTime? estimateObservedAt) =>
      _$this._estimateObservedAt = estimateObservedAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  FundingSessionBuilder() {
    FundingSession._defaults(this);
  }

  FundingSessionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _fundingSessionId = $v.fundingSessionId;
      _status = $v.status;
      _version = $v.version;
      _trade = $v.trade.toBuilder();
      _continuation = $v.continuation.toBuilder();
      _rail = $v.rail;
      _targetSnapshot = $v.targetSnapshot.toBuilder();
      _requiredTargetBalance = $v.requiredTargetBalance;
      _minimumTopUp = $v.minimumTopUp;
      _recommendedTopUp = $v.recommendedTopUp;
      _safetyBufferBps = $v.safetyBufferBps;
      _selectedTargetAmount = $v.selectedTargetAmount;
      _minimumReceived = $v.minimumReceived;
      _maximumSelectableTargetAmount = $v.maximumSelectableTargetAmount;
      _totalSourceValueUsd = $v.totalSourceValueUsd;
      _estimatedFees = $v.estimatedFees.toBuilder();
      _etaSeconds = $v.etaSeconds;
      _positions = $v.positions.toBuilder();
      _allocations = $v.allocations.toBuilder();
      _canConfirmTransfer = $v.canConfirmTransfer;
      _remainingMinimumTopUp = $v.remainingMinimumTopUp;
      _estimateObservedAt = $v.estimateObservedAt;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSession other) {
    _$v = other as _$FundingSession;
  }

  @override
  void update(void Function(FundingSessionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSession build() => _build();

  _$FundingSession _build() {
    _$FundingSession _$result;
    try {
      _$result = _$v ??
          _$FundingSession._(
            fundingSessionId: BuiltValueNullFieldError.checkNotNull(
                fundingSessionId, r'FundingSession', 'fundingSessionId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FundingSession', 'status'),
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'FundingSession', 'version'),
            trade: trade.build(),
            continuation: continuation.build(),
            rail: BuiltValueNullFieldError.checkNotNull(
                rail, r'FundingSession', 'rail'),
            targetSnapshot: targetSnapshot.build(),
            requiredTargetBalance: BuiltValueNullFieldError.checkNotNull(
                requiredTargetBalance,
                r'FundingSession',
                'requiredTargetBalance'),
            minimumTopUp: BuiltValueNullFieldError.checkNotNull(
                minimumTopUp, r'FundingSession', 'minimumTopUp'),
            recommendedTopUp: BuiltValueNullFieldError.checkNotNull(
                recommendedTopUp, r'FundingSession', 'recommendedTopUp'),
            safetyBufferBps: BuiltValueNullFieldError.checkNotNull(
                safetyBufferBps, r'FundingSession', 'safetyBufferBps'),
            selectedTargetAmount: BuiltValueNullFieldError.checkNotNull(
                selectedTargetAmount,
                r'FundingSession',
                'selectedTargetAmount'),
            minimumReceived: BuiltValueNullFieldError.checkNotNull(
                minimumReceived, r'FundingSession', 'minimumReceived'),
            maximumSelectableTargetAmount:
                BuiltValueNullFieldError.checkNotNull(
                    maximumSelectableTargetAmount,
                    r'FundingSession',
                    'maximumSelectableTargetAmount'),
            totalSourceValueUsd: BuiltValueNullFieldError.checkNotNull(
                totalSourceValueUsd, r'FundingSession', 'totalSourceValueUsd'),
            estimatedFees: estimatedFees.build(),
            etaSeconds: BuiltValueNullFieldError.checkNotNull(
                etaSeconds, r'FundingSession', 'etaSeconds'),
            positions: positions.build(),
            allocations: allocations.build(),
            canConfirmTransfer: BuiltValueNullFieldError.checkNotNull(
                canConfirmTransfer, r'FundingSession', 'canConfirmTransfer'),
            remainingMinimumTopUp: BuiltValueNullFieldError.checkNotNull(
                remainingMinimumTopUp,
                r'FundingSession',
                'remainingMinimumTopUp'),
            estimateObservedAt: BuiltValueNullFieldError.checkNotNull(
                estimateObservedAt, r'FundingSession', 'estimateObservedAt'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'FundingSession', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, r'FundingSession', 'updatedAt'),
            expiresAt: BuiltValueNullFieldError.checkNotNull(
                expiresAt, r'FundingSession', 'expiresAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'trade';
        trade.build();
        _$failedField = 'continuation';
        continuation.build();

        _$failedField = 'targetSnapshot';
        targetSnapshot.build();

        _$failedField = 'estimatedFees';
        estimatedFees.build();

        _$failedField = 'positions';
        positions.build();
        _$failedField = 'allocations';
        allocations.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSession', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
