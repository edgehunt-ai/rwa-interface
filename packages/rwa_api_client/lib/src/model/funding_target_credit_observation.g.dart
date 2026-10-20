// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_target_credit_observation.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingTargetCreditObservation extends FundingTargetCreditObservation {
  @override
  final String accountRef;
  @override
  final FundingAssetIdentity asset;
  @override
  final String availableBefore;
  @override
  final String availableAfter;
  @override
  final String creditedAmount;
  @override
  final FundingTargetBalanceSource source_;
  @override
  final DateTime observedAt;

  factory _$FundingTargetCreditObservation(
          [void Function(FundingTargetCreditObservationBuilder)? updates]) =>
      (FundingTargetCreditObservationBuilder()..update(updates))._build();

  _$FundingTargetCreditObservation._(
      {required this.accountRef,
      required this.asset,
      required this.availableBefore,
      required this.availableAfter,
      required this.creditedAmount,
      required this.source_,
      required this.observedAt})
      : super._();
  @override
  FundingTargetCreditObservation rebuild(
          void Function(FundingTargetCreditObservationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingTargetCreditObservationBuilder toBuilder() =>
      FundingTargetCreditObservationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingTargetCreditObservation &&
        accountRef == other.accountRef &&
        asset == other.asset &&
        availableBefore == other.availableBefore &&
        availableAfter == other.availableAfter &&
        creditedAmount == other.creditedAmount &&
        source_ == other.source_ &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accountRef.hashCode);
    _$hash = $jc(_$hash, asset.hashCode);
    _$hash = $jc(_$hash, availableBefore.hashCode);
    _$hash = $jc(_$hash, availableAfter.hashCode);
    _$hash = $jc(_$hash, creditedAmount.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingTargetCreditObservation')
          ..add('accountRef', accountRef)
          ..add('asset', asset)
          ..add('availableBefore', availableBefore)
          ..add('availableAfter', availableAfter)
          ..add('creditedAmount', creditedAmount)
          ..add('source_', source_)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class FundingTargetCreditObservationBuilder
    implements
        Builder<FundingTargetCreditObservation,
            FundingTargetCreditObservationBuilder> {
  _$FundingTargetCreditObservation? _$v;

  String? _accountRef;
  String? get accountRef => _$this._accountRef;
  set accountRef(String? accountRef) => _$this._accountRef = accountRef;

  FundingAssetIdentityBuilder? _asset;
  FundingAssetIdentityBuilder get asset =>
      _$this._asset ??= FundingAssetIdentityBuilder();
  set asset(FundingAssetIdentityBuilder? asset) => _$this._asset = asset;

  String? _availableBefore;
  String? get availableBefore => _$this._availableBefore;
  set availableBefore(String? availableBefore) =>
      _$this._availableBefore = availableBefore;

  String? _availableAfter;
  String? get availableAfter => _$this._availableAfter;
  set availableAfter(String? availableAfter) =>
      _$this._availableAfter = availableAfter;

  String? _creditedAmount;
  String? get creditedAmount => _$this._creditedAmount;
  set creditedAmount(String? creditedAmount) =>
      _$this._creditedAmount = creditedAmount;

  FundingTargetBalanceSource? _source_;
  FundingTargetBalanceSource? get source_ => _$this._source_;
  set source_(FundingTargetBalanceSource? source_) => _$this._source_ = source_;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  FundingTargetCreditObservationBuilder() {
    FundingTargetCreditObservation._defaults(this);
  }

  FundingTargetCreditObservationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accountRef = $v.accountRef;
      _asset = $v.asset.toBuilder();
      _availableBefore = $v.availableBefore;
      _availableAfter = $v.availableAfter;
      _creditedAmount = $v.creditedAmount;
      _source_ = $v.source_;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingTargetCreditObservation other) {
    _$v = other as _$FundingTargetCreditObservation;
  }

  @override
  void update(void Function(FundingTargetCreditObservationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingTargetCreditObservation build() => _build();

  _$FundingTargetCreditObservation _build() {
    _$FundingTargetCreditObservation _$result;
    try {
      _$result = _$v ??
          _$FundingTargetCreditObservation._(
            accountRef: BuiltValueNullFieldError.checkNotNull(
                accountRef, r'FundingTargetCreditObservation', 'accountRef'),
            asset: asset.build(),
            availableBefore: BuiltValueNullFieldError.checkNotNull(
                availableBefore,
                r'FundingTargetCreditObservation',
                'availableBefore'),
            availableAfter: BuiltValueNullFieldError.checkNotNull(
                availableAfter,
                r'FundingTargetCreditObservation',
                'availableAfter'),
            creditedAmount: BuiltValueNullFieldError.checkNotNull(
                creditedAmount,
                r'FundingTargetCreditObservation',
                'creditedAmount'),
            source_: BuiltValueNullFieldError.checkNotNull(
                source_, r'FundingTargetCreditObservation', 'source_'),
            observedAt: BuiltValueNullFieldError.checkNotNull(
                observedAt, r'FundingTargetCreditObservation', 'observedAt'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'asset';
        asset.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FundingTargetCreditObservation', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
