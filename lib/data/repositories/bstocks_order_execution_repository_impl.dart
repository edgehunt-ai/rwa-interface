import '../../domain/auth/authentication.dart';
import '../../domain/models/api_failure.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_intent.dart';
import '../../domain/models/resource_result.dart';
import '../../domain/models/wallet_action_execution.dart';
import '../../domain/repositories/bstocks_order_execution_repository.dart';
import '../../domain/repositories/bstocks_order_action_repository.dart';
import '../../domain/repositories/orders_repository.dart';
import '../../domain/services/embedded_wallet_transaction_sender.dart';
import '../../domain/repositories/wallet_action_execution_repository.dart';
import '../../domain/services/wallet_authorization_signer.dart';

final class BstocksOrderExecutionRepositoryImpl
    implements BstocksOrderExecutionRepository {
  BstocksOrderExecutionRepositoryImpl(
    this._orders,
    this._actions,
    this._sender, {
    this._sponsoredExecutions,
    this._authorizationSigner,
  });

  final OrdersRepository _orders;
  final BstocksOrderActionRepository _actions;
  final EmbeddedWalletTransactionSender? _sender;
  final WalletActionExecutionRepository? _sponsoredExecutions;
  final WalletAuthorizationSigner? _authorizationSigner;

  @override
  Future<ResourceResult<TradingOrder>> execute({
    required OrderIntent intent,
    required ResourceResult<TradingOrder> created,
  }) async {
    var current = created;
    var awaitingApprovalConfirmation = false;
    final submittedSteps = <String>{};
    for (var attempt = 0; attempt < 60; attempt++) {
      final order = current.resource;
      if (order.isTerminal) return current;
      final action = order.nextAction;
      if (action != null) {
        if (order.actionStatus == BstocksOrderActionStatus.failed ||
            order.actionStatus == BstocksOrderActionStatus.manualReview) {
          return current;
        }

        awaitingApprovalConfirmation =
            action.kind == BstocksOrderActionKind.erc20Approval;
        final actionAlreadySubmitted =
            submittedSteps.contains(action.stepId) ||
            order.actionStatus == BstocksOrderActionStatus.submitted ||
            order.actionStatus == BstocksOrderActionStatus.confirmed;
        if (!actionAlreadySubmitted) {
          final sponsoredExecutions = _sponsoredExecutions;
          final authorizationSigner = _authorizationSigner;
          if (sponsoredExecutions != null && authorizationSigner != null) {
            await _sendSponsored(
              sponsoredExecutions,
              authorizationSigner,
              action,
            );
          } else {
            final sender = _sender;
            if (sender == null) {
              throw const UnknownFailure(
                userAction: 'bStocks wallet transaction signer unavailable',
              );
            }
            final txHash = await _send(sender, action);
            await _actions.submit(
              orderId: action.orderId,
              stepId: action.stepId,
              transactionHash: txHash,
              idempotencyKey:
                  'bstocks-action-${action.orderId}-${action.stepId}',
            );
          }
          submittedSteps.add(action.stepId);
        }
      }

      await Future<void>.delayed(const Duration(milliseconds: 500));
      final refreshed = await _orders.get(order.orderId);
      final approvalConfirmed =
          awaitingApprovalConfirmation &&
          refreshed.resource.actionStatus ==
              BstocksOrderActionStatus.confirmed &&
          refreshed.resource.nextAction == null;
      if (approvalConfirmed) {
        // The approval action is a prerequisite, not the order itself. The
        // backend creates the swap action when this same order request is
        // replayed after allowance confirmation.
        current = await _orders.create(
          intent,
          idempotencyKey:
              'bstocks-recreate-${order.orderId}-${DateTime.now().microsecondsSinceEpoch}',
        );
        awaitingApprovalConfirmation = false;
      } else {
        current = refreshed;
      }
    }
    return current;
  }

  Future<void> _sendSponsored(
    WalletActionExecutionRepository executions,
    WalletAuthorizationSigner signer,
    BstocksOrderAction action,
  ) async {
    final execution = await executions.createOrderWalletActionExecution(
      orderId: action.orderId,
      stepId: action.stepId,
      mode: GasPaymentMode.appSponsored,
      idempotencyKey: 'bstocks-sponsored-${action.orderId}-${action.stepId}',
    );
    if (execution.requiresUserPaidFallback) {
      throw UnknownFailure(
        userAction:
            'bStocks gas sponsorship unavailable: ${execution.gasPayment.decision.name}',
      );
    }
    final authorization = execution.authorization;
    if (!execution.awaitsAuthorization || authorization == null) {
      throw UnknownFailure(
        userAction:
            'bStocks sponsored execution is not awaiting authorization: ${execution.status.name}',
      );
    }
    try {
      final signature = await signer.signWalletAuthorization(
        expectedSigner: action.from,
        request: authorization,
      );
      await executions.submitAuthorization(
        executionId: execution.executionId,
        signature: signature,
        idempotencyKey: 'bstocks-sponsored-submit-${execution.executionId}',
      );
    } on WalletAuthorizationFailure catch (failure) {
      throw UnknownFailure(
        retryable: failure.retryable,
        userAction:
            'bStocks sponsored authorization failed: ${failure.code.name}',
      );
    }
  }

  Future<String> _send(
    EmbeddedWalletTransactionSender sender,
    BstocksOrderAction action,
  ) async {
    try {
      return await sender.sendTransaction(
        expectedSigner: action.from,
        chainId: action.chainId,
        to: action.to,
        data: action.data,
        value: action.value,
      );
    } on IdentityFailure catch (failure) {
      throw UnknownFailure(
        retryable: failure.retryable,
        userAction: [
          'bStocks wallet transaction failed: ${failure.code.name}',
          if (failure.reason case final reason? when reason.isNotEmpty) reason,
        ].join(' - '),
      );
    }
  }
}
