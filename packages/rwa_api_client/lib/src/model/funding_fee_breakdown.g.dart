// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'funding_fee_breakdown.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FundingFeeBreakdown extends FundingFeeBreakdown {
  @override
  final String feeAsset;
  @override
  final String providerFee;
  @override
  final String bridgeFee;
  @override
  final String swapFee;
  @override
  final String networkFee;
  @override
  final String totalFee;
  @override
  final String totalCostUsd;

  factory _$FundingFeeBreakdown(
          [void Function(FundingFeeBreakdownBuilder)? updates]) =>
      (FundingFeeBreakdownBuilder()..update(updates))._build();

  _$FundingFeeBreakdown._(
      {required this.feeAsset,
      required this.providerFee,
      required this.bridgeFee,
      required this.swapFee,
      required this.networkFee,
      required this.totalFee,
      required this.totalCostUsd})
      : super._();
  @override
  FundingFeeBreakdown rebuild(
          void Function(FundingFeeBreakdownBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FundingFeeBreakdownBuilder toBuilder() =>
      FundingFeeBreakdownBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FundingFeeBreakdown &&
        feeAsset == other.feeAsset &&
        providerFee == other.providerFee &&
        bridgeFee == other.bridgeFee &&
        swapFee == other.swapFee &&
        networkFee == other.networkFee &&
        totalFee == other.totalFee &&
        totalCostUsd == other.totalCostUsd;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, feeAsset.hashCode);
    _$hash = $jc(_$hash, providerFee.hashCode);
    _$hash = $jc(_$hash, bridgeFee.hashCode);
    _$hash = $jc(_$hash, swapFee.hashCode);
    _$hash = $jc(_$hash, networkFee.hashCode);
    _$hash = $jc(_$hash, totalFee.hashCode);
    _$hash = $jc(_$hash, totalCostUsd.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FundingFeeBreakdown')
          ..add('feeAsset', feeAsset)
          ..add('providerFee', providerFee)
          ..add('bridgeFee', bridgeFee)
          ..add('swapFee', swapFee)
          ..add('networkFee', networkFee)
          ..add('totalFee', totalFee)
          ..add('totalCostUsd', totalCostUsd))
        .toString();
  }
}

class FundingFeeBreakdownBuilder
    implements Builder<FundingFeeBreakdown, FundingFeeBreakdownBuilder> {
  _$FundingFeeBreakdown? _$v;

  String? _feeAsset;
  String? get feeAsset => _$this._feeAsset;
  set feeAsset(String? feeAsset) => _$this._feeAsset = feeAsset;

  String? _providerFee;
  String? get providerFee => _$this._providerFee;
  set providerFee(String? providerFee) => _$this._providerFee = providerFee;

  String? _bridgeFee;
  String? get bridgeFee => _$this._bridgeFee;
  set bridgeFee(String? bridgeFee) => _$this._bridgeFee = bridgeFee;

  String? _swapFee;
  String? get swapFee => _$this._swapFee;
  set swapFee(String? swapFee) => _$this._swapFee = swapFee;

  String? _networkFee;
  String? get networkFee => _$this._networkFee;
  set networkFee(String? networkFee) => _$this._networkFee = networkFee;

  String? _totalFee;
  String? get totalFee => _$this._totalFee;
  set totalFee(String? totalFee) => _$this._totalFee = totalFee;

  String? _totalCostUsd;
  String? get totalCostUsd => _$this._totalCostUsd;
  set totalCostUsd(String? totalCostUsd) => _$this._totalCostUsd = totalCostUsd;

  FundingFeeBreakdownBuilder() {
    FundingFeeBreakdown._defaults(this);
  }

  FundingFeeBreakdownBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _feeAsset = $v.feeAsset;
      _providerFee = $v.providerFee;
      _bridgeFee = $v.bridgeFee;
      _swapFee = $v.swapFee;
      _networkFee = $v.networkFee;
      _totalFee = $v.totalFee;
      _totalCostUsd = $v.totalCostUsd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FundingFeeBreakdown other) {
    _$v = other as _$FundingFeeBreakdown;
  }

  @override
  void update(void Function(FundingFeeBreakdownBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FundingFeeBreakdown build() => _build();

  _$FundingFeeBreakdown _build() {
    final _$result = _$v ??
        _$FundingFeeBreakdown._(
          feeAsset: BuiltValueNullFieldError.checkNotNull(
              feeAsset, r'FundingFeeBreakdown', 'feeAsset'),
          providerFee: BuiltValueNullFieldError.checkNotNull(
              providerFee, r'FundingFeeBreakdown', 'providerFee'),
          bridgeFee: BuiltValueNullFieldError.checkNotNull(
              bridgeFee, r'FundingFeeBreakdown', 'bridgeFee'),
          swapFee: BuiltValueNullFieldError.checkNotNull(
              swapFee, r'FundingFeeBreakdown', 'swapFee'),
          networkFee: BuiltValueNullFieldError.checkNotNull(
              networkFee, r'FundingFeeBreakdown', 'networkFee'),
          totalFee: BuiltValueNullFieldError.checkNotNull(
              totalFee, r'FundingFeeBreakdown', 'totalFee'),
          totalCostUsd: BuiltValueNullFieldError.checkNotNull(
              totalCostUsd, r'FundingFeeBreakdown', 'totalCostUsd'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
