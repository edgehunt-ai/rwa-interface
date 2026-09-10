import 'decimal_value.dart';

enum MarketProductKind { bstock, perp }

final class MarketProductRef {
  const MarketProductRef({required this.symbol, required this.kind});
  final String symbol;
  final MarketProductKind kind;

  @override
  bool operator ==(Object other) =>
      other is MarketProductRef && other.symbol == symbol && other.kind == kind;

  @override
  int get hashCode => Object.hash(symbol, kind);
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
}
