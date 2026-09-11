// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_history_point.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PortfolioHistoryPoint extends PortfolioHistoryPoint {
  @override
  final DateTime timestamp;
  @override
  final String totalValueUsd;
  @override
  final String? netExternalCashFlowUsd;
  @override
  final String? pnlUsd;
  @override
  final String? pnlPercent;

  factory _$PortfolioHistoryPoint(
          [void Function(PortfolioHistoryPointBuilder)? updates]) =>
      (PortfolioHistoryPointBuilder()..update(updates))._build();

  _$PortfolioHistoryPoint._(
      {required this.timestamp,
      required this.totalValueUsd,
      this.netExternalCashFlowUsd,
      this.pnlUsd,
      this.pnlPercent})
      : super._();
  @override
  PortfolioHistoryPoint rebuild(
          void Function(PortfolioHistoryPointBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PortfolioHistoryPointBuilder toBuilder() =>
      PortfolioHistoryPointBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PortfolioHistoryPoint &&
        timestamp == other.timestamp &&
        totalValueUsd == other.totalValueUsd &&
        netExternalCashFlowUsd == other.netExternalCashFlowUsd &&
        pnlUsd == other.pnlUsd &&
        pnlPercent == other.pnlPercent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, timestamp.hashCode);
    _$hash = $jc(_$hash, totalValueUsd.hashCode);
    _$hash = $jc(_$hash, netExternalCashFlowUsd.hashCode);
    _$hash = $jc(_$hash, pnlUsd.hashCode);
    _$hash = $jc(_$hash, pnlPercent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PortfolioHistoryPoint')
          ..add('timestamp', timestamp)
          ..add('totalValueUsd', totalValueUsd)
          ..add('netExternalCashFlowUsd', netExternalCashFlowUsd)
          ..add('pnlUsd', pnlUsd)
          ..add('pnlPercent', pnlPercent))
        .toString();
  }
}

class PortfolioHistoryPointBuilder
    implements Builder<PortfolioHistoryPoint, PortfolioHistoryPointBuilder> {
  _$PortfolioHistoryPoint? _$v;

  DateTime? _timestamp;
  DateTime? get timestamp => _$this._timestamp;
  set timestamp(DateTime? timestamp) => _$this._timestamp = timestamp;

  String? _totalValueUsd;
  String? get totalValueUsd => _$this._totalValueUsd;
  set totalValueUsd(String? totalValueUsd) =>
      _$this._totalValueUsd = totalValueUsd;

  String? _netExternalCashFlowUsd;
  String? get netExternalCashFlowUsd => _$this._netExternalCashFlowUsd;
  set netExternalCashFlowUsd(String? netExternalCashFlowUsd) =>
      _$this._netExternalCashFlowUsd = netExternalCashFlowUsd;

  String? _pnlUsd;
  String? get pnlUsd => _$this._pnlUsd;
  set pnlUsd(String? pnlUsd) => _$this._pnlUsd = pnlUsd;

  String? _pnlPercent;
  String? get pnlPercent => _$this._pnlPercent;
  set pnlPercent(String? pnlPercent) => _$this._pnlPercent = pnlPercent;

  PortfolioHistoryPointBuilder() {
    PortfolioHistoryPoint._defaults(this);
  }

  PortfolioHistoryPointBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _timestamp = $v.timestamp;
      _totalValueUsd = $v.totalValueUsd;
      _netExternalCashFlowUsd = $v.netExternalCashFlowUsd;
      _pnlUsd = $v.pnlUsd;
      _pnlPercent = $v.pnlPercent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PortfolioHistoryPoint other) {
    _$v = other as _$PortfolioHistoryPoint;
  }

  @override
  void update(void Function(PortfolioHistoryPointBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PortfolioHistoryPoint build() => _build();

  _$PortfolioHistoryPoint _build() {
    final _$result = _$v ??
        _$PortfolioHistoryPoint._(
          timestamp: BuiltValueNullFieldError.checkNotNull(
              timestamp, r'PortfolioHistoryPoint', 'timestamp'),
          totalValueUsd: BuiltValueNullFieldError.checkNotNull(
              totalValueUsd, r'PortfolioHistoryPoint', 'totalValueUsd'),
          netExternalCashFlowUsd: netExternalCashFlowUsd,
          pnlUsd: pnlUsd,
          pnlPercent: pnlPercent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
