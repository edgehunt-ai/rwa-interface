// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioSummary extends PortfolioSummary {
  @override
  final String totalValueUsd;
  @override
  final String? todayPnlUsd;
  @override
  final String? todayPnlPercent;
  @override
  final String availableToTradeUsd;
  @override
  final String? pendingTransferUsd;
  @override
  final String marginInUseUsd;
  @override
  final BuiltList<HyperliquidUsdcCollateral>? hyperliquidUsdcCollateral;
  @override
  final String? stocksValueUsd;
  @override
  final int unvaluedAssetCount;
  @override
  final PortfolioDataStatus dataStatus;
  @override
  final PortfolioFreshness freshness;
  @override
  final DateTime calculatedAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? oldestObservationAt;
  @override
  final BuiltList<PortfolioNotice> warnings;
  @override
  final BuiltList<PortfolioSourceSummary> sources;

  factory _$PortfolioSummary(
          [void Function(PortfolioSummaryBuilder)? updates]) =>
      (PortfolioSummaryBuilder()..update(updates))._build();

  _$PortfolioSummary._(
      {required this.totalValueUsd,
      this.todayPnlUsd,
      this.todayPnlPercent,
      required this.availableToTradeUsd,
      this.pendingTransferUsd,
      required this.marginInUseUsd,
      this.hyperliquidUsdcCollateral,
      this.stocksValueUsd,
      required this.unvaluedAssetCount,
      required this.dataStatus,
      required this.freshness,
      required this.calculatedAt,
      this.updatedAt,
      this.oldestObservationAt,
      required this.warnings,
      required this.sources})
      : super._();
  @override
  PortfolioSummary rebuild(void Function(PortfolioSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioSummaryBuilder toBuilder() =>
      PortfolioSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioSummary &&
        totalValueUsd == other.totalValueUsd &&
        todayPnlUsd == other.todayPnlUsd &&
        todayPnlPercent == other.todayPnlPercent &&
        availableToTradeUsd == other.availableToTradeUsd &&
        pendingTransferUsd == other.pendingTransferUsd &&
        marginInUseUsd == other.marginInUseUsd &&
        hyperliquidUsdcCollateral == other.hyperliquidUsdcCollateral &&
        stocksValueUsd == other.stocksValueUsd &&
        unvaluedAssetCount == other.unvaluedAssetCount &&
        dataStatus == other.dataStatus &&
        freshness == other.freshness &&
        calculatedAt == other.calculatedAt &&
        updatedAt == other.updatedAt &&
        oldestObservationAt == other.oldestObservationAt &&
        warnings == other.warnings &&
        sources == other.sources;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalValueUsd.hashCode);
    _$hash = $jc(_$hash, todayPnlUsd.hashCode);
    _$hash = $jc(_$hash, todayPnlPercent.hashCode);
    _$hash = $jc(_$hash, availableToTradeUsd.hashCode);
    _$hash = $jc(_$hash, pendingTransferUsd.hashCode);
    _$hash = $jc(_$hash, marginInUseUsd.hashCode);
    _$hash = $jc(_$hash, hyperliquidUsdcCollateral.hashCode);
    _$hash = $jc(_$hash, stocksValueUsd.hashCode);
    _$hash = $jc(_$hash, unvaluedAssetCount.hashCode);
    _$hash = $jc(_$hash, dataStatus.hashCode);
    _$hash = $jc(_$hash, freshness.hashCode);
    _$hash = $jc(_$hash, calculatedAt.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jc(_$hash, oldestObservationAt.hashCode);
    _$hash = $jc(_$hash, warnings.hashCode);
    _$hash = $jc(_$hash, sources.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioSummary')
          ..add('totalValueUsd', totalValueUsd)
          ..add('todayPnlUsd', todayPnlUsd)
          ..add('todayPnlPercent', todayPnlPercent)
          ..add('availableToTradeUsd', availableToTradeUsd)
          ..add('pendingTransferUsd', pendingTransferUsd)
          ..add('marginInUseUsd', marginInUseUsd)
          ..add('hyperliquidUsdcCollateral', hyperliquidUsdcCollateral)
          ..add('stocksValueUsd', stocksValueUsd)
          ..add('unvaluedAssetCount', unvaluedAssetCount)
          ..add('dataStatus', dataStatus)
          ..add('freshness', freshness)
          ..add('calculatedAt', calculatedAt)
          ..add('updatedAt', updatedAt)
          ..add('oldestObservationAt', oldestObservationAt)
          ..add('warnings', warnings)
          ..add('sources', sources))
        .toString();
  }
}

