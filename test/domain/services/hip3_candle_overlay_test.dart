import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/hip3_live.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/services/hip3_candle_overlay.dart';

const market = Hip3PublicMarket(
  productId: 'xyz:TSLA',
  venue: 'xyz',
  environment: 'testnet',
  settlementAsset: 'USDC',
  tradable: true,
);
final now = DateTime.utc(2026, 9, 11, 10, 1, 30);
final observed = now.subtract(const Duration(seconds: 20));
final provenance = Hip3CandleProvenance(
  productId: market.productId,
  environment: market.environment,
  source: 'hyperliquid_testnet',
  observedAt: observed,
  freshUntil: now.add(const Duration(seconds: 10)),
);
Candle point(DateTime at, String close) => Candle(
  at: at,
  close: DecimalValue(close, asset: 'USDC', unit: 'price'),
);
CandleChart baseline() => CandleChart(
  symbol: 'TSLA',
  range: '1h',
  interval: '1m',
  from: now.subtract(const Duration(hours: 1)),
  to: observed,
  fetchedAt: now,
  hip3Market: market,
  hip3Provenance: provenance,
  points: [
    point(DateTime.utc(2026, 9, 11, 9, 30), '10'),
    point(DateTime.utc(2026, 9, 11, 10, 1), '11'),
  ],
);
Hip3LiveCandle tick({
  DateTime? observation,
  DateTime? expires,
  String source = 'hyperliquid_testnet',
  String interval = '1m',
  Hip3PublicMarket identity = market,
}) => Hip3LiveCandle(
  market: identity,
  interval: interval,
  point: point(DateTime.utc(2026, 9, 11, 10, 1), '12.123456789'),
  closed: false,
  source: source,
  observedAt: observation ?? now.subtract(const Duration(seconds: 1)),
  freshUntil: expires ?? now.add(const Duration(seconds: 5)),
);

void main() {
  test('recent updates preserve REST history and source provenance', () {
    final before = baseline();
    final after = overlayHip3Candles(before, [tick()], now);
    expect(after.points.first, same(before.points.first));
    expect(after.points.last.close.value, '12.123456789');
    expect(after.points.last.hip3Provenance!.observedAt, tick().observedAt);
    expect(after.hip3Provenance, same(before.hip3Provenance));
    expect(after.fetchedAt, before.fetchedAt);
    expect(before.points.last.close.value, '11');
  });
  test('source, interval, identity, expiry and time mismatches cannot overwrite REST', () {
    final before = baseline();
    for (final value in [
      tick(source: 'different'),
      tick(interval: '5m'),
      tick(observation: observed),
      tick(observation: now.add(const Duration(seconds: 1))),
      tick(expires: now),
      tick(
        identity: const Hip3PublicMarket(
          productId: 'abc:TSLA',
          venue: 'abc',
          environment: 'testnet',
          settlementAsset: 'USDC',
          tradable: true,
        ),
      ),
    ]) {
      expect(overlayHip3Candles(before, [value], now), same(before));
    }
    final missing = CandleChart(
      symbol: 'TSLA',
      range: '1h',
      interval: '1m',
      points: before.points,
      fetchedAt: now,
    );
    expect(overlayHip3Candles(missing, [tick()], now), same(missing));
  });
  test('older REST or stream observations cannot undo a newer bar', () {
    final first = overlayHip3Candles(baseline(), [tick()], now);
    final next = overlayHip3Candles(first, [
      tick(observation: now.subtract(const Duration(seconds: 2))),
    ], now);
    expect(next, same(first));
  });
}
