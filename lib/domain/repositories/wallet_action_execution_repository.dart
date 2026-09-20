import '../models/wallet_action_execution.dart';

/// Wallet action executions bind one frozen business action to one gas payment
/// mode. Clients choose only the mode; every transaction, provider and binding
/// field stays server-owned.
abstract interface class WalletActionExecutionRepository {
  Future<WalletActionExecution> createOrderWalletActionExecution({
    required String orderId,
    required String stepId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  });

  Future<WalletActionExecution> createSelfCustodialWithdrawalExecution({
    required String withdrawalId,
    required GasPaymentMode mode,
    required String idempotencyKey,
  });

  /// Relays the Privy authorization signature for an app-sponsored execution.
  /// The signature is single-use and must never be stored or logged.
  Future<WalletActionExecution> submitAuthorization({
    required String executionId,
    required String signature,
    required String idempotencyKey,
  });

  /// Submits the broadcast locator for a user-paid execution.
  Future<WalletActionExecution> submitTransactionHash({
    required String executionId,
    required String txHash,
    required String idempotencyKey,
  });
}