class PortfolioSummaryBuilder
    implements Builder<PortfolioSummary, PortfolioSummaryBuilder> {
  _$PortfolioSummary? _$v;

  String? _totalValueUsd;
  String? get totalValueUsd => _$this._totalValueUsd;
  set totalValueUsd(String? totalValueUsd) =>
      _$this._totalValueUsd = totalValueUsd;

  String? _todayPnlUsd;
  String? get todayPnlUsd => _$this._todayPnlUsd;
  set todayPnlUsd(String? todayPnlUsd) => _$this._todayPnlUsd = todayPnlUsd;

  String? _todayPnlPercent;
  String? get todayPnlPercent => _$this._todayPnlPercent;
  set todayPnlPercent(String? todayPnlPercent) =>
      _$this._todayPnlPercent = todayPnlPercent;

  String? _availableToTradeUsd;
  String? get availableToTradeUsd => _$this._availableToTradeUsd;
  set availableToTradeUsd(String? availableToTradeUsd) =>
      _$this._availableToTradeUsd = availableToTradeUsd;

  String? _pendingTransferUsd;
  String? get pendingTransferUsd => _$this._pendingTransferUsd;
  set pendingTransferUsd(String? pendingTransferUsd) =>
      _$this._pendingTransferUsd = pendingTransferUsd;

  String? _marginInUseUsd;
  String? get marginInUseUsd => _$this._marginInUseUsd;
  set marginInUseUsd(String? marginInUseUsd) =>
      _$this._marginInUseUsd = marginInUseUsd;

  ListBuilder<HyperliquidUsdcCollateral>? _hyperliquidUsdcCollateral;
  ListBuilder<HyperliquidUsdcCollateral> get hyperliquidUsdcCollateral =>
      _$this._hyperliquidUsdcCollateral ??=
          ListBuilder<HyperliquidUsdcCollateral>();
  set hyperliquidUsdcCollateral(
          ListBuilder<HyperliquidUsdcCollateral>? hyperliquidUsdcCollateral) =>
      _$this._hyperliquidUsdcCollateral = hyperliquidUsdcCollateral;

  String? _stocksValueUsd;
  String? get stocksValueUsd => _$this._stocksValueUsd;
  set stocksValueUsd(String? stocksValueUsd) =>
      _$this._stocksValueUsd = stocksValueUsd;

  int? _unvaluedAssetCount;
  int? get unvaluedAssetCount => _$this._unvaluedAssetCount;
  set unvaluedAssetCount(int? unvaluedAssetCount) =>
      _$this._unvaluedAssetCount = unvaluedAssetCount;

  PortfolioDataStatus? _dataStatus;
  PortfolioDataStatus? get dataStatus => _$this._dataStatus;
  set dataStatus(PortfolioDataStatus? dataStatus) =>
      _$this._dataStatus = dataStatus;

  PortfolioFreshness? _freshness;
  PortfolioFreshness? get freshness => _$this._freshness;
  set freshness(PortfolioFreshness? freshness) => _$this._freshness = freshness;

  DateTime? _calculatedAt;
  DateTime? get calculatedAt => _$this._calculatedAt;
  set calculatedAt(DateTime? calculatedAt) =>
      _$this._calculatedAt = calculatedAt;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

  DateTime? _oldestObservationAt;
  DateTime? get oldestObservationAt => _$this._oldestObservationAt;
  set oldestObservationAt(DateTime? oldestObservationAt) =>
      _$this._oldestObservationAt = oldestObservationAt;

  ListBuilder<PortfolioNotice>? _warnings;
  ListBuilder<PortfolioNotice> get warnings =>
      _$this._warnings ??= ListBuilder<PortfolioNotice>();
  set warnings(ListBuilder<PortfolioNotice>? warnings) =>
      _$this._warnings = warnings;

  ListBuilder<PortfolioSourceSummary>? _sources;
  ListBuilder<PortfolioSourceSummary> get sources =>
      _$this._sources ??= ListBuilder<PortfolioSourceSummary>();
  set sources(ListBuilder<PortfolioSourceSummary>? sources) =>
      _$this._sources = sources;

  PortfolioSummaryBuilder() {
    PortfolioSummary._defaults(this);
  }

  PortfolioSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _totalValueUsd = $v.totalValueUsd;
      _todayPnlUsd = $v.todayPnlUsd;
      _todayPnlPercent = $v.todayPnlPercent;
      _availableToTradeUsd = $v.availableToTradeUsd;
      _pendingTransferUsd = $v.pendingTransferUsd;
      _marginInUseUsd = $v.marginInUseUsd;
      _hyperliquidUsdcCollateral = $v.hyperliquidUsdcCollateral?.toBuilder();
      _stocksValueUsd = $v.stocksValueUsd;
      _unvaluedAssetCount = $v.unvaluedAssetCount;
      _dataStatus = $v.dataStatus;
      _freshness = $v.freshness;
      _calculatedAt = $v.calculatedAt;
      _updatedAt = $v.updatedAt;
      _oldestObservationAt = $v.oldestObservationAt;
      _warnings = $v.warnings.toBuilder();
      _sources = $v.sources.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioSummary other) {
    _$v = other as _$PortfolioSummary;
  }

  @override
  void update(void Function(PortfolioSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioSummary build() => _build();

  _$PortfolioSummary _build() {
    _$PortfolioSummary _$result;
    try {
      _$result = _$v ??
          _$PortfolioSummary._(
            totalValueUsd: BuiltValueNullFieldError.checkNotNull(
                totalValueUsd, r'PortfolioSummary', 'totalValueUsd'),
            todayPnlUsd: todayPnlUsd,
            todayPnlPercent: todayPnlPercent,
            availableToTradeUsd: BuiltValueNullFieldError.checkNotNull(
                availableToTradeUsd,
                r'PortfolioSummary',
                'availableToTradeUsd'),
            pendingTransferUsd: pendingTransferUsd,
            marginInUseUsd: BuiltValueNullFieldError.checkNotNull(
                marginInUseUsd, r'PortfolioSummary', 'marginInUseUsd'),
            hyperliquidUsdcCollateral: _hyperliquidUsdcCollateral?.build(),
            stocksValueUsd: stocksValueUsd,
            unvaluedAssetCount: BuiltValueNullFieldError.checkNotNull(
                unvaluedAssetCount, r'PortfolioSummary', 'unvaluedAssetCount'),
            dataStatus: BuiltValueNullFieldError.checkNotNull(
                dataStatus, r'PortfolioSummary', 'dataStatus'),
            freshness: BuiltValueNullFieldError.checkNotNull(
                freshness, r'PortfolioSummary', 'freshness'),
            calculatedAt: BuiltValueNullFieldError.checkNotNull(
                calculatedAt, r'PortfolioSummary', 'calculatedAt'),
            updatedAt: updatedAt,
            oldestObservationAt: oldestObservationAt,
            warnings: warnings.build(),
            sources: sources.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'hyperliquidUsdcCollateral';
        _hyperliquidUsdcCollateral?.build();

        _$failedField = 'warnings';
        warnings.build();
        _$failedField = 'sources';
        sources.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PortfolioSummary', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
