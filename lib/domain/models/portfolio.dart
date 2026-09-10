import 'decimal_value.dart';
import 'position.dart';
import 'trading_account.dart';
import 'portfolio_read_status.dart';

final class HoldingGroup {
  const HoldingGroup({
    required this.symbol,
    required this.totalValueUsd,
    required this.positions,
  });
  final String symbol;
  final DecimalValue totalValueUsd;
  final List<Position> positions;
}

final class Portfolio {
  const Portfolio({
    required this.totalValueUsd,
    required this.availableToTradeUsd,
    this.todayPnl,
    this.todayPnlPercent,
    this.marginInUseUsd,
    this.stocksValueUsd,
    this.updatedAt,
    this.accounts = const [],
    this.holdings = const [],
    this.readStatus = const PortfolioReadStatus(),
  });
  final DecimalValue totalValueUsd;
  final DecimalValue availableToTradeUsd;
  final DecimalValue? todayPnl;
  final DecimalValue? todayPnlPercent;
  final DecimalValue? marginInUseUsd;
  final DecimalValue? stocksValueUsd;
  final DateTime? updatedAt;
  final List<TradingAccount> accounts;
  final List<HoldingGroup> holdings;
  final PortfolioReadStatus readStatus;
}
