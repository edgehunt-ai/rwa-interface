import '../models/domain_page.dart';
import '../models/stock.dart';
import '../models/market_product.dart';
import '../models/market_snapshot.dart';

abstract interface class MarketsRepository {
  Future<DomainPage<Stock>> listStocks();
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
  });
  Future<MarketProduct> getProduct(MarketProductRef ref);
  Future<MarketSnapshot> getSnapshot(MarketProductRef ref);
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    required CandleChartRange range,
  });
  Future<void> addFavorite(MarketProductRef ref);
  Future<void> removeFavorite(MarketProductRef ref);
  Future<void> replaceFavorites(List<MarketProductRef> refs);
}
