import '../models/domain_page.dart';
import '../models/portfolio.dart';
import '../models/trading_account.dart';

abstract interface class PortfolioRepository {
  Future<Portfolio> getSummary();
  Future<List<TradingAccount>> listAccounts();
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor});
}
