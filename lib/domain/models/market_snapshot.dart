import 'decimal_value.dart';

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
  });
  final DecimalValue price;
  final DecimalValue? change24hPercent;
  final List<OrderBookEntry> bids;
  final List<OrderBookEntry> asks;
  final DateTime? asOf;
  final bool isStale;
  final String? marketSession;
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
  });
  final String symbol;
  final String range;
  final List<Candle> points;
}
