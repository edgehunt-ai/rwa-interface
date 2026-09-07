import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class FundingService {
  Future<api.FundingCatalog> getCatalog();
  Future<api.Deposit> createDeposit(
    api.CreateDepositIntentRequest request, {
    required String idempotencyKey,
  });
  Future<api.Deposit> getDeposit(String id);
  Future<api.DepositPage> listDeposits({String? cursor});
  Future<api.WithdrawalQuote> quote(
    api.WithdrawalQuoteRequest request, {
    required String idempotencyKey,
  });
  Future<api.Withdrawal> createWithdrawal(
    api.CreateWithdrawalRequest request, {
    required String idempotencyKey,
  });
  Future<api.Withdrawal> getWithdrawal(String id);
  Future<api.WithdrawalPage> listWithdrawals({String? cursor});
}
