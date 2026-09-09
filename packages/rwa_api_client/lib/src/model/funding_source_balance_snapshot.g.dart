// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_source_balance_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingSourceBalanceSnapshot extends FundingSourceBalanceSnapshot {
  @override
  final String walletId;
  @override
  final String walletAddress;
  @override
  final FundingSourceAssetIdentity asset;
  @override
  final String availableAmount;
  @override
  final String gasAsset;
  @override
  final String gasBalance;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$FundingSourceBalanceSnapshot(
          [void Function(FundingSourceBalanceSnapshotBuilder)? updates]) =>
      (FundingSourceBalanceSnapshotBuilder()..update(updates))._build();

  _$FundingSourceBalanceSnapshot._(
      {required this.walletId,
      required this.walletAddress,
      required this.asset,
      required this.availableAmount,
      required this.gasAsset,
      required this.gasBalance,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  FundingSourceBalanceSnapshot rebuild(
          void Function(FundingSourceBalanceSnapshotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingSourceBalanceSnapshotBuilder toBuilder() =>
      FundingSourceBalanceSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingSourceBalanceSnapshot &&
        walletId == other.walletId &&
        walletAddress == other.walletAddress &&
        asset == other.asset &&
        availableAmount == other.availableAmount &&
        gasAsset == other.gasAsset &&
        gasBalance == other.gasBalance &&
        observedAt == other.observedAt &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, walletId.hashCode);
    _$hash = $jc(_$hash, walletAddress.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, availableAmount.hashCode);
    _$hash = $jc(_$hash, gasAsset.hashCode);
    _$hash = $jc(_$hash, gasBalance.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingSourceBalanceSnapshot')
          ..add('walletId', walletId)
          ..add('walletAddress', walletAddress)
          ..add('asset', asset)
          ..add('availableAmount', availableAmount)
          ..add('gasAsset', gasAsset)
          ..add('gasBalance', gasBalance)
          ..add('observedAt', observedAt)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class FundingSourceBalanceSnapshotBuilder
    implements
        Builder<FundingSourceBalanceSnapshot,
            FundingSourceBalanceSnapshotBuilder> {
  _$FundingSourceBalanceSnapshot? _$v;

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

  FundingSourceBalanceSnapshotBuilder() {
    FundingSourceBalanceSnapshot._defaults(this);
  }

  FundingSourceBalanceSnapshotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _walletId = $v.walletId;
      _walletAddress = $v.walletAddress;
      _asset = $v.asset.toBuilder();
      _availableAmount = $v.availableAmount;
      _gasAsset = $v.gasAsset;
      _gasBalance = $v.gasBalance;
      _observedAt = $v.observedAt;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingSourceBalanceSnapshot other) {
    _$v = other as _$FundingSourceBalanceSnapshot;
  }

  @override
  void update(void Function(FundingSourceBalanceSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingSourceBalanceSnapshot build() => _build();

  _$FundingSourceBalanceSnapshot _build() {
    _$FundingSourceBalanceSnapshot _$result;
    try {
      _$result = _$v ??
          _$FundingSourceBalanceSnapshot._(
            walletId: BuiltValueNullFieldError.checkNotNull(
                walletId, r'FundingSourceBalanceSnapshot', 'walletId'),
            walletAddress: BuiltValueNullFieldError.checkNotNull(walletAddress,
                r'FundingSourceBalanceSnapshot', 'walletAddress'),
            asset: asset.build(),
            availableAmount: BuiltValueNullFieldError.checkNotNull(
                availableAmount,
                r'FundingSourceBalanceSnapshot',
                'availableAmount'),
            gasAsset: BuiltValueNullFieldError.checkNotNull(
                gasAsset, r'FundingSourceBalanceSnapshot', 'gasAsset'),
            gasBalance: BuiltValueNullFieldError.checkNotNull(
                gasBalance, r'FundingSourceBalanceSnapshot', 'gasBalance'),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'FundingSourceBalanceSnapshot', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'FundingSourceBalanceSnapshot', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingSourceBalanceSnapshot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
