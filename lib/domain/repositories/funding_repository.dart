import '../models/deposit.dart';
import '../models/domain_page.dart';
import '../models/funding_catalog.dart';
import '../models/funding_transfer.dart';
import '../models/resource_result.dart';
import '../models/withdrawal.dart';
import '../models/deposit_observation.dart';
import '../models/funding_session.dart';
import '../models/self_custodial_withdrawal.dart';

abstract interface class FundingRepository {
  Future<DepositDirectory> getDepositDirectory();
  Future<UnifiedFundingAccountSummary> getUnifiedFundingAccount();
  Future<FundingSessionSummary> getFundingSession(String id);
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    required String idempotencyKey,
  });
  Future<FundingPlan> createFundingSessionPlan({
    required String fundingSessionId,
    required int selectionVersion,
    required String idempotencyKey,
  });
  Future<FundingPlan> getFundingPlan(String id);
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String legId,
    required String authorizationId,
    required String idempotencyKey,
  });
  Future<FundingTransfer> getFundingTransfer(String id);
  Future<ResourceResult<Deposit>> getDeposit(String id);
  Future<DomainPage<ResourceResult<Deposit>>> listDeposits({String? cursor});
  Future<DomainPage<DepositObservation>> listDepositObservations({
    String? cursor,
  });
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  });
  Future<Withdrawal> createWithdrawal(
    WithdrawalIntent intent, {
    required String quoteId,
    required String authorizationId,
    required String idempotencyKey,
  });
  Future<Withdrawal> getWithdrawal(String id);
  Future<DomainPage<Withdrawal>> listWithdrawals({String? cursor});
  Future<SelfCustodialWithdrawalSummary> getSelfCustodialWithdrawal(String id);
  Future<SelfCustodialWithdrawalSummary> submitSelfCustodialWithdrawal({
    required String id,
    required String txHash,
    required String idempotencyKey,
  });
}
