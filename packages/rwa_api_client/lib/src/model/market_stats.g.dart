// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_stats.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MarketStats extends MarketStats {
  @override
  final String? high24h;
  @override
  final String? low24h;
  @override
  final String? turnover24hUsd;
  @override
  final String? volume24h;
  @override
  final String? volume24hUnit;
  @override
  final String? referenceLabel;
  @override
  final String? referencePrice;
  @override
  final String? relativeLabel;
  @override
  final String? relativePercent;
  @override
  final String? spreadPercent;
  @override
  final String? bestBid;
  @override
  final String? bestAsk;
  @override
  final String? fundingRate;
  @override
  final DateTime? nextFundingAt;
  @override
  final String? openInterestUsd;

  factory _$MarketStats([void Function(MarketStatsBuilder)? updates]) =>
      (MarketStatsBuilder()..update(updates))._build();

  _$MarketStats._(
      {this.high24h,
      this.low24h,
      this.turnover24hUsd,
      this.volume24h,
      this.volume24hUnit,
      this.referenceLabel,
      this.referencePrice,
      this.relativeLabel,
      this.relativePercent,
      this.spreadPercent,
      this.bestBid,
      this.bestAsk,
      this.fundingRate,
      this.nextFundingAt,
      this.openInterestUsd})
      : super._();
  @override
  MarketStats rebuild(void Function(MarketStatsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MarketStatsBuilder toBuilder() => MarketStatsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MarketStats &&
        high24h == other.high24h &&
        low24h == other.low24h &&
        turnover24hUsd == other.turnover24hUsd &&
        volume24h == other.volume24h &&
        volume24hUnit == other.volume24hUnit &&
        referenceLabel == other.referenceLabel &&
        referencePrice == other.referencePrice &&
        relativeLabel == other.relativeLabel &&
        relativePercent == other.relativePercent &&
        spreadPercent == other.spreadPercent &&
        bestBid == other.bestBid &&
        bestAsk == other.bestAsk &&
        fundingRate == other.fundingRate &&
        nextFundingAt == other.nextFundingAt &&
        openInterestUsd == other.openInterestUsd;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, high24h.hashCode);
    _$hash = $jc(_$hash, low24h.hashCode);
    _$hash = $jc(_$hash, turnover24hUsd.hashCode);
    _$hash = $jc(_$hash, volume24h.hashCode);
    _$hash = $jc(_$hash, volume24hUnit.hashCode);
    _$hash = $jc(_$hash, referenceLabel.hashCode);
    _$hash = $jc(_$hash, referencePrice.hashCode);
    _$hash = $jc(_$hash, relativeLabel.hashCode);
    _$hash = $jc(_$hash, relativePercent.hashCode);
    _$hash = $jc(_$hash, spreadPercent.hashCode);
    _$hash = $jc(_$hash, bestBid.hashCode);
    _$hash = $jc(_$hash, bestAsk.hashCode);
    _$hash = $jc(_$hash, fundingRate.hashCode);
    _$hash = $jc(_$hash, nextFundingAt.hashCode);
    _$hash = $jc(_$hash, openInterestUsd.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MarketStats')
          ..add('high24h', high24h)
          ..add('low24h', low24h)
          ..add('turnover24hUsd', turnover24hUsd)
          ..add('volume24h', volume24h)
          ..add('volume24hUnit', volume24hUnit)
          ..add('referenceLabel', referenceLabel)
          ..add('referencePrice', referencePrice)
          ..add('relativeLabel', relativeLabel)
          ..add('relativePercent', relativePercent)
          ..add('spreadPercent', spreadPercent)
          ..add('bestBid', bestBid)
          ..add('bestAsk', bestAsk)
          ..add('fundingRate', fundingRate)
          ..add('nextFundingAt', nextFundingAt)
          ..add('openInterestUsd', openInterestUsd))
        .toString();
  }
}

class MarketStatsBuilder implements Builder<MarketStats, MarketStatsBuilder> {
  _$MarketStats? _$v;

  String? _high24h;
  String? get high24h => _$this._high24h;
  set high24h(String? high24h) => _$this._high24h = high24h;

