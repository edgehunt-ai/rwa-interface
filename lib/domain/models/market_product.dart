import 'decimal_value.dart';

enum MarketProductKind { bstock, perp }

final class Hip3PublicMarket {
  const Hip3PublicMarket({
    required this.productId,
    required this.venue,
    required this.environment,
    required this.settlementAsset,
    required this.tradable,
    this.unavailableReason,
  });

  final String productId, venue, environment, settlementAsset;
  final bool tradable;
  final String? unavailableReason;

  bool matches({
    required String productId,
    required String venue,
    required String environment,
    required String settlementAsset,
  }) =>
      this.productId == productId &&
      this.venue == venue &&
      this.environment == environment &&
      this.settlementAsset == settlementAsset;
}

final class MarketProductRef {
  const MarketProductRef({
    required this.symbol,
    required this.kind,
    this.productId,
    this.environment,
  });
  final String symbol;
  final MarketProductKind kind;
  final String? productId, environment;

  @override
  bool operator ==(Object other) =>
      other is MarketProductRef &&
      other.symbol == symbol &&
      other.kind == kind &&
      other.productId == productId &&
      other.environment == environment;

  @override
  int get hashCode => Object.hash(symbol, kind, productId, environment);
}

final class MarketProduct {
  const MarketProduct({
    required this.symbol,
    required this.name,
    required this.kind,
    required this.price,
    required this.settlementAsset,
    required this.network,
    required this.tradable,
    this.change24hPercent,
    this.volume24h,
    this.turnover24hUsd,
    this.isFavorite = false,
    this.hip3Market,
    this.priceKind,
    this.updatedAt,
    this.validUntil,
    this.isStale = false,
  });

  final String symbol;
  final String name;
  final MarketProductKind kind;
  final DecimalValue price;
  final String settlementAsset;
  final String network;
  final bool tradable;
  final DecimalValue? change24hPercent;
  final DecimalValue? volume24h;
  final DecimalValue? turnover24hUsd;
  final bool isFavorite;
  final Hip3PublicMarket? hip3Market;
  final String? priceKind;
  final DateTime? updatedAt, validUntil;
  final bool isStale;

  MarketProductRef get ref => MarketProductRef(
    symbol: symbol,
    kind: kind,
    productId: hip3Market?.productId,
    environment: hip3Market?.environment,
  );
}
