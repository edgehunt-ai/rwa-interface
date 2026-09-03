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
  final String? marginInUseUsd;
  @override
  final String? stocksValueUsd;
  @override
  final DateTime? updatedAt;

  factory _$PortfolioSummary(
          [void Function(PortfolioSummaryBuilder)? updates]) =>
      (PortfolioSummaryBuilder()..update(updates))._build();

  _$PortfolioSummary._(
      {required this.totalValueUsd,
      this.todayPnlUsd,
      this.todayPnlPercent,
      required this.availableToTradeUsd,
      this.marginInUseUsd,
      this.stocksValueUsd,
      this.updatedAt})
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
        marginInUseUsd == other.marginInUseUsd &&
        stocksValueUsd == other.stocksValueUsd &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, totalValueUsd.hashCode);
    _$hash = $jc(_$hash, todayPnlUsd.hashCode);
    _$hash = $jc(_$hash, todayPnlPercent.hashCode);
    _$hash = $jc(_$hash, availableToTradeUsd.hashCode);
    _$hash = $jc(_$hash, marginInUseUsd.hashCode);
    _$hash = $jc(_$hash, stocksValueUsd.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
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
          ..add('marginInUseUsd', marginInUseUsd)
          ..add('stocksValueUsd', stocksValueUsd)
          ..add('updatedAt', updatedAt))
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

  String? _marginInUseUsd;
  String? get marginInUseUsd => _$this._marginInUseUsd;
  set marginInUseUsd(String? marginInUseUsd) =>
      _$this._marginInUseUsd = marginInUseUsd;

  String? _stocksValueUsd;
  String? get stocksValueUsd => _$this._stocksValueUsd;
  set stocksValueUsd(String? stocksValueUsd) =>
      _$this._stocksValueUsd = stocksValueUsd;

  DateTime? _updatedAt;
  DateTime? get updatedAt => _$this._updatedAt;
  set updatedAt(DateTime? updatedAt) => _$this._updatedAt = updatedAt;

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
      _marginInUseUsd = $v.marginInUseUsd;
      _stocksValueUsd = $v.stocksValueUsd;
      _updatedAt = $v.updatedAt;
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
    final _$result = _$v ??
        _$PortfolioSummary._(
          totalValueUsd: BuiltValueNullFieldError.checkNotNull(
              totalValueUsd, r'PortfolioSummary', 'totalValueUsd'),
          todayPnlUsd: todayPnlUsd,
          todayPnlPercent: todayPnlPercent,
          availableToTradeUsd: BuiltValueNullFieldError.checkNotNull(
              availableToTradeUsd, r'PortfolioSummary', 'availableToTradeUsd'),
          marginInUseUsd: marginInUseUsd,
          stocksValueUsd: stocksValueUsd,
          updatedAt: updatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
