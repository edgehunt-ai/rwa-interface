// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_source_position_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSourcePositionSnapshot extends FundingSourcePositionSnapshot {
  @override
  final String positionId;
  @override
  final String walletId;
  @override
  final String walletAddress;
  @override
  final FundingSourceAssetIdentity asset;
  @override
  final String availableAmount;
  @override
  final String reservedAmount;
  @override
  final String gasAsset;
  @override
  final String gasBalance;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$FundingSourcePositionSnapshot(
          [void Function(FundingSourcePositionSnapshotBuilder)? updates]) =>
      (FundingSourcePositionSnapshotBuilder()..update(updates))._build();

  _$FundingSourcePositionSnapshot._(
      {required this.positionId,
      required this.walletId,
      required this.walletAddress,
      required this.asset,
      required this.availableAmount,
      required this.reservedAmount,
      required this.gasAsset,
      required this.gasBalance,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  FundingSourcePositionSnapshot rebuild(
          void Function(FundingSourcePositionSnapshotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSourcePositionSnapshotBuilder toBuilder() =>
      FundingSourcePositionSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSourcePositionSnapshot &&
        positionId == other.positionId &&
        walletId == other.walletId &&
        walletAddress == other.walletAddress &&
        asset == other.asset &&
        availableAmount == other.availableAmount &&
        reservedAmount == other.reservedAmount &&
        gasAsset == other.gasAsset &&
        gasBalance == other.gasBalance &&
        observedAt == other.observedAt &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, positionId.hashCode);
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, walletAddress.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, availableAmount.hashCode);
    _$hash = $jc(_$hash, reservedAmount.hashCode);
    _$hash = $jc(_$hash, gasAsset.hashCode);
    _$hash = $jc(_$hash, gasBalance.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSourcePositionSnapshot')
          ..add('positionId', positionId)
          ..add('walletId', walletId)
          ..add('walletAddress', walletAddress)
          ..add('asset', asset)
          ..add('availableAmount', availableAmount)
          ..add('reservedAmount', reservedAmount)
          ..add('gasAsset', gasAsset)
          ..add('gasBalance', gasBalance)
          ..add('observedAt', observedAt)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class FundingSourcePositionSnapshotBuilder
    implements
        Builder<FundingSourcePositionSnapshot,
            FundingSourcePositionSnapshotBuilder> {
  _$FundingSourcePositionSnapshot? _$v;

  String? _positionId;
  String? get positionId => _$this._positionId;
  set positionId(String? positionId) => _$this._positionId = positionId;

  String? _walletId;
  String? get walletId => _$this._walletId;
  set walletId(String? walletId) => _$this._walletId = walletId;

  String? _walletAddress;
  String? get walletAddress => _$this._walletAddress;
  set walletAddress(String? walletAddress) =>
      _$this._walletAddress = walletAddress;

  FundingSourceAssetIdentityBuilder? _asset;
  FundingSourceAssetIdentityBuilder get asset =>
      _$this._asset ??= FundingSourceAssetIdentityBuilder();
  set asset(FundingSourceAssetIdentityBuilder? asset) => _$this._asset = asset;

  String? _availableAmount;
  String? get availableAmount => _$this._availableAmount;
  set availableAmount(String? availableAmount) =>
      _$this._availableAmount = availableAmount;

  String? _reservedAmount;
  String? get reservedAmount => _$this._reservedAmount;
  set reservedAmount(String? reservedAmount) =>
      _$this._reservedAmount = reservedAmount;

  String? _gasAsset;
  String? get gasAsset => _$this._gasAsset;
  set gasAsset(String? gasAsset) => _$this._gasAsset = gasAsset;

  String? _gasBalance;
  String? get gasBalance => _$this._gasBalance;
  set gasBalance(String? gasBalance) => _$this._gasBalance = gasBalance;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  FundingSourcePositionSnapshotBuilder() {
    FundingSourcePositionSnapshot._defaults(this);
  }

  FundingSourcePositionSnapshotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _positionId = $v.positionId;
      _walletId = $v.walletId;
      _walletAddress = $v.walletAddress;
      _asset = $v.asset.toBuilder();
      _availableAmount = $v.availableAmount;
      _reservedAmount = $v.reservedAmount;
      _gasAsset = $v.gasAsset;
      _gasBalance = $v.gasBalance;
      _observedAt = $v.observedAt;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSourcePositionSnapshot other) {
    _$v = other as _$FundingSourcePositionSnapshot;
  }

  @override
  void update(void Function(FundingSourcePositionSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSourcePositionSnapshot build() => _build();

  _$FundingSourcePositionSnapshot _build() {
    _$FundingSourcePositionSnapshot _$result;
    try {
      _$result = _$v ??
          _$FundingSourcePositionSnapshot._(
            positionId: BuiltValueNullFieldError.checkNotNull(
                positionId, r'FundingSourcePositionSnapshot', 'positionId'),
            walletId: BuiltValueNullFieldError.checkNotNull(
                walletId, r'FundingSourcePositionSnapshot', 'walletId'),
            walletAddress: BuiltValueNullFieldError.checkNotNull(walletAddress,
                r'FundingSourcePositionSnapshot', 'walletAddress'),
            asset: asset.build(),
            availableAmount: BuiltValueNullFieldError.checkNotNull(
                availableAmount,
                r'FundingSourcePositionSnapshot',
                'availableAmount'),
            reservedAmount: BuiltValueNullFieldError.checkNotNull(
                reservedAmount,
                r'FundingSourcePositionSnapshot',
                'reservedAmount'),
            gasAsset: BuiltValueNullFieldError.checkNotNull(
                gasAsset, r'FundingSourcePositionSnapshot', 'gasAsset'),
            gasBalance: BuiltValueNullFieldError.checkNotNull(
                gasBalance, r'FundingSourcePositionSnapshot', 'gasBalance'),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'FundingSourcePositionSnapshot', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'FundingSourcePositionSnapshot', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSourcePositionSnapshot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
