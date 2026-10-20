// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_target_balance_snapshot.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingTargetBalanceSnapshot extends FundingTargetBalanceSnapshot {
  @override
  final AccountKind account;
  @override
  final String accountRef;
  @override
  final FundingAssetIdentity asset;
  @override
  final String availableAmount;
  @override
  final FundingTargetBalanceSource source_;
  @override
  final DateTime observedAt;
  @override
  final DateTime validUntil;

  factory _$FundingTargetBalanceSnapshot(
          [void Function(FundingTargetBalanceSnapshotBuilder)? updates]) =>
      (FundingTargetBalanceSnapshotBuilder()..update(updates))._build();

  _$FundingTargetBalanceSnapshot._(
      {required this.account,
      required this.accountRef,
      required this.asset,
      required this.availableAmount,
      required this.source_,
      required this.observedAt,
      required this.validUntil})
      : super._();
  @override
  FundingTargetBalanceSnapshot rebuild(
          void Function(FundingTargetBalanceSnapshotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingTargetBalanceSnapshotBuilder toBuilder() =>
      FundingTargetBalanceSnapshotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingTargetBalanceSnapshot &&
        account == other.account &&
        accountRef == other.accountRef &&
        asset == other.asset &&
        availableAmount == other.availableAmount &&
        source_ == other.source_ &&
        observedAt == other.observedAt &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, account.hashCode);
    _$hash = $jc(_$hash, accountRef.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, availableAmount.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingTargetBalanceSnapshot')
          ..add('account', account)
          ..add('accountRef', accountRef)
          ..add('asset', asset)
          ..add('availableAmount', availableAmount)
          ..add('source_', source_)
          ..add('observedAt', observedAt)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class FundingTargetBalanceSnapshotBuilder
    implements
        Builder<FundingTargetBalanceSnapshot,
            FundingTargetBalanceSnapshotBuilder> {
  _$FundingTargetBalanceSnapshot? _$v;

  AccountKind? _account;
  AccountKind? get account => _$this._account;
  set account(AccountKind? account) => _$this._account = account;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  FundingAssetIdentityBuilder? _asset;
  FundingAssetIdentityBuilder get asset =>
      _$this._asset ??= FundingAssetIdentityBuilder();
  set asset(FundingAssetIdentityBuilder? asset) => _$this._asset = asset;

  String? _availableAmount;
  String? get availableAmount => _$this._availableAmount;
  set availableAmount(String? availableAmount) =>
      _$this._availableAmount = availableAmount;

  FundingTargetBalanceSource? _source_;
  FundingTargetBalanceSource? get source_ => _$this._source_;
  set source_(FundingTargetBalanceSource? source_) => _$this._source_ = source_;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  FundingTargetBalanceSnapshotBuilder() {
    FundingTargetBalanceSnapshot._defaults(this);
  }

  FundingTargetBalanceSnapshotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _account = $v.account;
      _accountRef = $v.accountRef;
      _asset = $v.asset.toBuilder();
      _availableAmount = $v.availableAmount;
      _source_ = $v.source_;
      _observedAt = $v.observedAt;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingTargetBalanceSnapshot other) {
    _$v = other as _$FundingTargetBalanceSnapshot;
  }

  @override
  void update(void Function(FundingTargetBalanceSnapshotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingTargetBalanceSnapshot build() => _build();

  _$FundingTargetBalanceSnapshot _build() {
    _$FundingTargetBalanceSnapshot _$result;
    try {
      _$result = _$v ??
          _$FundingTargetBalanceSnapshot._(
            account: BuiltValueNullFieldError.checkNotNull(
                account, r'FundingTargetBalanceSnapshot', 'account'),
            accountRef: BuiltValueNullFieldError.checkNotNull(
                accountRef, r'FundingTargetBalanceSnapshot', 'accountRef'),
            asset: asset.build(),
            availableAmount: BuiltValueNullFieldError.checkNotNull(
                availableAmount,
                r'FundingTargetBalanceSnapshot',
                'availableAmount'),
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'FundingTargetBalanceSnapshot', 'source_'),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'FundingTargetBalanceSnapshot', 'observedAt'),
            validUntil: BuiltValueNullFieldError.checkNotNull(
                validUntil, r'FundingTargetBalanceSnapshot', 'validUntil'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingTargetBalanceSnapshot', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
