import '../models/hip3_live.dart';
import '../models/market_snapshot.dart';

/// A quote updates only price-owned fields. REST remains authoritative for the
/// orderbook/statistics and their freshness; missing provenance is not guessed.
MarketSnapshot overlayHip3Price(
  MarketSnapshot base,
  Hip3LivePrice? live,
  DateTime now,
) {
  if (live == null) return base;
  final quote = live.quote;
  final identity = base.hip3Market;
  final market = quote.hip3Market;
  final observed = quote.asOf;
  final previous = base.priceObservedAt ?? base.asOf;
  if (identity == null ||
      market == null ||
      observed == null ||
      previous == null ||
      !market.matches(
        productId: identity.productId,
        venue: identity.venue,
        environment: identity.environment,
        settlementAsset: identity.settlementAsset,
      ) ||
      quote.priceKind != 'mark' ||
      quote.isStaleAt(now) ||
      quote.validUntil == null ||
      observed.isAfter(now.toUtc()) ||
      !observed.isAfter(previous.toUtc())) {
    return base;
  }
  return MarketSnapshot(
    price: quote.price,
    change24hPercent: quote.change24hPercent,
    priceKind: quote.priceKind,
    quoteLabel: quote.quoteLabel,
    priceObservedAt: observed,
    priceValidUntil: quote.validUntil,
    priceSource: live.source,
    hip3Market: identity,
    bids: base.bids,
    asks: base.asks,
    asOf: base.asOf,
    validUntil:
        base.validUntil == null || quote.validUntil!.isBefore(base.validUntil!)
        ? quote.validUntil
        : base.validUntil,
    isStale: base.isStale,
    marketSession: base.marketSession,
    high24h: base.high24h,
    low24h: base.low24h,
    volume24h: base.volume24h,
    turnover24h: base.turnover24h,
    fundingRate: base.fundingRate,
    openInterestUsd: base.openInterestUsd,
    referencePrice: base.referencePrice,
    referenceLabel: base.referenceLabel,
    basisPercent: base.basisPercent,
    spreadPercent: base.spreadPercent,
  );
}
