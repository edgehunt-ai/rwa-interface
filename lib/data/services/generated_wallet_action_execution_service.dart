import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../api/api_failure_mapper.dart';
import 'wallet_action_execution_service.dart';

/// The create operation is tagged Funding and the submission Wallets, so this
/// port spans both generated APIs while staying narrow on the execution
/// resource.
final class GeneratedWalletActionExecutionService
    implements WalletActionExecutionService {
  GeneratedWalletActionExecutionService(
    this._funding,
    this._wallets, {
    this._orders,
    this._mapper = const ApiFailureMapper(),
  });

  final api.FundingApi _funding;
  final api.WalletsApi _wallets;
  final api.OrdersApi? _orders;
  final ApiFailureMapper _mapper;

  @override
  Future<api.WalletActionExecution> createOrderExecution(
    String orderId,
    String stepId,
    api.WalletActionExecutionCreateRequest request, {
    required String idempotencyKey,
  }) {
    final orders = _orders;
    if (orders == null) throw StateError('Orders API is not configured');
    return _body(
      () => orders.createOrderWalletActionExecution(
        orderId: orderId,
        stepId: stepId,
        idempotencyKey: idempotencyKey,
        walletActionExecutionCreateRequest: request,
      ),
    );
  }

  @override
  Future<api.WalletActionExecution> createSelfCustodialWithdrawalExecution(
    String withdrawalId,
    api.WalletActionExecutionCreateRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _funding.createSelfCustodialWithdrawalExecution(
      withdrawalId: withdrawalId,
      idempotencyKey: idempotencyKey,
      walletActionExecutionCreateRequest: request,
    ),
  );

  @override
  Future<api.WalletActionExecution> submitExecution(
    String executionId,
    api.WalletActionExecutionSubmissionRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _wallets.submitWalletActionExecution(
      executionId: executionId,
      idempotencyKey: idempotencyKey,
      walletActionExecutionSubmissionRequest: request,
    ),
  );

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      final data = response.data;
      if (data == null) {
        throw DecodingFailure(
          requestId: response.headers.value('x-request-id'),
        );
      }
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
