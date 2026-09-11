import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/hip3_live.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/domain/services/hip3_market_overlay.dart';

const market = Hip3PublicMarket(
  productId: 'xyz:TSLA',
  venue: 'xyz',
  environment: 'testnet',
  settlementAsset: 'USDC',
  tradable: true,
);
final now = DateTime.utc(2026, 9, 11, 0, 1);
MarketSnapshot base() => MarketSnapshot(
  price: DecimalValue('10', asset: 'USDC', unit: 'price'),
  asOf: now.subtract(const Duration(seconds: 30)),
  validUntil: now.subtract(const Duration(seconds: 1)),
  hip3Market: market,
  priceKind: 'mark',
  isStale: true,
  bids: [OrderBookEntry(price: DecimalValue('9'), size: DecimalValue('2'))],
  asks: [OrderBookEntry(price: DecimalValue('11'), size: DecimalValue('3'))],
  high24h: DecimalValue('20'),
  fundingRate: DecimalValue('0.001'),
  referencePrice: DecimalValue('100'),
  referenceLabel: 'Independent reference',
);
Hip3LivePrice live({
  Hip3PublicMarket identity = market,
  DateTime? observed,
  DateTime? expires,
  String kind = 'mark',
}) => Hip3LivePrice(
  source: 'hyperliquid_testnet',
  quote: MarketSnapshot(
    price: DecimalValue('12.123456789', asset: 'USDC', unit: 'price'),
    hip3Market: identity,
    asOf: observed ?? now.subtract(const Duration(seconds: 1)),
    validUntil: expires ?? now.add(const Duration(seconds: 30)),
    priceKind: kind,
    quoteLabel: 'Mark price',
    change24hPercent: DecimalValue('2'),
  ),
);
void main() {
  test('a short-lived tick cannot outlive its price freshness deadline', () {
    final before = MarketSnapshot(
      price: DecimalValue('10'),
      hip3Market: market,
      asOf: now.subtract(const Duration(seconds: 30)),
      validUntil: now.add(const Duration(minutes: 1)),
    );
    final after = overlayHip3Price(
      before,
      live(expires: now.add(const Duration(seconds: 2))),
      now,
    );
    expect(after.isStaleAt(now.add(const Duration(seconds: 3))), isTrue);
    expect(after.validUntil, now.add(const Duration(seconds: 2)));
  });
  test(
    'new price preserves orderbook statistics reference and their stale status',
    () {
      final before = base();
      final after = overlayHip3Price(before, live(), now);
      expect(after.price.value, '12.123456789');
      expect(after.price.asset, 'USDC');
      expect(after.bids, same(before.bids));
      expect(after.asks, same(before.asks));
      expect(after.fundingRate, before.fundingRate);
      expect(after.referencePrice, before.referencePrice);
      expect(after.high24h, before.high24h);
      expect(after.asOf, before.asOf);
      expect(after.validUntil, before.validUntil);
      expect(after.isStaleAt(now), isTrue);
      expect(after.priceObservedAt, live().quote.asOf);
      expect(after.priceValidUntil, live().quote.validUntil);
      expect(after.priceSource, 'hyperliquid_testnet');
    },
  );
  test('wrong identity old equal future stale and non-mark quotes do not overwrite REST', () {
    final before = base();
    for (final quote in [
      live(
        identity: const Hip3PublicMarket(
          productId: 'abc:TSLA',
          venue: 'abc',
          environment: 'testnet',
          settlementAsset: 'USDC',
          tradable: true,
        ),
      ),
      live(
        identity: const Hip3PublicMarket(
          productId: 'xyz:TSLA',
          venue: 'xyz',
          environment: 'mainnet',
          settlementAsset: 'USDC',
          tradable: true,
        ),
      ),
      live(
        identity: const Hip3PublicMarket(
          productId: 'xyz:TSLA',
          venue: 'xyz',
          environment: 'testnet',
          settlementAsset: 'USDH',
          tradable: true,
        ),
      ),
      live(observed: before.asOf),
      live(observed: before.asOf!.subtract(const Duration(seconds: 1))),
      live(observed: now.add(const Duration(seconds: 1))),
      live(expires: now),
      live(kind: 'oracle'),
    ]) {
      expect(overlayHip3Price(before, quote, now), same(before));
    }
    final withoutTime = MarketSnapshot(price: before.price, hip3Market: market);
    expect(overlayHip3Price(withoutTime, live(), now), same(withoutTime));
  });
}
