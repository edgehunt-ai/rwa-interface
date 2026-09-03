// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Transfer extends Transfer {
  @override
  final String transferId;
  @override
  final String asset;
  @override
  final String amount;
  @override
  final AccountKind fromAccount;
  @override
  final AccountKind toAccount;
  @override
  final TransferStatus status;
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

  factory _$Transfer([void Function(TransferBuilder)? updates]) =>
      (TransferBuilder()..update(updates))._build();

  _$Transfer._(
      {required this.transferId,
      required this.asset,
      required this.amount,
      required this.fromAccount,
      required this.toAccount,
      required this.status,
      this.failureReason,
      this.txHash,
      this.activityId,
      required this.createdAt,
      this.completedAt})
      : super._();
  @override
  Transfer rebuild(void Function(TransferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TransferBuilder toBuilder() => TransferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Transfer &&
        transferId == other.transferId &&
        asset == other.asset &&
        amount == other.amount &&
        fromAccount == other.fromAccount &&
        toAccount == other.toAccount &&
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
    _$hash = $jc(_$hash, transferId.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, fromAccount.hashCode);
    _$hash = $jc(_$hash, toAccount.hashCode);
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
    return (newBuiltValueToStringHelper(r'Transfer')
          ..add('transferId', transferId)
          ..add('asset', asset)
          ..add('amount', amount)
          ..add('fromAccount', fromAccount)
          ..add('toAccount', toAccount)
          ..add('status', status)
          ..add('failureReason', failureReason)
          ..add('txHash', txHash)
          ..add('activityId', activityId)
          ..add('createdAt', createdAt)
          ..add('completedAt', completedAt))
        .toString();
  }
}

class TransferBuilder implements Builder<Transfer, TransferBuilder> {
  _$Transfer? _$v;

  String? _transferId;
  String? get transferId => _$this._transferId;
  set transferId(String? transferId) => _$this._transferId = transferId;

  String? _asset;
  String? get asset => _$this._asset;
  set asset(String? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  AccountKind? _fromAccount;
  AccountKind? get fromAccount => _$this._fromAccount;
  set fromAccount(AccountKind? fromAccount) =>
      _$this._fromAccount = fromAccount;

  AccountKind? _toAccount;
  AccountKind? get toAccount => _$this._toAccount;
  set toAccount(AccountKind? toAccount) => _$this._toAccount = toAccount;

  TransferStatus? _status;
  TransferStatus? get status => _$this._status;
  set status(TransferStatus? status) => _$this._status = status;

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

  TransferBuilder() {
    Transfer._defaults(this);
  }

  TransferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transferId = $v.transferId;
      _asset = $v.asset;
      _amount = $v.amount;
      _fromAccount = $v.fromAccount;
      _toAccount = $v.toAccount;
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
  void replace(Transfer other) {
    _$v = other as _$Transfer;
  }

  @override
  void update(void Function(TransferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Transfer build() => _build();

  _$Transfer _build() {
    final _$result = _$v ??
        _$Transfer._(
          transferId: BuiltValueNullFieldError.checkNotNull(
              transferId, r'Transfer', 'transferId'),
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'Transfer', 'asset'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'Transfer', 'amount'),
          fromAccount: BuiltValueNullFieldError.checkNotNull(
              fromAccount, r'Transfer', 'fromAccount'),
          toAccount: BuiltValueNullFieldError.checkNotNull(
              toAccount, r'Transfer', 'toAccount'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'Transfer', 'status'),
          failureReason: failureReason,
          txHash: txHash,
          activityId: activityId,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'Transfer', 'createdAt'),
          completedAt: completedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
