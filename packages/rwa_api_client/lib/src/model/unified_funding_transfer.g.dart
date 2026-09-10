// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unified_funding_transfer.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UnifiedFundingTransfer extends UnifiedFundingTransfer {
  @override
  final String transferId;
  @override
  final TransferStatus status;
  @override
  final String sourcePositionId;
  @override
  final String allocatedOutputAmount;
  @override
  final String? valueUsd;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  factory _$UnifiedFundingTransfer(
          [void Function(UnifiedFundingTransferBuilder)? updates]) =>
      (UnifiedFundingTransferBuilder()..update(updates))._build();

  _$UnifiedFundingTransfer._(
      {required this.transferId,
      required this.status,
      required this.sourcePositionId,
      required this.allocatedOutputAmount,
      this.valueUsd,
      required this.createdAt,
      required this.updatedAt})
      : super._();
  @override
  UnifiedFundingTransfer rebuild(
          void Function(UnifiedFundingTransferBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UnifiedFundingTransferBuilder toBuilder() =>
      UnifiedFundingTransferBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UnifiedFundingTransfer &&
        transferId == other.transferId &&
        status == other.status &&
        sourcePositionId == other.sourcePositionId &&
        allocatedOutputAmount == other.allocatedOutputAmount &&
        valueUsd == other.valueUsd &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, transferId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, sourcePositionId.hashCode);
    _$hash = $jc(_$hash, allocatedOutputAmount.hashCode);
    _$hash = $jc(_$hash, valueUsd.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UnifiedFundingTransfer')
          ..add('transferId', transferId)
          ..add('status', status)
          ..add('sourcePositionId', sourcePositionId)
          ..add('allocatedOutputAmount', allocatedOutputAmount)
          ..add('valueUsd', valueUsd)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class UnifiedFundingTransferBuilder
    implements Builder<UnifiedFundingTransfer, UnifiedFundingTransferBuilder> {
  _$UnifiedFundingTransfer? _$v;

  String? _transferId;
  String? get transferId => _$this._transferId;
  set transferId(String? transferId) => _$this._transferId = transferId;

  TransferStatus? _status;
  TransferStatus? get status => _$this._status;
  set status(TransferStatus? status) => _$this._status = status;

  String? _sourcePositionId;
  String? get sourcePositionId => _$this._sourcePositionId;
  set sourcePositionId(String? sourcePositionId) =>
      _$this._sourcePositionId = sourcePositionId;

  String? _allocatedOutputAmount;
  String? get allocatedOutputAmount => _$this._allocatedOutputAmount;
  set allocatedOutputAmount(String? allocatedOutputAmount) =>
      _$this._allocatedOutputAmount = allocatedOutputAmount;

  String? _valueUsd;
  String? get valueUsd => _$this._valueUsd;
  set valueUsd(String? valueUsd) => _$this._valueUsd = valueUsd;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  UnifiedFundingTransferBuilder() {
    UnifiedFundingTransfer._defaults(this);
  }

  UnifiedFundingTransferBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _transferId = $v.transferId;
      _status = $v.status;
      _sourcePositionId = $v.sourcePositionId;
      _allocatedOutputAmount = $v.allocatedOutputAmount;
      _valueUsd = $v.valueUsd;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UnifiedFundingTransfer other) {
    _$v = other as _$UnifiedFundingTransfer;
  }

  @override
  void update(void Function(UnifiedFundingTransferBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UnifiedFundingTransfer build() => _build();

  _$UnifiedFundingTransfer _build() {
    final _$result = _$v ??
        _$UnifiedFundingTransfer._(
          transferId: BuiltValueNullFieldError.checkNotNull(
              transferId, r'UnifiedFundingTransfer', 'transferId'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'UnifiedFundingTransfer', 'status'),
          sourcePositionId: BuiltValueNullFieldError.checkNotNull(
              sourcePositionId, r'UnifiedFundingTransfer', 'sourcePositionId'),
          allocatedOutputAmount: BuiltValueNullFieldError.checkNotNull(
              allocatedOutputAmount,
              r'UnifiedFundingTransfer',
              'allocatedOutputAmount'),
          valueUsd: valueUsd,
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'UnifiedFundingTransfer', 'createdAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'UnifiedFundingTransfer', 'updatedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
