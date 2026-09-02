import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for FundingApi
void main() {
  final instance = RwaApiClient().getFundingApi();

  group(FundingApi, () {
    // 创建入金意图
    //
    //Future<Deposit> createDeposit(String idempotencyKey, CreateDepositIntentRequest createDepositIntentRequest) async
    test('test createDeposit', () async {
      // TODO
    });

    // 创建资金准备计划
    //
    //Future<FundingPlan> createFundingPlan(String idempotencyKey, FundingPlanRequest fundingPlanRequest) async
    test('test createFundingPlan', () async {
      // TODO
    });

    // 按资金计划创建划转
    //
    //Future<Transfer> createTransfer(String idempotencyKey, TransferRequest transferRequest) async
    test('test createTransfer', () async {
      // TODO
    });

    // 为需要恢复的划转创建 Claim
    //
    //Future<Claim> createTransferClaim(String transferId, String idempotencyKey, TransferClaimRequest transferClaimRequest) async
    test('test createTransferClaim', () async {
      // TODO
    });

    // 创建提现
    //
    //Future<Withdrawal> createWithdrawal(String idempotencyKey, CreateWithdrawalRequest createWithdrawalRequest) async
    test('test createWithdrawal', () async {
      // TODO
    });

    // 创建提现报价
    //
    //Future<WithdrawalQuote> createWithdrawalQuote(String idempotencyKey, WithdrawalQuoteRequest withdrawalQuoteRequest) async
    test('test createWithdrawalQuote', () async {
      // TODO
    });

    // 入金详情与权威状态
    //
    //Future<Deposit> getDeposit(String depositId) async
    test('test getDeposit', () async {
      // TODO
    });

    // 资金网络与结算资产目录
    //
    //Future<FundingCatalog> getFundingCatalog() async
    test('test getFundingCatalog', () async {
      // TODO
    });

    // 资金准备计划详情与权威状态
    //
    //Future<FundingPlan> getFundingPlan(String planId) async
    test('test getFundingPlan', () async {
      // TODO
    });

    // 划转详情与权威状态
    //
    //Future<Transfer> getTransfer(String transferId) async
    test('test getTransfer', () async {
      // TODO
    });

    // 提现详情与权威状态
    //
    //Future<Withdrawal> getWithdrawal(String withdrawalId) async
    test('test getWithdrawal', () async {
      // TODO
    });

    // 入金记录列表
    //
    //Future<ListDeposits200Response> listDeposits({ String cursor, int limit }) async
    test('test listDeposits', () async {
      // TODO
    });

    // 提现列表
    //
    //Future<ListWithdrawals200Response> listWithdrawals({ String cursor, int limit }) async
    test('test listWithdrawals', () async {
      // TODO
    });

  });
}
