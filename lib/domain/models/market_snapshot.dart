import 'decimal_value.dart';

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
    this.basisPercent,
    this.spreadPercent,
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
  final DecimalValue? basisPercent, spreadPercent;
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

final class CandleChart {
  const CandleChart({
    required this.symbol,
    required this.range,
    required this.points,
    this.fetchedAt,
    this.interval,
    this.from,
    this.to,
  });
  final String symbol;
  final String range;
  final List<Candle> points;
  final DateTime? fetchedAt;
  final String? interval;
  final DateTime? from, to;
}
