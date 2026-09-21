// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_action_gas_payment.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderActionGasPayment extends OrderActionGasPayment {
  @override
  final GasPaymentMode mode;
  @override
  final GasSponsorshipDecision? decision;
  @override
  final bool? platformPays;
  @override
  final String? nativeAsset;
  @override
  final String? estimatedNativeFee;
  @override
  final String? estimatedFeeUsd;
  @override
  final String? walletNativeBalance;
  @override
  final bool? fallbackAllowed;
  @override
  final bool? eip7702Required;
  @override
  final String? eip7702Notice;

  factory _$OrderActionGasPayment(
          [void Function(OrderActionGasPaymentBuilder)? updates]) =>
      (OrderActionGasPaymentBuilder()..update(updates))._build();

  _$OrderActionGasPayment._(
      {required this.mode,
      this.decision,
      this.platformPays,
      this.nativeAsset,
      this.estimatedNativeFee,
      this.estimatedFeeUsd,
      this.walletNativeBalance,
      this.fallbackAllowed,
      this.eip7702Required,
      this.eip7702Notice})
      : super._();
  @override
  OrderActionGasPayment rebuild(
          void Function(OrderActionGasPaymentBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderActionGasPaymentBuilder toBuilder() =>
      OrderActionGasPaymentBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderActionGasPayment &&
        mode == other.mode &&
        decision == other.decision &&
        platformPays == other.platformPays &&
        nativeAsset == other.nativeAsset &&
        estimatedNativeFee == other.estimatedNativeFee &&
        estimatedFeeUsd == other.estimatedFeeUsd &&
        walletNativeBalance == other.walletNativeBalance &&
        fallbackAllowed == other.fallbackAllowed &&
        eip7702Required == other.eip7702Required &&
        eip7702Notice == other.eip7702Notice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mode.hashCode);
    _$hash = $jc(_$hash, decision.hashCode);
    _$hash = $jc(_$hash, platformPays.hashCode);
    _$hash = $jc(_$hash, nativeAsset.hashCode);
    _$hash = $jc(_$hash, estimatedNativeFee.hashCode);
    _$hash = $jc(_$hash, estimatedFeeUsd.hashCode);
    _$hash = $jc(_$hash, walletNativeBalance.hashCode);
    _$hash = $jc(_$hash, fallbackAllowed.hashCode);
    _$hash = $jc(_$hash, eip7702Required.hashCode);
    _$hash = $jc(_$hash, eip7702Notice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderActionGasPayment')
          ..add('mode', mode)
          ..add('decision', decision)
          ..add('platformPays', platformPays)
          ..add('nativeAsset', nativeAsset)
          ..add('estimatedNativeFee', estimatedNativeFee)
          ..add('estimatedFeeUsd', estimatedFeeUsd)
          ..add('walletNativeBalance', walletNativeBalance)
          ..add('fallbackAllowed', fallbackAllowed)
          ..add('eip7702Required', eip7702Required)
          ..add('eip7702Notice', eip7702Notice))
        .toString();
  }
}

class OrderActionGasPaymentBuilder
    implements Builder<OrderActionGasPayment, OrderActionGasPaymentBuilder> {
  _$OrderActionGasPayment? _$v;

  GasPaymentMode? _mode;
  GasPaymentMode? get mode => _$this._mode;
  set mode(GasPaymentMode? mode) => _$this._mode = mode;

  GasSponsorshipDecision? _decision;
  GasSponsorshipDecision? get decision => _$this._decision;
  set decision(GasSponsorshipDecision? decision) => _$this._decision = decision;

  bool? _platformPays;
  bool? get platformPays => _$this._platformPays;
  set platformPays(bool? platformPays) => _$this._platformPays = platformPays;

  String? _nativeAsset;
  String? get nativeAsset => _$this._nativeAsset;
  set nativeAsset(String? nativeAsset) => _$this._nativeAsset = nativeAsset;

  String? _estimatedNativeFee;
  String? get estimatedNativeFee => _$this._estimatedNativeFee;
  set estimatedNativeFee(String? estimatedNativeFee) =>
      _$this._estimatedNativeFee = estimatedNativeFee;

  String? _estimatedFeeUsd;
  String? get estimatedFeeUsd => _$this._estimatedFeeUsd;
  set estimatedFeeUsd(String? estimatedFeeUsd) =>
      _$this._estimatedFeeUsd = estimatedFeeUsd;

  String? _walletNativeBalance;
  String? get walletNativeBalance => _$this._walletNativeBalance;
  set walletNativeBalance(String? walletNativeBalance) =>
      _$this._walletNativeBalance = walletNativeBalance;

  bool? _fallbackAllowed;
  bool? get fallbackAllowed => _$this._fallbackAllowed;
  set fallbackAllowed(bool? fallbackAllowed) =>
      _$this._fallbackAllowed = fallbackAllowed;

  bool? _eip7702Required;
  bool? get eip7702Required => _$this._eip7702Required;
  set eip7702Required(bool? eip7702Required) =>
      _$this._eip7702Required = eip7702Required;

  String? _eip7702Notice;
  String? get eip7702Notice => _$this._eip7702Notice;
  set eip7702Notice(String? eip7702Notice) =>
      _$this._eip7702Notice = eip7702Notice;

  OrderActionGasPaymentBuilder() {
    OrderActionGasPayment._defaults(this);
  }

  OrderActionGasPaymentBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mode = $v.mode;
      _decision = $v.decision;
      _platformPays = $v.platformPays;
      _nativeAsset = $v.nativeAsset;
      _estimatedNativeFee = $v.estimatedNativeFee;
      _estimatedFeeUsd = $v.estimatedFeeUsd;
      _walletNativeBalance = $v.walletNativeBalance;
      _fallbackAllowed = $v.fallbackAllowed;
      _eip7702Required = $v.eip7702Required;
      _eip7702Notice = $v.eip7702Notice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderActionGasPayment other) {
    _$v = other as _$OrderActionGasPayment;
  }

  @override
  void update(void Function(OrderActionGasPaymentBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderActionGasPayment build() => _build();

  _$OrderActionGasPayment _build() {
    final _$result = _$v ??
        _$OrderActionGasPayment._(
          mode: BuiltValueNullFieldError.checkNotNull(
              mode, r'OrderActionGasPayment', 'mode'),
          decision: decision,
          platformPays: platformPays,
          nativeAsset: nativeAsset,
          estimatedNativeFee: estimatedNativeFee,
          estimatedFeeUsd: estimatedFeeUsd,
          walletNativeBalance: walletNativeBalance,
          fallbackAllowed: fallbackAllowed,
          eip7702Required: eip7702Required,
          eip7702Notice: eip7702Notice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
