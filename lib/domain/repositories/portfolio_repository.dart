import '../models/domain_page.dart';
import '../models/portfolio.dart';
import '../models/portfolio_history.dart';
import '../models/portfolio_asset.dart';
import '../models/trading_account.dart';

abstract interface class PortfolioRepository {
  Future<Portfolio> getSummary();
  Future<List<TradingAccount>> listAccounts();
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor});
}

abstract interface class PortfolioAssetsRepository {
  Future<List<PortfolioAsset>> listAssets({String? cursor});
}

abstract interface class PortfolioHistoryRepository {
  Future<PortfolioHistory> getHistory(PortfolioHistoryRange range);
}
