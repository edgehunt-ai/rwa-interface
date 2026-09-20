import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class WalletActionExecutionService {
  Future<api.WalletActionExecution> createOrderExecution(
    String orderId,
    String stepId,
    api.WalletActionExecutionCreateRequest request, {
    required String idempotencyKey,
  });

  Future<api.WalletActionExecution> createSelfCustodialWithdrawalExecution(
    String withdrawalId,
    api.WalletActionExecutionCreateRequest request, {
    required String idempotencyKey,
  });

  Future<api.WalletActionExecution> submitExecution(
    String executionId,
    api.WalletActionExecutionSubmissionRequest request, {
    required String idempotencyKey,
  });
}
