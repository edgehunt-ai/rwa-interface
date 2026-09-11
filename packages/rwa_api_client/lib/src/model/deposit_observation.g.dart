// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DepositObservation extends DepositObservation {
  @override
  final String observationId;
  @override
  final Chain chain;
  @override
  final String asset;
  @override
  final String amount;
  @override
  final DepositObservationStatus status;
  @override
  final int confirmations;
  @override
  final int confirmationsRequired;
  @override
  final String txHash;
  @override
  final DateTime detectedAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime? confirmedAt;
  @override
  final String? depositId;

  factory _$DepositObservation(
          [void Function(DepositObservationBuilder)? updates]) =>
      (DepositObservationBuilder()..update(updates))._build();

  _$DepositObservation._(
      {required this.observationId,
      required this.chain,
      required this.asset,
      required this.amount,
      required this.status,
      required this.confirmations,
      required this.confirmationsRequired,
      required this.txHash,
      required this.detectedAt,
      required this.updatedAt,
      this.confirmedAt,
      this.depositId})
      : super._();
  @override
  DepositObservation rebuild(
          void Function(DepositObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositObservationBuilder toBuilder() =>
      DepositObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositObservation &&
        observationId == other.observationId &&
        chain == other.chain &&
        asset == other.asset &&
        amount == other.amount &&
        status == other.status &&
        confirmations == other.confirmations &&
        confirmationsRequired == other.confirmationsRequired &&
        txHash == other.txHash &&
        detectedAt == other.detectedAt &&
        updatedAt == other.updatedAt &&
        confirmedAt == other.confirmedAt &&
        depositId == other.depositId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, observationId.hashCode);
    _$hash = $jc(_$hash, chain.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, confirmations.hashCode);
    _$hash = $jc(_$hash, confirmationsRequired.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, detectedAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, confirmedAt.hashCode);
    _$hash = $jc(_$hash, depositId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DepositObservation')
          ..add('observationId', observationId)
          ..add('chain', chain)
          ..add('asset', asset)
          ..add('amount', amount)
          ..add('status', status)
          ..add('confirmations', confirmations)
          ..add('confirmationsRequired', confirmationsRequired)
          ..add('txHash', txHash)
          ..add('detectedAt', detectedAt)
          ..add('updatedAt', updatedAt)
          ..add('confirmedAt', confirmedAt)
          ..add('depositId', depositId))
        .toString();
  }
}

class DepositObservationBuilder
    implements Builder<DepositObservation, DepositObservationBuilder> {
  _$DepositObservation? _$v;

  String? _observationId;
  String? get observationId => _$this._observationId;
  set observationId(String? observationId) =>
      _$this._observationId = observationId;

  Chain? _chain;
  Chain? get chain => _$this._chain;
  set chain(Chain? chain) => _$this._chain = chain;

  String? _asset;
  String? get asset => _$this._asset;
  set asset(String? asset) => _$this._asset = asset;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  DepositObservationStatus? _status;
  DepositObservationStatus? get status => _$this._status;
  set status(DepositObservationStatus? status) => _$this._status = status;

  int? _confirmations;
  int? get confirmations => _$this._confirmations;
  set confirmations(int? confirmations) =>
      _$this._confirmations = confirmations;

  int? _confirmationsRequired;
  int? get confirmationsRequired => _$this._confirmationsRequired;
  set confirmationsRequired(int? confirmationsRequired) =>
      _$this._confirmationsRequired = confirmationsRequired;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  DateTime? _detectedAt;
  DateTime? get detectedAt => _$this._detectedAt;
  set detectedAt(DateTime? detectedAt) => _$this._detectedAt = detectedAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _confirmedAt;
  DateTime? get confirmedAt => _$this._confirmedAt;
  set confirmedAt(DateTime? confirmedAt) => _$this._confirmedAt = confirmedAt;

  String? _depositId;
  String? get depositId => _$this._depositId;
  set depositId(String? depositId) => _$this._depositId = depositId;

  DepositObservationBuilder() {
    DepositObservation._defaults(this);
  }

  DepositObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _observationId = $v.observationId;
      _chain = $v.chain;
      _asset = $v.asset;
      _amount = $v.amount;
      _status = $v.status;
      _confirmations = $v.confirmations;
      _confirmationsRequired = $v.confirmationsRequired;
      _txHash = $v.txHash;
      _detectedAt = $v.detectedAt;
      _updatedAt = $v.updatedAt;
      _confirmedAt = $v.confirmedAt;
      _depositId = $v.depositId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositObservation other) {
    _$v = other as _$DepositObservation;
  }

  @override
  void update(void Function(DepositObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositObservation build() => _build();

  _$DepositObservation _build() {
    final _$result = _$v ??
        _$DepositObservation._(
          observationId: BuiltValueNullFieldError.checkNotNull(
              observationId, r'DepositObservation', 'observationId'),
          chain: BuiltValueNullFieldError.checkNotNull(
              chain, r'DepositObservation', 'chain'),
          asset: BuiltValueNullFieldError.checkNotNull(
              asset, r'DepositObservation', 'asset'),
          amount: BuiltValueNullFieldError.checkNotNull(
              amount, r'DepositObservation', 'amount'),
          status: BuiltValueNullFieldError.checkNotNull(
              status, r'DepositObservation', 'status'),
          confirmations: BuiltValueNullFieldError.checkNotNull(
              confirmations, r'DepositObservation', 'confirmations'),
          confirmationsRequired: BuiltValueNullFieldError.checkNotNull(
              confirmationsRequired,
              r'DepositObservation',
              'confirmationsRequired'),
          txHash: BuiltValueNullFieldError.checkNotNull(
              txHash, r'DepositObservation', 'txHash'),
          detectedAt: BuiltValueNullFieldError.checkNotNull(
              detectedAt, r'DepositObservation', 'detectedAt'),
          updatedAt: BuiltValueNullFieldError.checkNotNull(
              updatedAt, r'DepositObservation', 'updatedAt'),
          confirmedAt: confirmedAt,
          depositId: depositId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
