import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';
import 'funding_service.dart';

final class GeneratedFundingService implements FundingService {
  GeneratedFundingService(this._api, {this._mapper = const ApiFailureMapper()});
  final api.FundingApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<api.DepositInstruction> getDepositDirectory() =>
      _body(_api.getDepositInstruction);
  @override
  Future<api.UnifiedFundingAccount> getUnifiedFundingAccount() =>
      _body(_api.getUnifiedFundingAccount);
  @override
  Future<api.FundingPlan> createPlan(
    api.FundingPlanRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createFundingPlan(
      idempotencyKey: idempotencyKey,
      fundingPlanRequest: request,
    ),
  );
  @override
  Future<api.FundingPlan> getPlan(String id) =>
      _body(() => _api.getFundingPlan(planId: id));
  @override
  Future<api.Transfer> createTransfer(
    api.TransferRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createTransfer(
      idempotencyKey: idempotencyKey,
      transferRequest: request,
    ),
  );
  @override
  Future<api.Transfer> getTransfer(String id) =>
      _body(() => _api.getTransfer(transferId: id));
  @override
  Future<api.Deposit> getDeposit(String id) =>
      _body(() => _api.getDeposit(depositId: id));
  @override
  Future<api.DepositPage> listDeposits({String? cursor}) =>
      _body(() => _api.listDeposits(cursor: cursor));
  @override
  Future<api.WithdrawalQuote> quote(
    api.WithdrawalQuoteRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createWithdrawalQuote(
      idempotencyKey: idempotencyKey,
      withdrawalQuoteRequest: request,
    ),
  );
  @override
  Future<api.Withdrawal> createWithdrawal(
    api.CreateWithdrawalRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createWithdrawal(
      idempotencyKey: idempotencyKey,
      createWithdrawalRequest: request,
    ),
  );
  @override
  Future<api.Withdrawal> getWithdrawal(String id) =>
      _body(() => _api.getWithdrawal(withdrawalId: id));
  @override
  Future<api.WithdrawalPage> listWithdrawals({String? cursor}) =>
      _body(() => _api.listWithdrawals(cursor: cursor));

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final data = (await request()).data;
      if (data == null) throw const FormatException('Missing response body');
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
