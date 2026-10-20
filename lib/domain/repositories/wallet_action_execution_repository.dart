import '../models/wallet_action_execution.dart';

/// Wallet action executions bind one frozen business action to one gas payment
/// mode. Clients choose only the mode; every transaction, provider and binding
/// field stays server-owned.
abstract interface class WalletActionExecutionRepository {
  /// Reads the current authority for an existing execution, including recovery
  /// after a lost create/submission response. A create replay is not permission
  /// to sign again.
  Future<WalletActionExecution> get(String executionId);

  Future<WalletActionExecution> createOrderWalletActionExecution({
    required String orderId,
    required String actionId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  });

  Future<WalletActionExecution> createTransferWalletActionExecution({
    required String transferId,
    required String actionId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  });

  Future<WalletActionExecution> createSelfCustodialWithdrawalExecution({
    required String withdrawalId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  });

  /// Relays authorization to the sole backend publisher; native gas remains user-paid.
  /// The signature is single-use and must never be stored or logged.
  Future<WalletActionExecution> submitAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  });

  /// Reports historical user_wallet evidence only; never authorizes publication.
  Future<WalletActionExecution> submitTransactionHash({
    required String executionId,
    required String txHash,
    required String idempotencyKey,
  });

  Future<WalletActionExecution> prepareCancellation({
    required String executionId,
    required String idempotencyKey,
  });

  Future<WalletActionExecution> submitCancellationAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  });
}
