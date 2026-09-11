import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class FundingService {
  Future<api.DepositInstruction> getDepositDirectory();
  Future<api.UnifiedFundingAccount> getUnifiedFundingAccount();
  Future<api.FundingSession> createFundingSession(
    api.FundingSessionCreateRequest request, {
    required String idempotencyKey,
  });
  Future<api.FundingSession> getFundingSession(String id);
  Future<api.FundingSession> updateFundingSessionSelection(
    String id,
    api.FundingSessionSelectionRequest request, {
    required String idempotencyKey,
  });
  Future<api.FundingPlan> createPlan(
    api.FundingPlanRequest request, {
    required String idempotencyKey,
  });
  Future<api.FundingPlan> getPlan(String id);
  Future<api.Transfer> createTransfer(
    api.TransferRequest request, {
    required String idempotencyKey,
  });
  Future<api.Transfer> getTransfer(String id);
  Future<api.Deposit> getDeposit(String id);
  Future<api.DepositPage> listDeposits({String? cursor});
  Future<api.DepositObservationPage> listDepositObservations({String? cursor});
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
  Future<api.SelfCustodialWithdrawal> createSelfCustodialWithdrawal(
    api.SelfCustodialWithdrawalCreateRequest request, {
    required String idempotencyKey,
  });
  Future<api.SelfCustodialWithdrawal> getSelfCustodialWithdrawal(String id);
  Future<api.SelfCustodialWithdrawal> submitSelfCustodialWithdrawal(
    String id,
    api.SelfCustodialWithdrawalSubmissionRequest request, {
    required String idempotencyKey,
  });
}
