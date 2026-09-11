import '../models/hip3_live.dart';
import '../models/market_snapshot.dart';

/// Extend/correct only this REST window's recent candles. Never replace history
/// with the stream's short cache or treat client receipt time as a revision.
CandleChart overlayHip3Candles(
  CandleChart base,
  Iterable<Hip3LiveCandle> live,
  DateTime now,
) {
  final provenance = base.hip3Provenance;
  final market = base.hip3Market;
  if (provenance == null || market == null || base.from == null) return base;
  final points = {for (final point in base.points) point.at: point};
  var changed = false;
  var end = base.to;
  for (final update in live) {
    final observation = Hip3CandleProvenance(
      productId: update.market.productId,
      environment: update.market.environment,
      source: update.source,
      observedAt: update.observedAt,
      freshUntil: update.freshUntil,
    );
    final previous = points[update.point.at]?.hip3Provenance ?? provenance;
    if (!provenance.sameSource(observation) ||
        !previous.sameSource(observation) ||
        !update.market.matches(
          productId: market.productId,
          venue: market.venue,
          environment: market.environment,
          settlementAsset: market.settlementAsset,
        ) ||
        update.interval != base.interval ||
        !update.observedAt.isAfter(previous.observedAt) ||
        update.observedAt.isAfter(now) ||
        !update.freshUntil.isAfter(now) ||
        update.point.at.isBefore(base.from!) ||
        update.point.at.isAfter(now)) {
      continue;
    }
    final value = update.point;
    points[value.at] = Candle(
      at: value.at,
      open: value.open,
      high: value.high,
      low: value.low,
      close: value.close,
      volume: value.volume,
      hip3Provenance: observation,
    );
    if (end == null || value.at.isAfter(end)) end = value.at;
    changed = true;
  }
  if (!changed) return base;
  return CandleChart(
    symbol: base.symbol,
    range: base.range,
    interval: base.interval,
    from: base.from,
    to: end,
    fetchedAt: base.fetchedAt,
    hip3Market: market,
    hip3Provenance: provenance,
    points: List.unmodifiable(
      points.values.toList()..sort((a, b) => a.at.compareTo(b.at)),
    ),
    referencePoints: base.referencePoints,
    referencePrice: base.referencePrice,
    referencePriceIsStale: base.referencePriceIsStale,
    sessions: base.sessions,
  );
}
