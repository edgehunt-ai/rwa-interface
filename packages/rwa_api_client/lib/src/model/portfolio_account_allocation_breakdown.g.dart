// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_account_allocation_breakdown.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioAccountAllocationBreakdown
    extends PortfolioAccountAllocationBreakdown {
  @override
  final PortfolioAllocationValue? cash;
  @override
  final PortfolioAllocationValue? bstocks;
  @override
  final String? crossMarginUsedUsd;
  @override
  final String? isolatedMarginUsedUsd;
  @override
  final PortfolioOpenOrderMarginEstimate? openOrderMarginEstimate;
  @override
  final String? estimatedWithdrawableUsd;
  @override
  final PortfolioCrossLiquidationRisk? crossLiquidationRisk;

  factory _$PortfolioAccountAllocationBreakdown(
          [void Function(PortfolioAccountAllocationBreakdownBuilder)?
              updates]) =>
      (PortfolioAccountAllocationBreakdownBuilder()..update(updates))._build();

  _$PortfolioAccountAllocationBreakdown._(
      {this.cash,
      this.bstocks,
      this.crossMarginUsedUsd,
      this.isolatedMarginUsedUsd,
      this.openOrderMarginEstimate,
      this.estimatedWithdrawableUsd,
      this.crossLiquidationRisk})
      : super._();
  @override
  PortfolioAccountAllocationBreakdown rebuild(
          void Function(PortfolioAccountAllocationBreakdownBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioAccountAllocationBreakdownBuilder toBuilder() =>
      PortfolioAccountAllocationBreakdownBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioAccountAllocationBreakdown &&
        cash == other.cash &&
        bstocks == other.bstocks &&
        crossMarginUsedUsd == other.crossMarginUsedUsd &&
        isolatedMarginUsedUsd == other.isolatedMarginUsedUsd &&
        openOrderMarginEstimate == other.openOrderMarginEstimate &&
        estimatedWithdrawableUsd == other.estimatedWithdrawableUsd &&
        crossLiquidationRisk == other.crossLiquidationRisk;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, cash.hashCode);
    _$hash = $jc(_$hash, bstocks.hashCode);
    _$hash = $jc(_$hash, crossMarginUsedUsd.hashCode);
    _$hash = $jc(_$hash, isolatedMarginUsedUsd.hashCode);
    _$hash = $jc(_$hash, openOrderMarginEstimate.hashCode);
    _$hash = $jc(_$hash, estimatedWithdrawableUsd.hashCode);
    _$hash = $jc(_$hash, crossLiquidationRisk.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioAccountAllocationBreakdown')
          ..add('cash', cash)
          ..add('bstocks', bstocks)
          ..add('crossMarginUsedUsd', crossMarginUsedUsd)
          ..add('isolatedMarginUsedUsd', isolatedMarginUsedUsd)
          ..add('openOrderMarginEstimate', openOrderMarginEstimate)
          ..add('estimatedWithdrawableUsd', estimatedWithdrawableUsd)
          ..add('crossLiquidationRisk', crossLiquidationRisk))
        .toString();
  }
}

