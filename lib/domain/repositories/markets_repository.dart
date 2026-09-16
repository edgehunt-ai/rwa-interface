import '../models/bstocks_support.dart';
import '../models/domain_page.dart';
import '../models/stock.dart';
import '../models/market_product.dart';
import '../models/market_snapshot.dart';

abstract interface class MarketsRepository {
  Future<DomainPage<Stock>> listStocks();

  /// Discovery metadata for BNB Chain bStocks. Entries are candidates for
  /// display; only [BstocksSupportedToken.isExecutable] ones may be traded.
  Future<List<BstocksSupportedToken>> listBstocksSupportedTokens();
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
  });
  Future<MarketProduct> getProduct(MarketProductRef ref);
  Future<MarketSnapshot> getSnapshot(MarketProductRef ref);
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    CandleChartRange? range,
    String? interval,
    DateTime? from,
    DateTime? to,
  });
  Future<void> addFavorite(MarketProductRef ref);
  Future<void> removeFavorite(MarketProductRef ref);
  Future<void> replaceFavorites(List<MarketProductRef> refs);
}
