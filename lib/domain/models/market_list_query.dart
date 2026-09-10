import 'market_product.dart';

/// Server-supported rankings; not an arbitrary client-side sort.
enum MarketListGroup { hot, gainers, losers, volume, favorites }

final class MarketListQuery {
  const MarketListQuery({
    this.kind,
    this.group = MarketListGroup.hot,
    this.query = '',
    this.limit = 20,
  });
  final MarketProductKind? kind;
  final MarketListGroup group;
  final String query;
  final int limit;

  @override
  bool operator ==(Object other) =>
      other is MarketListQuery &&
      other.kind == kind &&
      other.group == group &&
      other.query == query &&
      other.limit == limit;
  @override
  int get hashCode => Object.hash(kind, group, query, limit);
}
