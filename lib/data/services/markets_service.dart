import 'package:rwa_api_client/rwa_api_client.dart';

abstract interface class MarketsService {
  Future<StockPage> listStocks();
  Future<ProductPage> listProducts({String? query, String? cursor});
  Future<ProductDetail> getProduct(String symbol, ProductKind kind);
  Future<MarketStats> getProductStats(String symbol, ProductKind kind);
  Future<OrderBook> getOrderBook(String symbol, ProductKind kind);
  Future<void> addFavorite(String symbol, ProductKind kind);
  Future<void> removeFavorite(String symbol, ProductKind kind);
  Future<void> replaceFavorites(List<ProductRef> items);
}
