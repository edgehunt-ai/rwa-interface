import 'market_product.dart';

final class Stock {
  const Stock({
    required this.symbol,
    required this.name,
    required this.referencePrice,
    this.logoUrl,
    this.products = const [],
  });
  final String symbol;
  final String name;
  final String referencePrice;
  final String? logoUrl;
  final List<MarketProductRef> products;
}
