import '../models/hip3_wallet_history.dart';

abstract interface class Hip3WalletHistoryRepository {
  Future<Hip3HistoryPage<Hip3FundingPayment>> funding(
    Hip3HistoryQuery query, {
    String? cursor,
  });
  Future<Hip3HistoryPage<Hip3LiquidationEvent>> liquidations(
    Hip3HistoryQuery query, {
    String? cursor,
  });
}
