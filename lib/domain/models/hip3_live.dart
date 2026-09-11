import 'decimal_value.dart';
import 'market_product.dart';
import 'market_snapshot.dart';
import 'order.dart';
import 'portfolio.dart';
import 'position.dart';

final class Hip3LiveQuery {
  Hip3LiveQuery({
    required String signer,
    required this.environment,
    required Set<String> channels,
  }) : signer = signer.toLowerCase(),
       channels = Set.unmodifiable(channels);
  final String signer, environment;
  final Set<String> channels;
  @override
  bool operator ==(Object other) =>
      other is Hip3LiveQuery &&
      signer == other.signer &&
      environment == other.environment &&
      channels.length == other.channels.length &&
      channels.containsAll(other.channels);
  @override
  int get hashCode =>
      Object.hash(signer, environment, Object.hashAllUnordered(channels));
}

typedef Hip3LiveMarketKey = ({String productId, String environment});
typedef Hip3LiveCandleKey = ({
  String productId,
  String environment,
  String interval,
  DateTime at,
});

sealed class Hip3LiveUpdate {
  const Hip3LiveUpdate();
}

/// Discard this subscription's live state and establish a new snapshot.
/// This never instructs the caller to repeat a signed command.
final class Hip3LiveResync extends Hip3LiveUpdate {
  const Hip3LiveResync();
}

final class Hip3LiveSnapshot extends Hip3LiveUpdate {
  Hip3LiveSnapshot({
    required this.query,
    required this.cursor,
    required this.completedAt,
    required this.emittedAt,
    required Map<String, TradingOrder> orders,
    required Map<String, Position> positions,
    required Map<Hip3LiveMarketKey, Hip3LivePrice> prices,
    required Map<Hip3LiveCandleKey, Hip3LiveCandle> candles,
    this.balance,
  }) : orders = Map.unmodifiable(orders),
       positions = Map.unmodifiable(positions),
       prices = Map.unmodifiable(prices),
       candles = Map.unmodifiable(candles);
  final Hip3LiveQuery query;
  final String cursor;
  final DateTime completedAt, emittedAt;
  final Map<String, TradingOrder> orders;
  final Map<String, Position> positions;
  final Map<Hip3LiveMarketKey, Hip3LivePrice> prices;
  final Map<Hip3LiveCandleKey, Hip3LiveCandle> candles;

  /// Entire external Hyperliquid wallet, not the App internal ledger and not
  /// an allocation of shared collateral to individual HIP3 products.
  final Hip3LiveBalance? balance;
}

final class Hip3LivePrice {
  const Hip3LivePrice({required this.quote, required this.source});
  final MarketSnapshot quote;
  final String source;
}

final class Hip3LiveCandle {
  const Hip3LiveCandle({
    required this.market,
    required this.interval,
    required this.point,
    required this.closed,
    required this.source,
    required this.observedAt,
    required this.freshUntil,
  });
  final Hip3PublicMarket market;
  final String interval, source;
  final Candle point;
  final bool closed;
  final DateTime observedAt, freshUntil;
}

final class Hip3LiveBalance {
  Hip3LiveBalance({
    required this.signer,
    required this.environment,
    required this.summary,
    required List<Hip3LiveAsset> assets,
  }) : assets = List.unmodifiable(assets);
  final String signer, environment;
  final Portfolio summary;
  final List<Hip3LiveAsset> assets;
}

final class Hip3LiveAsset {
  Hip3LiveAsset({
    required this.assetId,
    required this.source,
    required this.network,
    required this.symbol,
    required this.decimals,
    required this.balanceRaw,
    required this.balance,
    required this.native,
    required this.pricingSource,
    required this.freshness,
    required this.observedAt,
    required List<String> warnings,
    this.walletId,
    this.accountRef,
    this.contractAddress,
    this.priceUsd,
    this.valueUsd,
    this.blockNumber,
    this.blockHash,
  }) : warnings = List.unmodifiable(warnings);
  final String assetId,
      source,
      network,
      symbol,
      balanceRaw,
      pricingSource,
      freshness;
  final int decimals;
  final bool native;
  final DecimalValue balance;
  final DecimalValue? priceUsd, valueUsd;
  final DateTime observedAt;
  final List<String> warnings;
  final String? walletId, accountRef, contractAddress, blockHash;
  final int? blockNumber;
}
