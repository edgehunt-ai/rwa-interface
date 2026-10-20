// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_source_transaction_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSourceTransactionObservation
    extends FundingSourceTransactionObservation {
  @override
  final int chainId;
  @override
  final String txHash;
  @override
  final TransferSourceExecutionStatus status;
  @override
  final bool receiptSuccess;
  @override
  final int confirmations;
  @override
  final DateTime observedAt;

  factory _$FundingSourceTransactionObservation(
          [void Function(FundingSourceTransactionObservationBuilder)?
              updates]) =>
      (FundingSourceTransactionObservationBuilder()..update(updates))._build();

  _$FundingSourceTransactionObservation._(
      {required this.chainId,
      required this.txHash,
      required this.status,
      required this.receiptSuccess,
      required this.confirmations,
      required this.observedAt})
      : super._();
  @override
  FundingSourceTransactionObservation rebuild(
          void Function(FundingSourceTransactionObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSourceTransactionObservationBuilder toBuilder() =>
      FundingSourceTransactionObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSourceTransactionObservation &&
        chainId == other.chainId &&
        txHash == other.txHash &&
        status == other.status &&
        receiptSuccess == other.receiptSuccess &&
        confirmations == other.confirmations &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, chainId.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, receiptSuccess.hashCode);
    _$hash = $jc(_$hash, confirmations.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSourceTransactionObservation')
          ..add('chainId', chainId)
          ..add('txHash', txHash)
          ..add('status', status)
          ..add('receiptSuccess', receiptSuccess)
          ..add('confirmations', confirmations)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class FundingSourceTransactionObservationBuilder
    implements
        Builder<FundingSourceTransactionObservation,
            FundingSourceTransactionObservationBuilder> {
  _$FundingSourceTransactionObservation? _$v;

  int? _chainId;
  int? get chainId => _$this._chainId;
  set chainId(int? chainId) => _$this._chainId = chainId;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  TransferSourceExecutionStatus? _status;
  TransferSourceExecutionStatus? get status => _$this._status;
  set status(TransferSourceExecutionStatus? status) => _$this._status = status;

  bool? _receiptSuccess;
  bool? get receiptSuccess => _$this._receiptSuccess;
  set receiptSuccess(bool? receiptSuccess) =>
      _$this._receiptSuccess = receiptSuccess;

  int? _confirmations;
  int? get confirmations => _$this._confirmations;
  set confirmations(int? confirmations) =>
      _$this._confirmations = confirmations;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  FundingSourceTransactionObservationBuilder() {
    FundingSourceTransactionObservation._defaults(this);
  }

  FundingSourceTransactionObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _chainId = $v.chainId;
      _txHash = $v.txHash;
      _status = $v.status;
      _receiptSuccess = $v.receiptSuccess;
      _confirmations = $v.confirmations;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSourceTransactionObservation other) {
    _$v = other as _$FundingSourceTransactionObservation;
  }

  @override
  void update(
      void Function(FundingSourceTransactionObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSourceTransactionObservation build() => _build();

  _$FundingSourceTransactionObservation _build() {
    final _$result = _$v ??
        _$FundingSourceTransactionObservation._(
          chainId: BuiltValueNullFieldError.checkNotNull(
              chainId, r'FundingSourceTransactionObservation', 'chainId'),
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'FundingSourceTransactionObservation', 'txHash'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'FundingSourceTransactionObservation', 'status'),
          receiptSuccess: BuiltValueNullFieldError.checkNotNull(receiptSuccess,
              r'FundingSourceTransactionObservation', 'receiptSuccess'),
          confirmations: BuiltValueNullFieldError.checkNotNull(confirmations,
              r'FundingSourceTransactionObservation', 'confirmations'),
          observedAt: BuiltValueNullFieldError.checkNotNull(
              observedAt, r'FundingSourceTransactionObservation', 'observedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
