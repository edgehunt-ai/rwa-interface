import 'decimal_value.dart';
import 'market_product.dart';

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
    this.basisPercent,
    this.spreadPercent,
    this.hip3Market,
    this.priceKind,
    this.quoteLabel,
    this.validUntil,
    this.priceObservedAt,
    this.priceValidUntil,
    this.priceSource,
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
  final Hip3PublicMarket? hip3Market;
  final String? priceKind, quoteLabel;
  final DateTime? validUntil;

  /// Price-only provenance. The overall REST snapshot may still have older
  /// statistics/orderbook data and must not be relabelled fresh by a price tick.
  final DateTime? priceObservedAt, priceValidUntil;
  final String? priceSource;

  bool isStaleAt(DateTime now) =>
      isStale ||
      (validUntil != null && !now.toUtc().isBefore(validUntil!.toUtc()));
}

final class Candle {
  const Candle({
    required this.at,
    required this.close,
    this.open,
    this.high,
    this.low,
    this.volume,
    this.hip3Provenance,
  });
  final DateTime at;
  final DecimalValue close;
  final DecimalValue? open;
  final DecimalValue? high;
  final DecimalValue? low;
  final DecimalValue? volume;
  final Hip3CandleProvenance? hip3Provenance;
}

/// Data-source observation, never the HTTP/client receipt time or exchange
/// revision number. Used only within the same product/environment/source.
final class Hip3CandleProvenance {
  const Hip3CandleProvenance({
    required this.productId,
    required this.environment,
    required this.source,
    required this.observedAt,
    required this.freshUntil,
  });
  final String productId, environment, source;
  final DateTime observedAt, freshUntil;

  bool sameSource(Hip3CandleProvenance other) =>
      productId == other.productId &&
      environment == other.environment &&
      source == other.source;
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
    this.hip3Market,
    this.hip3Provenance,
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
  final Hip3PublicMarket? hip3Market;
  final Hip3CandleProvenance? hip3Provenance;
}
