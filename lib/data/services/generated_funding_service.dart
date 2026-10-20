import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_diagnostics.dart';
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
  // This compatibility directory is consumed only by the legacy summary path.
  Future<api.FundingCatalog> getFundingCatalog() =>
      _body(_api.getFundingCatalog); // ignore: deprecated_member_use
  @override
  Future<api.FundingSession> createFundingSession(
    api.FundingSessionCreateRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createFundingSession(
      idempotencyKey: idempotencyKey,
      fundingSessionCreateRequest: request,
    ),
  );
  @override
  Future<api.FundingSession> getFundingSession(String id) =>
      _body(() => _api.getFundingSession(fundingSessionId: id));
  @override
  Future<api.FundingSession> updateFundingSessionSelection(
    String id,
    api.FundingSessionSelectionRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.updateFundingSessionSelection(
      fundingSessionId: id,
      idempotencyKey: idempotencyKey,
      fundingSessionSelectionRequest: request,
    ),
  );
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
  Future<api.DepositObservationPage> listDepositObservations({
    String? cursor,
  }) => _body(() => _api.listDepositObservations(cursor: cursor));
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
  @override
  Future<api.SelfCustodialWithdrawal> createSelfCustodialWithdrawal(
    api.SelfCustodialWithdrawalCreateRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createSelfCustodialWithdrawal(
      idempotencyKey: idempotencyKey,
      selfCustodialWithdrawalCreateRequest: request,
    ),
  );
  @override
  Future<api.SelfCustodialWithdrawal> getSelfCustodialWithdrawal(String id) =>
      _body(() => _api.getSelfCustodialWithdrawal(withdrawalId: id));
  @override
  Future<api.SelfCustodialWithdrawal> submitSelfCustodialWithdrawal(
    String id,
    api.SelfCustodialWithdrawalSubmissionRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.submitSelfCustodialWithdrawal(
      withdrawalId: id,
      idempotencyKey: idempotencyKey,
      selfCustodialWithdrawalSubmissionRequest: request,
    ),
  );

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final data = (await request()).data;
      if (data == null) throw const FormatException('Missing response body');
      return data;
    } on DioException catch (error) {
      final failure = _mapper.fromDio(error);
      debugPrint('Funding API request failed: ${safeFailureSummary(failure)}');
      throw failure;
    }
  }
}
