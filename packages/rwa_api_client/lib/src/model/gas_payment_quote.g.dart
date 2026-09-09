// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gas_payment_quote.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GasPaymentQuote extends GasPaymentQuote {
  @override
  final GasPaymentMode mode;
  @override
  final GasSponsorshipDecision decision;
  @override
  final bool platformPays;
  @override
  final String nativeAsset;
  @override
  final String estimatedNativeFee;
  @override
  final String estimatedFeeUsd;
  @override
  final String? walletNativeBalance;
  @override
  final bool fallbackAllowed;
  @override
  final bool eip7702Required;
  @override
  final String? eip7702Notice;

  factory _$GasPaymentQuote([void Function(GasPaymentQuoteBuilder)? updates]) =>
      (GasPaymentQuoteBuilder()..update(updates))._build();

  _$GasPaymentQuote._(
      {required this.mode,
      required this.decision,
      required this.platformPays,
      required this.nativeAsset,
      required this.estimatedNativeFee,
      required this.estimatedFeeUsd,
      this.walletNativeBalance,
      required this.fallbackAllowed,
      required this.eip7702Required,
      this.eip7702Notice})
      : super._();
  @override
  GasPaymentQuote rebuild(void Function(GasPaymentQuoteBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GasPaymentQuoteBuilder toBuilder() => GasPaymentQuoteBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GasPaymentQuote &&
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
    return (newBuiltValueToStringHelper(r'GasPaymentQuote')
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

class GasPaymentQuoteBuilder
    implements Builder<GasPaymentQuote, GasPaymentQuoteBuilder> {
  _$GasPaymentQuote? _$v;

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

  GasPaymentQuoteBuilder() {
    GasPaymentQuote._defaults(this);
  }

  GasPaymentQuoteBuilder get _$this {
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
  void replace(GasPaymentQuote other) {
    _$v = other as _$GasPaymentQuote;
  }

  @override
  void update(void Function(GasPaymentQuoteBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GasPaymentQuote build() => _build();

  _$GasPaymentQuote _build() {
    final _$result = _$v ??
        _$GasPaymentQuote._(
          mode: BuiltValueNullFieldError.checkNotNull(
              mode, r'GasPaymentQuote', 'mode'),
          decision: BuiltValueNullFieldError.checkNotNull(
              decision, r'GasPaymentQuote', 'decision'),
          platformPays: BuiltValueNullFieldError.checkNotNull(
              platformPays, r'GasPaymentQuote', 'platformPays'),
          nativeAsset: BuiltValueNullFieldError.checkNotNull(
              nativeAsset, r'GasPaymentQuote', 'nativeAsset'),
          estimatedNativeFee: BuiltValueNullFieldError.checkNotNull(
              estimatedNativeFee, r'GasPaymentQuote', 'estimatedNativeFee'),
          estimatedFeeUsd: BuiltValueNullFieldError.checkNotNull(
              estimatedFeeUsd, r'GasPaymentQuote', 'estimatedFeeUsd'),
          walletNativeBalance: walletNativeBalance,
          fallbackAllowed: BuiltValueNullFieldError.checkNotNull(
              fallbackAllowed, r'GasPaymentQuote', 'fallbackAllowed'),
          eip7702Required: BuiltValueNullFieldError.checkNotNull(
              eip7702Required, r'GasPaymentQuote', 'eip7702Required'),
          eip7702Notice: eip7702Notice,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