  String? _low24h;
  String? get low24h => _$this._low24h;
  set low24h(String? low24h) => _$this._low24h = low24h;

  String? _turnover24hUsd;
  String? get turnover24hUsd => _$this._turnover24hUsd;
  set turnover24hUsd(String? turnover24hUsd) =>
      _$this._turnover24hUsd = turnover24hUsd;

  String? _volume24h;
  String? get volume24h => _$this._volume24h;
  set volume24h(String? volume24h) => _$this._volume24h = volume24h;

  String? _volume24hUnit;
  String? get volume24hUnit => _$this._volume24hUnit;
  set volume24hUnit(String? volume24hUnit) =>
      _$this._volume24hUnit = volume24hUnit;

  String? _referenceLabel;
  String? get referenceLabel => _$this._referenceLabel;
  set referenceLabel(String? referenceLabel) =>
      _$this._referenceLabel = referenceLabel;

  String? _referencePrice;
  String? get referencePrice => _$this._referencePrice;
  set referencePrice(String? referencePrice) =>
      _$this._referencePrice = referencePrice;

  String? _relativeLabel;
  String? get relativeLabel => _$this._relativeLabel;
  set relativeLabel(String? relativeLabel) =>
      _$this._relativeLabel = relativeLabel;

  String? _relativePercent;
  String? get relativePercent => _$this._relativePercent;
  set relativePercent(String? relativePercent) =>
      _$this._relativePercent = relativePercent;

  String? _spreadPercent;
  String? get spreadPercent => _$this._spreadPercent;
  set spreadPercent(String? spreadPercent) =>
      _$this._spreadPercent = spreadPercent;

  String? _bestBid;
  String? get bestBid => _$this._bestBid;
  set bestBid(String? bestBid) => _$this._bestBid = bestBid;

  String? _bestAsk;
  String? get bestAsk => _$this._bestAsk;
  set bestAsk(String? bestAsk) => _$this._bestAsk = bestAsk;

  String? _fundingRate;
  String? get fundingRate => _$this._fundingRate;
  set fundingRate(String? fundingRate) => _$this._fundingRate = fundingRate;

  DateTime? _nextFundingAt;
  DateTime? get nextFundingAt => _$this._nextFundingAt;
  set nextFundingAt(DateTime? nextFundingAt) =>
      _$this._nextFundingAt = nextFundingAt;

  String? _openInterestUsd;
  String? get openInterestUsd => _$this._openInterestUsd;
  set openInterestUsd(String? openInterestUsd) =>
      _$this._openInterestUsd = openInterestUsd;

  MarketStatsBuilder() {
    MarketStats._defaults(this);
  }

  MarketStatsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _high24h = $v.high24h;
      _low24h = $v.low24h;
      _turnover24hUsd = $v.turnover24hUsd;
      _volume24h = $v.volume24h;
      _volume24hUnit = $v.volume24hUnit;
      _referenceLabel = $v.referenceLabel;
      _referencePrice = $v.referencePrice;
      _relativeLabel = $v.relativeLabel;
      _relativePercent = $v.relativePercent;
      _spreadPercent = $v.spreadPercent;
      _bestBid = $v.bestBid;
      _bestAsk = $v.bestAsk;
      _fundingRate = $v.fundingRate;
      _nextFundingAt = $v.nextFundingAt;
      _openInterestUsd = $v.openInterestUsd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MarketStats other) {
    _$v = other as _$MarketStats;
  }

  @override
  void update(void Function(MarketStatsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MarketStats build() => _build();

  _$MarketStats _build() {
    final _$result = _$v ??
        _$MarketStats._(
          high24h: high24h,
          low24h: low24h,
          turnover24hUsd: turnover24hUsd,
          volume24h: volume24h,
          volume24hUnit: volume24hUnit,
          referenceLabel: referenceLabel,
          referencePrice: referencePrice,
          relativeLabel: relativeLabel,
          relativePercent: relativePercent,
          spreadPercent: spreadPercent,
          bestBid: bestBid,
          bestAsk: bestAsk,
          fundingRate: fundingRate,
          nextFundingAt: nextFundingAt,
          openInterestUsd: openInterestUsd,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