class PortfolioAccountAllocationBreakdownBuilder
    implements
        Builder<PortfolioAccountAllocationBreakdown,
            PortfolioAccountAllocationBreakdownBuilder> {
  _$PortfolioAccountAllocationBreakdown? _$v;

  PortfolioAllocationValueBuilder? _cash;
  PortfolioAllocationValueBuilder get cash =>
      _$this._cash ??= PortfolioAllocationValueBuilder();
  set cash(PortfolioAllocationValueBuilder? cash) => _$this._cash = cash;

  PortfolioAllocationValueBuilder? _bstocks;
  PortfolioAllocationValueBuilder get bstocks =>
      _$this._bstocks ??= PortfolioAllocationValueBuilder();
  set bstocks(PortfolioAllocationValueBuilder? bstocks) =>
      _$this._bstocks = bstocks;

  String? _crossMarginUsedUsd;
  String? get crossMarginUsedUsd => _$this._crossMarginUsedUsd;
  set crossMarginUsedUsd(String? crossMarginUsedUsd) =>
      _$this._crossMarginUsedUsd = crossMarginUsedUsd;

  String? _isolatedMarginUsedUsd;
  String? get isolatedMarginUsedUsd => _$this._isolatedMarginUsedUsd;
  set isolatedMarginUsedUsd(String? isolatedMarginUsedUsd) =>
      _$this._isolatedMarginUsedUsd = isolatedMarginUsedUsd;

  PortfolioOpenOrderMarginEstimateBuilder? _openOrderMarginEstimate;
  PortfolioOpenOrderMarginEstimateBuilder get openOrderMarginEstimate =>
      _$this._openOrderMarginEstimate ??=
          PortfolioOpenOrderMarginEstimateBuilder();
  set openOrderMarginEstimate(
          PortfolioOpenOrderMarginEstimateBuilder? openOrderMarginEstimate) =>
      _$this._openOrderMarginEstimate = openOrderMarginEstimate;

  String? _estimatedWithdrawableUsd;
  String? get estimatedWithdrawableUsd => _$this._estimatedWithdrawableUsd;
  set estimatedWithdrawableUsd(String? estimatedWithdrawableUsd) =>
      _$this._estimatedWithdrawableUsd = estimatedWithdrawableUsd;

  PortfolioCrossLiquidationRiskBuilder? _crossLiquidationRisk;
  PortfolioCrossLiquidationRiskBuilder get crossLiquidationRisk =>
      _$this._crossLiquidationRisk ??= PortfolioCrossLiquidationRiskBuilder();
  set crossLiquidationRisk(
          PortfolioCrossLiquidationRiskBuilder? crossLiquidationRisk) =>
      _$this._crossLiquidationRisk = crossLiquidationRisk;

  PortfolioAccountAllocationBreakdownBuilder() {
    PortfolioAccountAllocationBreakdown._defaults(this);
  }

  PortfolioAccountAllocationBreakdownBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _cash = $v.cash?.toBuilder();
      _bstocks = $v.bstocks?.toBuilder();
      _crossMarginUsedUsd = $v.crossMarginUsedUsd;
      _isolatedMarginUsedUsd = $v.isolatedMarginUsedUsd;
      _openOrderMarginEstimate = $v.openOrderMarginEstimate?.toBuilder();
      _estimatedWithdrawableUsd = $v.estimatedWithdrawableUsd;
      _crossLiquidationRisk = $v.crossLiquidationRisk?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioAccountAllocationBreakdown other) {
    _$v = other as _$PortfolioAccountAllocationBreakdown;
  }

  @override
  void update(
      void Function(PortfolioAccountAllocationBreakdownBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioAccountAllocationBreakdown build() => _build();

  _$PortfolioAccountAllocationBreakdown _build() {
    _$PortfolioAccountAllocationBreakdown _$result;
    try {
      _$result = _$v ??
          _$PortfolioAccountAllocationBreakdown._(
            cash: _cash?.build(),
            bstocks: _bstocks?.build(),
            crossMarginUsedUsd: crossMarginUsedUsd,
            isolatedMarginUsedUsd: isolatedMarginUsedUsd,
            openOrderMarginEstimate: _openOrderMarginEstimate?.build(),
            estimatedWithdrawableUsd: estimatedWithdrawableUsd,
            crossLiquidationRisk: _crossLiquidationRisk?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'cash';
        _cash?.build();
        _$failedField = 'bstocks';
        _bstocks?.build();

        _$failedField = 'openOrderMarginEstimate';
        _openOrderMarginEstimate?.build();

        _$failedField = 'crossLiquidationRisk';
        _crossLiquidationRisk?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(r'PortfolioAccountAllocationBreakdown',
            _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
