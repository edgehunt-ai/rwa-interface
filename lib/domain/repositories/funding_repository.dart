import '../models/deposit.dart';
import '../models/domain_page.dart';
import '../models/funding_catalog.dart';
import '../models/funding_transfer.dart';
import '../models/resource_result.dart';
import '../models/withdrawal.dart';

abstract interface class FundingRepository {
  Future<FundingCatalog> getCatalog();
  Future<DepositInstruction> getDepositInstruction({
    required String chain,
    required String token,
  });
  Future<FundingPlan> createFundingPlan({
    required String tradePreviewId,
    String? sourceAssetId,
    required String idempotencyKey,
  });
  Future<FundingPlan> getFundingPlan(String id);
  Future<FundingTransfer> createFundingTransfer({
    required String planId,
    required String authorizationId,
    required String idempotencyKey,
  });
  Future<FundingTransfer> getFundingTransfer(String id);
  Future<ResourceResult<Deposit>> createDeposit({
    required String chain,
    String? amount,
    required String idempotencyKey,
  });
  Future<ResourceResult<Deposit>> getDeposit(String id);
  Future<DomainPage<ResourceResult<Deposit>>> listDeposits({String? cursor});
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
}
