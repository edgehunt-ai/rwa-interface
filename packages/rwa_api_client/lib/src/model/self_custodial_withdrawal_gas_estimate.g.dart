// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_custodial_withdrawal_gas_estimate.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SelfCustodialWithdrawalGasEstimate
    extends SelfCustodialWithdrawalGasEstimate {
  @override
  final String nativeAsset;
  @override
  final String gasUnits;
  @override
  final String gasPriceWei;
  @override
  final String estimatedNativeFee;
  @override
  final String walletNativeBalance;
  @override
  final bool canPayGas;
  @override
  final DateTime observedAt;

  factory _$SelfCustodialWithdrawalGasEstimate(
          [void Function(SelfCustodialWithdrawalGasEstimateBuilder)?
              updates]) =>
      (SelfCustodialWithdrawalGasEstimateBuilder()..update(updates))._build();

  _$SelfCustodialWithdrawalGasEstimate._(
      {required this.nativeAsset,
      required this.gasUnits,
      required this.gasPriceWei,
      required this.estimatedNativeFee,
      required this.walletNativeBalance,
      required this.canPayGas,
      required this.observedAt})
      : super._();
  @override
  SelfCustodialWithdrawalGasEstimate rebuild(
          void Function(SelfCustodialWithdrawalGasEstimateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SelfCustodialWithdrawalGasEstimateBuilder toBuilder() =>
      SelfCustodialWithdrawalGasEstimateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SelfCustodialWithdrawalGasEstimate &&
        nativeAsset == other.nativeAsset &&
        gasUnits == other.gasUnits &&
        gasPriceWei == other.gasPriceWei &&
        estimatedNativeFee == other.estimatedNativeFee &&
        walletNativeBalance == other.walletNativeBalance &&
        canPayGas == other.canPayGas &&
        observedAt == other.observedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nativeAsset.hashCode);
    _$hash = $jc(_$hash, gasUnits.hashCode);
    _$hash = $jc(_$hash, gasPriceWei.hashCode);
    _$hash = $jc(_$hash, estimatedNativeFee.hashCode);
    _$hash = $jc(_$hash, walletNativeBalance.hashCode);
    _$hash = $jc(_$hash, canPayGas.hashCode);
    _$hash = $jc(_$hash, observedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SelfCustodialWithdrawalGasEstimate')
          ..add('nativeAsset', nativeAsset)
          ..add('gasUnits', gasUnits)
          ..add('gasPriceWei', gasPriceWei)
          ..add('estimatedNativeFee', estimatedNativeFee)
          ..add('walletNativeBalance', walletNativeBalance)
          ..add('canPayGas', canPayGas)
          ..add('observedAt', observedAt))
        .toString();
  }
}

class SelfCustodialWithdrawalGasEstimateBuilder
    implements
        Builder<SelfCustodialWithdrawalGasEstimate,
            SelfCustodialWithdrawalGasEstimateBuilder> {
  _$SelfCustodialWithdrawalGasEstimate? _$v;

  String? _nativeAsset;
  String? get nativeAsset => _$this._nativeAsset;
  set nativeAsset(String? nativeAsset) => _$this._nativeAsset = nativeAsset;

  String? _gasUnits;
  String? get gasUnits => _$this._gasUnits;
  set gasUnits(String? gasUnits) => _$this._gasUnits = gasUnits;

  String? _gasPriceWei;
  String? get gasPriceWei => _$this._gasPriceWei;
  set gasPriceWei(String? gasPriceWei) => _$this._gasPriceWei = gasPriceWei;

  String? _estimatedNativeFee;
  String? get estimatedNativeFee => _$this._estimatedNativeFee;
  set estimatedNativeFee(String? estimatedNativeFee) =>
      _$this._estimatedNativeFee = estimatedNativeFee;

  String? _walletNativeBalance;
  String? get walletNativeBalance => _$this._walletNativeBalance;
  set walletNativeBalance(String? walletNativeBalance) =>
      _$this._walletNativeBalance = walletNativeBalance;

  bool? _canPayGas;
  bool? get canPayGas => _$this._canPayGas;
  set canPayGas(bool? canPayGas) => _$this._canPayGas = canPayGas;

  DateTime? _observedAt;
  DateTime? get observedAt => _$this._observedAt;
  set observedAt(DateTime? observedAt) => _$this._observedAt = observedAt;

  SelfCustodialWithdrawalGasEstimateBuilder() {
    SelfCustodialWithdrawalGasEstimate._defaults(this);
  }

  SelfCustodialWithdrawalGasEstimateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nativeAsset = $v.nativeAsset;
      _gasUnits = $v.gasUnits;
      _gasPriceWei = $v.gasPriceWei;
      _estimatedNativeFee = $v.estimatedNativeFee;
      _walletNativeBalance = $v.walletNativeBalance;
      _canPayGas = $v.canPayGas;
      _observedAt = $v.observedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SelfCustodialWithdrawalGasEstimate other) {
    _$v = other as _$SelfCustodialWithdrawalGasEstimate;
  }

  @override
  void update(
      void Function(SelfCustodialWithdrawalGasEstimateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SelfCustodialWithdrawalGasEstimate build() => _build();

  _$SelfCustodialWithdrawalGasEstimate _build() {
    final _$result = _$v ??
        _$SelfCustodialWithdrawalGasEstimate._(
          nativeAsset: BuiltValueNullFieldError.checkNotNull(nativeAsset,
              r'SelfCustodialWithdrawalGasEstimate', 'nativeAsset'),
          gasUnits: BuiltValueNullFieldError.checkNotNull(
              gasUnits, r'SelfCustodialWithdrawalGasEstimate', 'gasUnits'),
          gasPriceWei: BuiltValueNullFieldError.checkNotNull(gasPriceWei,
              r'SelfCustodialWithdrawalGasEstimate', 'gasPriceWei'),
          estimatedNativeFee: BuiltValueNullFieldError.checkNotNull(
              estimatedNativeFee,
              r'SelfCustodialWithdrawalGasEstimate',
              'estimatedNativeFee'),
          walletNativeBalance: BuiltValueNullFieldError.checkNotNull(
              walletNativeBalance,
              r'SelfCustodialWithdrawalGasEstimate',
              'walletNativeBalance'),
          canPayGas: BuiltValueNullFieldError.checkNotNull(
              canPayGas, r'SelfCustodialWithdrawalGasEstimate', 'canPayGas'),
          observedAt: BuiltValueNullFieldError.checkNotNull(
              observedAt, r'SelfCustodialWithdrawalGasEstimate', 'observedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
