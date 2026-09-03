// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'claim.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Claim extends Claim {
  @override
  final String claimId;
  @override
  final String transferId;
  @override
  final String asset;
  @override
  final String amount;
  @override
  final AccountKind? creditedTo;
  @override
  final ActivityStatus status;
  @override
  final String? failureReason;
  @override
  final String? txHash;
  @override
  final String? activityId;
  @override
  final DateTime createdAt;
  @override
  final DateTime? completedAt;

  factory _$Claim([void Function(ClaimBuilder)? updates]) =>
      (ClaimBuilder()..update(updates))._build();

  _$Claim._(
      {required this.claimId,
      required this.transferId,
      required this.asset,
      required this.amount,
      this.creditedTo,
      required this.status,
      this.failureReason,
      this.txHash,
      this.activityId,
      required this.createdAt,
      this.completedAt})
      : super._();
  @override
  Claim rebuild(void Function(ClaimBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ClaimBuilder toBuilder() => ClaimBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Claim &&
        claimId == other.claimId &&
        transferId == other.transferId &&
        asset == other.asset &&
        amount == other.amount &&
        creditedTo == other.creditedTo &&
        status == other.status &&
        failureReason == other.failureReason &&
        txHash == other.txHash &&
        activityId == other.activityId &&
        createdAt == other.createdAt &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, claimId.hashCode);
    _$hash = $jc(_$hash, transferId.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, creditedTo.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, failureReason.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, activityId.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Claim')
          ..add('claimId', claimId)
          ..add('transferId', transferId)
          ..add('asset', asset)
          ..add('amount', amount)
          ..add('creditedTo', creditedTo)
          ..add('status', status)
          ..add('failureReason', failureReason)
          ..add('txHash', txHash)
          ..add('activityId', activityId)
          ..add('createdAt', createdAt)
          ..add('completedAt', completedAt))
        .toString();
  }
}

class ClaimBuilder implements Builder<Claim, ClaimBuilder> {
  _$Claim? _$v;

  String? _claimId;
  String? get claimId => _$this._claimId;
  set claimId(String? claimId) => _$this._claimId = claimId;

  String? _transferId;
  String? get transferId => _$this._transferId;
  set transferId(String? transferId) => _$this._transferId = transferId;

  String? _asset;
  String? get asset => _$this._asset;
  set asset(String? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  AccountKind? _creditedTo;
  AccountKind? get creditedTo => _$this._creditedTo;
  set creditedTo(AccountKind? creditedTo) => _$this._creditedTo = creditedTo;

  ActivityStatus? _status;
  ActivityStatus? get status => _$this._status;
  set status(ActivityStatus? status) => _$this._status = status;

  String? _failureReason;
  String? get failureReason => _$this._failureReason;
  set failureReason(String? failureReason) =>
      _$this._failureReason = failureReason;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  String? _activityId;
  String? get activityId => _$this._activityId;
  set activityId(String? activityId) => _$this._activityId = activityId;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  ClaimBuilder() {
    Claim._defaults(this);
  }

  ClaimBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _claimId = $v.claimId;
      _transferId = $v.transferId;
      _asset = $v.asset;
      _amount = $v.amount;
      _creditedTo = $v.creditedTo;
      _status = $v.status;
      _failureReason = $v.failureReason;
      _txHash = $v.txHash;
      _activityId = $v.activityId;
      _createdAt = $v.createdAt;
      _completedAt = $v.completedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Claim other) {
    _$v = other as _$Claim;
  }

  @override
  void update(void Function(ClaimBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Claim build() => _build();

  _$Claim _build() {
    final _$result = _$v ??
        _$Claim._(
          claimId: BuiltValueNullFieldError.checkNotNull(
              claimId, r'Claim', 'claimId'),
          transferId: BuiltValueNullFieldError.checkNotNull(
              transferId, r'Claim', 'transferId'),
          asset:
              BuiltValueNullFieldError.checkNotNull(asset, r'Claim', 'asset'),
          amount:
              BuiltValueNullFieldError.checkNotNull(amount, r'Claim', 'amount'),
          creditedTo: creditedTo,
          status:
              BuiltValueNullFieldError.checkNotNull(status, r'Claim', 'status'),
          failureReason: failureReason,
          txHash: txHash,
          activityId: activityId,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Claim', 'createdAt'),
          completedAt: completedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
