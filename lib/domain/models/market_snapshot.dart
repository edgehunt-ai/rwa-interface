import 'decimal_value.dart';

final class AssetRight {
  const AssetRight({required this.label, required this.value});

  final String label;
  final String value;
}

enum CandleChartRange {
  oneHour('1h'),
  fourHours('4h'),
  oneDay('1d'),
  oneWeek('1w');

  const CandleChartRange(this.label);

  final String label;
}

final class OrderBookEntry {
  const OrderBookEntry({required this.price, required this.size});
  final DecimalValue price;
  final DecimalValue size;
}

final class MarketSnapshot {
  const MarketSnapshot({
    required this.price,
    this.change24hPercent,
    this.bids = const [],
    this.asks = const [],
    this.asOf,
    this.isStale = false,
    this.marketSession,
    this.high24h,
    this.low24h,
    this.volume24h,
    this.turnover24h,
    this.fundingRate,
    this.openInterestUsd,
    this.referencePrice,
    this.referenceLabel,
    this.relativeLabel,
    this.basisPercent,
    this.spreadPercent,
    this.assetTitle,
    this.assetBadge,
    this.assetDescription,
    this.assetRights = const [],
  });
  final DecimalValue price;
  final DecimalValue? change24hPercent;
  final List<OrderBookEntry> bids;
  final List<OrderBookEntry> asks;
  final DateTime? asOf;
  final bool isStale;
  final String? marketSession;
  final DecimalValue? high24h, low24h, volume24h, turnover24h;
  final DecimalValue? fundingRate, openInterestUsd, referencePrice;
  final String? referenceLabel;
  final String? relativeLabel;
  final DecimalValue? basisPercent, spreadPercent;
  final String? assetTitle, assetBadge, assetDescription;
  final List<AssetRight> assetRights;
}

final class Candle {
  const Candle({
    required this.at,
    required this.close,
    this.open,
    this.high,
    this.low,
    this.volume,
  });
  final DateTime at;
  final DecimalValue close;
  final DecimalValue? open;
  final DecimalValue? high;
  final DecimalValue? low;
  final DecimalValue? volume;
}

enum MarketSessionKind {
  premarket,
  regular,
  afterHours,
  overnight,
  weekend,
  holiday,
}

final class MarketSessionSegment {
  const MarketSessionSegment({
    required this.kind,
    required this.start,
    required this.end,
    this.label,
  });

  final MarketSessionKind kind;
  final DateTime start;
  final DateTime end;
  final String? label;
}

final class CandleChart {
  const CandleChart({
    required this.symbol,
    required this.range,
    required this.points,
    this.referencePoints = const [],
    this.referencePrice,
    this.referencePriceIsStale = false,
    this.sessions = const [],
    this.fetchedAt,
    this.interval,
    this.from,
    this.to,
  });
  final String symbol;
  final String range;
  final List<Candle> points;
  final List<Candle> referencePoints;
  final DecimalValue? referencePrice;
  final bool referencePriceIsStale;
  final List<MarketSessionSegment> sessions;
  final DateTime? fetchedAt;
  final String? interval;
  final DateTime? from, to;
}
