// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_refund_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingRefundObservation extends FundingRefundObservation {
  @override
  final TransferRefundStatus status;
  @override
  final FundingAssetIdentity? asset;
  @override
  final String? address;
  @override
  final String? amount;
  @override
  final String? txHash;
  @override
  final DateTime? observedAt;

  factory _$FundingRefundObservation(
          [void Function(FundingRefundObservationBuilder)? updates]) =>
      (FundingRefundObservationBuilder()..update(updates))._build();

  _$FundingRefundObservation._(
      {required this.status,
      this.asset,
      this.address,
      this.amount,
      this.txHash,
      this.observedAt})
      : super._();
  @override
  FundingRefundObservation rebuild(
          void Function(FundingRefundObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingRefundObservationBuilder toBuilder() =>
      FundingRefundObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingRefundObservation &&
        status == other.status &&
        asset == other.asset &&
        address == other.address &&
        amount == other.amount &&
        txHash == other.txHash &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, address.hashCode);
    _$hash = $jc(_$hash, amount.hashCode);
    _$hash = $jc(_$hash, txHash.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingRefundObservation')
          ..add('status', status)
          ..add('asset', asset)
          ..add('address', address)
          ..add('amount', amount)
          ..add('txHash', txHash)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class FundingRefundObservationBuilder
    implements
        Builder<FundingRefundObservation, FundingRefundObservationBuilder> {
  _$FundingRefundObservation? _$v;

  TransferRefundStatus? _status;
  TransferRefundStatus? get status => _$this._status;
  set status(TransferRefundStatus? status) => _$this._status = status;

  FundingAssetIdentityBuilder? _asset;
  FundingAssetIdentityBuilder get asset =>
      _$this._asset ??= FundingAssetIdentityBuilder();
  set asset(FundingAssetIdentityBuilder? asset) => _$this._asset = asset;

  String? _address;
  String? get address => _$this._address;
  set address(String? address) => _$this._address = address;

  String? _amount;
  String? get amount => _$this._amount;
  set amount(String? amount) => _$this._amount = amount;

  String? _txHash;
  String? get txHash => _$this._txHash;
  set txHash(String? txHash) => _$this._txHash = txHash;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  FundingRefundObservationBuilder() {
    FundingRefundObservation._defaults(this);
  }

  FundingRefundObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _asset = $v.asset?.toBuilder();
      _address = $v.address;
      _amount = $v.amount;
      _txHash = $v.txHash;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingRefundObservation other) {
    _$v = other as _$FundingRefundObservation;
  }

  @override
  void update(void Function(FundingRefundObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingRefundObservation build() => _build();

  _$FundingRefundObservation _build() {
    _$FundingRefundObservation _$result;
    try {
      _$result = _$v ??
          _$FundingRefundObservation._(
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'FundingRefundObservation', 'status'),
            asset: _asset?.build(),
            address: address,
            amount: amount,
            txHash: txHash,
            observedAt: observedAt,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        _asset?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingRefundObservation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
