import 'dart:async';

import '../../domain/auth/authentication.dart';
import '../api/idempotency_key.dart';
import '../services/bstocks_broadcast_journal.dart';
import '../services/bstocks_sponsored_execution_journal.dart';
import '../../domain/models/api_failure.dart';
import '../../domain/models/market_product.dart';
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
    BstocksBroadcastJournal? broadcastJournal,
    BstocksSponsoredExecutionJournal? sponsoredJournal,
    this._sponsoredReconciliationAttempts = 30,
    this._sponsoredReconciliationDelay = const Duration(seconds: 1),
  }) : _broadcastJournal = broadcastJournal ?? BstocksBroadcastJournal(),
       _sponsoredJournal =
           sponsoredJournal ?? BstocksSponsoredExecutionJournal();

  final OrdersRepository _orders;
  final BstocksOrderActionRepository _actions;
  final EmbeddedWalletTransactionSender? _sender;
  final WalletActionExecutionRepository? _sponsoredExecutions;
  final WalletAuthorizationSigner? _authorizationSigner;
  final BstocksBroadcastJournal _broadcastJournal;
  final BstocksSponsoredExecutionJournal _sponsoredJournal;
  final int _sponsoredReconciliationAttempts;
  final Duration _sponsoredReconciliationDelay;

  @override
  Future<ResourceResult<TradingOrder>> continueOrder({
    required OrderIntent intent,
    required String orderId,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  }) async {
    _checkCancellation(isCancelled);
    final action = await _actions.create(
      orderId: orderId,
      previewId: previewId,
      idempotencyKey: scopedIdempotencyKey(
        'bstocks-action-create-$orderId-$previewId',
      ),
    );
    _checkCancellation(isCancelled);
    final current = await _orders.get(orderId);
    return _execute(
      created: current,
      isCancelled: isCancelled,
      expectedActionId: action.actionId,
      stopAfterApproval: stopAfterApproval,
      refreshBeforeExecution: false,
    );
  }

  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    bool Function()? isCancelled,
  }) async {
    _checkCancellation(isCancelled);
    final current = await _orders.get(orderId);
    _checkCancellation(isCancelled);
    if (current.resource.isTerminal) return current;
    final action = await _currentCancellation(current.resource);
    _checkCancellation(isCancelled);
    if (action != null && action.status != BstocksOrderActionStatus.failed) {
      return _execute(
        created: current,
        isCancelled: isCancelled,
        waitForCancellation: true,
        refreshBeforeExecution: false,
      );
    }
    // One key per cancellation command, including across page/session reloads.
    // A definitively failed action permits a new command with a distinct key.
    final key = scopedIdempotencyKey(
      'bstocks-cancel-$orderId${action == null ? '' : '-after-${action.actionId}'}',
    );
    ResourceResult<TradingOrder> result;
    try {
      result = await _orders.cancel(orderId, idempotencyKey: key);
    } on ServerFailure catch (failure) {
      _checkCancellation(isCancelled);
      if (failure.code != 'cancellation_in_progress') rethrow;
      // Recover commands created by older clients using random keys as well.
      result = await _orders.get(orderId);
      _checkCancellation(isCancelled);
      if (result.resource.isTerminal) return result;
      final existing = await _currentCancellation(result.resource);
      _checkCancellation(isCancelled);
      if (existing == null ||
          existing.status == BstocksOrderActionStatus.failed) {
        rethrow;
      }
    }
    _checkCancellation(isCancelled);
    if (result.resource.isTerminal) return result;
    // DELETE may replay its original snapshot. It restores identity only.
    result = await _orders.get(orderId);
    _checkCancellation(isCancelled);
    if (result.resource.isTerminal) return result;
    final cancellation = await _currentCancellation(result.resource);
    _checkCancellation(isCancelled);
    if (cancellation == null) {
      throw const CompatibilityFailure(
        userAction: 'Cancellation did not return a cancellation action',
      );
    }
    return _execute(
      created: result,
      isCancelled: isCancelled,
      waitForCancellation: true,
      refreshBeforeExecution: false,
    );
  }

  Future<BstocksOrderAction?> _currentCancellation(TradingOrder order) async {
    final action =
        order.nextAction ??
        (order.currentActionId == null
            ? null
            : await _actions.get(
                orderId: order.orderId,
                actionId: order.currentActionId!,
              ));
    return action?.kind == BstocksOrderActionKind.cancelOrder ? action : null;
  }

  @override
  Future<ResourceResult<TradingOrder>> executeExisting({
    required ResourceResult<TradingOrder> order,
    bool Function()? isCancelled,
  }) => _execute(
    created: order,
    isCancelled: isCancelled,
    waitForCancellation:
        order.resource.nextAction?.kind == BstocksOrderActionKind.cancelOrder,
  );

  @override
  Future<ResourceResult<TradingOrder>> execute({
    required OrderIntent intent,
    required ResourceResult<TradingOrder> created,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  }) => _execute(
    created: created,
    isCancelled: isCancelled,
    stopAfterApproval: stopAfterApproval,
  );

  Future<ResourceResult<TradingOrder>> _execute({
    required ResourceResult<TradingOrder> created,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
    String? expectedActionId,
    bool waitForCancellation = false,
    bool refreshBeforeExecution = true,
  }) async {
    _checkCancellation(isCancelled);
    // POST replays carry frozen facts, not current permission to execute.
    var current = refreshBeforeExecution
        ? await _orders.get(created.resource.orderId)
        : created;
    var awaitingApprovalConfirmation = false;
    final submittedActions = <String>{};
    for (var attempt = 0; attempt < 60; attempt++) {
      _checkCancellation(isCancelled);
      final order = current.resource;
      order.checkBstocksExecutionFailure();
      if (order.isTerminal) return current;
      var action = order.nextAction;
      if (action != null && !submittedActions.contains(action.actionId)) {
        action = await _actions.get(
          orderId: order.orderId,
          actionId: action.actionId,
        );
        _checkCancellation(isCancelled);
      }
      // The order may hide an action after submission or failure. Its economic
      // status stays open during cancellation, so inspect the independent A.
      if (action == null) {
        final actionId = order.currentActionId ?? expectedActionId;
        if (actionId != null) {
          final hidden = await _actions.get(
            orderId: order.orderId,
            actionId: actionId,
          );
          _checkCancellation(isCancelled);
          _checkActionStatus(hidden);
          if (hidden.kind == BstocksOrderActionKind.cancelOrder) {
            waitForCancellation = true;
          }
          if (hidden.status == BstocksOrderActionStatus.awaitingSignature) {
            final hash =
                hidden.submittedTransactionHash ??
                await _broadcastJournal.transactionHash(hidden);
            _checkCancellation(isCancelled);
            if (hash != null && !submittedActions.contains(hidden.actionId)) {
              await _reportTransaction(hidden, hash);
              submittedActions.add(hidden.actionId);
            }
          }
          // Once O hides the action, only observe the original E. A hidden
          // action never authorizes a new signature or execution creation.
          final executions = _sponsoredExecutions;
          final executionId = await _sponsoredJournal.executionId(hidden);
          _checkCancellation(isCancelled);
          if (executions != null && executionId != null) {
            final execution =
                await _sponsoredJournal.submissionStarted(executionId)
                ? await _reconcileSponsoredSubmission(executions, executionId)
                : await executions.get(executionId);
            _checkCancellation(isCancelled);
            _checkExecutionFailure(execution);
            _checkCancellation(isCancelled);
          }
          if (hidden.kind == BstocksOrderActionKind.erc20Approval &&
              hidden.status == BstocksOrderActionStatus.confirmed &&
              order.status == TradingOrderStatus.awaitingConfirmation &&
              order.walletActionBlocker == 'previewRequired') {
            if (stopAfterApproval) return current;
            throw const CompatibilityFailure(
              userAction: 'Approval confirmed; a refreshed preview must be accepted before execution',
            );
          }
        }
      }
      // Inspect a hidden cancellation before accepting a resting GTC order.
      if (!waitForCancellation &&
          !awaitingApprovalConfirmation &&
          _isConfirmedPlacement(order)) {
        return current;
      }
      if (action != null) {
        _checkActionStatus(action);
        if (stopAfterApproval &&
            action.kind != BstocksOrderActionKind.erc20Approval) {
          throw const CompatibilityFailure(
            userAction: 'Approval flow received a non-approval wallet action',
          );
        }

        awaitingApprovalConfirmation =
            action.kind == BstocksOrderActionKind.erc20Approval;
        final actionAlreadySubmitted =
            submittedActions.contains(action.actionId) ||
            action.status == BstocksOrderActionStatus.submitted ||
            action.status == BstocksOrderActionStatus.confirmed;
        if (!actionAlreadySubmitted) {
          final knownHash =
              action.submittedTransactionHash ??
              await _broadcastJournal.transactionHash(action);
          _checkCancellation(isCancelled);
          final canAuthorize =
              action.status == BstocksOrderActionStatus.awaitingSignature &&
              order.walletActionBlocker == null;
          final savedExecutionId = await _sponsoredJournal.executionId(action);
          _checkCancellation(isCancelled);
          if (knownHash == null &&
              !canAuthorize &&
              (savedExecutionId == null || _sponsoredExecutions == null)) {
            throw const UnknownFailure(
              userAction:
                  'Wallet action is not currently available for execution',
            );
          }
          final sponsoredExecutions = _sponsoredExecutions;
          final authorizationSigner = _authorizationSigner;
          if (knownHash == null &&
              sponsoredExecutions != null &&
              (authorizationSigner != null || savedExecutionId != null)) {
            await _sendSponsored(
              sponsoredExecutions,
              authorizationSigner,
              action,
              isCancelled,
              canAuthorize: canAuthorize,
            );
          } else {
            final sender = _sender;
            if (sender == null && knownHash == null) {
              throw const UnknownFailure(
                userAction: 'bStocks wallet transaction signer unavailable',
              );
            }
            final txHash =
                knownHash ??
                await _broadcastJournal.broadcast(action, () {
                  _checkCancellation(isCancelled);
                  return _send(sender!, action!);
                });
            // The journal preserves the hash even if cancellation happened
            // while the wallet was broadcasting. Reporting can resume later.
            _checkCancellation(isCancelled);
            await _reportTransaction(action, txHash);
          }
          submittedActions.add(action.actionId);
        }
      }

      _checkCancellation(isCancelled);
      await Future<void>.delayed(const Duration(seconds: 1));
      _checkCancellation(isCancelled);
      final refreshed = await _orders.get(order.orderId);
      _checkCancellation(isCancelled);
      final approvalConfirmed =
          awaitingApprovalConfirmation &&
          refreshed.resource.status ==
              TradingOrderStatus.awaitingConfirmation &&
          refreshed.resource.walletActionBlocker == 'previewRequired';
      if (approvalConfirmed) {
        if (stopAfterApproval) return refreshed;
        throw const CompatibilityFailure(
          userAction: 'Approval confirmed; a refreshed preview must be accepted before execution',
        );
      } else {
        current = refreshed;
      }
    }
    throw const UnknownFailure(
      retryable: true,
      userAction: 'bStocks order confirmation timed out after 60 attempts',
    );
  }

  void _checkCancellation(bool Function()? isCancelled) {
    if (isCancelled?.call() ?? false) throw const CancelledFailure();
  }

  void _checkActionStatus(BstocksOrderAction action) {
    if (action.status == BstocksOrderActionStatus.failed ||
        action.status == BstocksOrderActionStatus.manualReview) {
      throw UnknownFailure(
        userAction:
            action.failureReason ?? 'Wallet action ${action.status.name}',
      );
    }
  }

  Future<void> _reportTransaction(
    BstocksOrderAction action,
    String transactionHash,
  ) async {
    await _actions.submit(
      orderId: action.orderId,
      actionId: action.actionId,
      transactionHash: transactionHash,
      idempotencyKey: scopedIdempotencyKey(
        'bstocks-action-${action.orderId}-${action.actionId}',
      ),
    );
  }

  bool _isConfirmedPlacement(TradingOrder order) =>
      order.kind == MarketProductKind.bstock &&
      order.nextAction == null &&
      const {
        TradingOrderStatus.open,
        TradingOrderStatus.partiallyFilled,
      }.contains(order.status);

  Future<void> _sendSponsored(
    WalletActionExecutionRepository executions,
    WalletAuthorizationSigner? signer,
    BstocksOrderAction action,
    bool Function()? isCancelled, {
    required bool canAuthorize,
  }) => _sponsoredJournal.run(action, () async {
    _checkCancellation(isCancelled);
    var executionId = await _sponsoredJournal.executionId(action);
    _checkCancellation(isCancelled);
    if (executionId == null) {
      if (!canAuthorize) {
        throw const UnknownFailure(
          userAction: 'Wallet action is not currently available for execution',
        );
      }
      final created = await executions.createOrderWalletActionExecution(
        orderId: action.orderId,
        actionId: action.actionId,
        mode: GasPaymentMode.appSponsored,
        idempotencyKey: scopedIdempotencyKey(
          'bstocks-sponsored-${action.orderId}-${action.actionId}',
        ),
      );
      executionId = created.executionId;
      await _sponsoredJournal.saveExecutionId(action, executionId);
    }
    if (await _sponsoredJournal.submissionStarted(executionId)) {
      await _reconcileSponsoredSubmission(executions, executionId);
      return;
    }
    // Preserve an execution created before cancellation, but do not sign it.
    _checkCancellation(isCancelled);
    final execution = await executions.get(executionId);
    _checkCancellation(isCancelled);
    if (_isSubmittedExecution(execution)) return;
    _checkExecutionFailure(execution);
    if (!canAuthorize) {
      throw const UnknownFailure(
        userAction:
            'Wallet action is not currently available for authorization',
      );
    }
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
    if (signer == null) {
      throw const UnknownFailure(
        userAction: 'bStocks wallet authorization signer unavailable',
      );
    }
    _checkCancellation(isCancelled);
    if (!action.validUntil.isAfter(DateTime.now().toUtc()) ||
        (execution.authorizationExpiresAt != null &&
            !execution.authorizationExpiresAt!.isAfter(
              DateTime.now().toUtc(),
            ))) {
      throw const UnknownFailure(
        userAction: 'Wallet authorization expired; reconcile the original execution before retrying',
      );
    }
    try {
      final signature = await signer
          .signWalletAuthorization(
            expectedSigner: action.from,
            request: authorization,
          )
          .timeout(const Duration(seconds: 55));
      _checkCancellation(isCancelled);
      await _sponsoredJournal.markSubmissionStarted(executionId);
      if (isCancelled?.call() ?? false) {
        // No POST has been issued, so this marker is provably unsent.
        await _sponsoredJournal.clearSubmissionStarted(executionId);
        throw const CancelledFailure();
      }
      final submitted = await _submitSponsoredAuthorization(
        executions,
        executionId,
        signature,
      );
      if (_isSubmittedExecution(submitted)) return;
      _checkExecutionFailure(submitted);
      throw UnknownFailure(
        retryable: true,
        userAction:
            'bStocks sponsored execution returned ${submitted.status.name}',
      );
    } on TimeoutException catch (error) {
      throw UnknownFailure(
        retryable: true,
        userAction:
            'bStocks sponsored authorization timed out: ${error.message ?? 'Privy did not return a signature'}',
      );
    } on WalletAuthorizationFailure catch (failure) {
      throw UnknownFailure(
        retryable: failure.retryable,
        userAction: [
          'bStocks sponsored authorization failed: ${failure.code.name}',
          if (failure.reason case final reason? when reason.trim().isNotEmpty)
            reason,
        ].join(' - '),
      );
    }
  });

  Future<WalletActionExecution> _submitSponsoredAuthorization(
    WalletActionExecutionRepository executions,
    String executionId,
    String signature,
  ) async {
    try {
      return await executions
          .submitAuthorization(
            executionId: executionId,
            signature: signature,
            // A new signature after a proven rejection is a new command.
            // Transport/auth retries of this request retain this key/body.
            idempotencyKey: newIdempotencyKey(),
          )
          .timeout(const Duration(seconds: 20));
    } on ApiFailure catch (failure) {
      // These API admission failures prove this request was not relayed.
      // A later user retry still GETs current O/A/E before any signature.
      if (failure is AuthenticationFailure ||
          failure is ServerFailure &&
              const {401, 403, 429}.contains(failure.statusCode)) {
        await _sponsoredJournal.clearSubmissionStarted(executionId);
        rethrow;
      }
      return _reconcileSponsoredSubmission(
        executions,
        executionId,
        submissionFailure: failure,
      );
    } on TimeoutException {
      return _reconcileSponsoredSubmission(
        executions,
        executionId,
        submissionFailure: const TimeoutFailure(
          userAction: 'Wallet authorization submission timed out',
        ),
      );
    }
  }

  Future<WalletActionExecution> _reconcileSponsoredSubmission(
    WalletActionExecutionRepository executions,
    String executionId, {
    ApiFailure? submissionFailure,
  }) async {
    ApiFailure? lastReadFailure;
    WalletActionExecution? lastExecution;
    for (
      var attempt = 0;
      attempt < _sponsoredReconciliationAttempts;
      attempt++
    ) {
      WalletActionExecution? execution;
      try {
        execution = await executions.get(executionId);
      } on ApiFailure catch (failure) {
        lastReadFailure = failure;
      }
      if (execution != null) {
        lastExecution = execution;
        if (_isSubmittedExecution(execution)) return execution;
        _checkExecutionFailure(execution);
      }
      if (attempt + 1 < _sponsoredReconciliationAttempts) {
        await Future<void>.delayed(_sponsoredReconciliationDelay);
      }
    }

    final detail = switch ((
      lastReadFailure,
      submissionFailure,
      lastExecution,
    )) {
      (final ApiFailure failure, _, _) => apiFailureMessage(
        failure,
        fallback: 'Execution status request failed',
      ),
      (_, final ApiFailure failure, _) => apiFailureMessage(
        failure,
        fallback: 'Authorization submission failed',
      ),
      (_, _, final WalletActionExecution execution) =>
        'execution remained ${execution.status.name}',
      _ => 'execution status is unavailable',
    };
    throw UnknownFailure(
      retryable: true,
      userAction:
          'Authorization was signed, but its execution status could not be confirmed: $detail',
    );
  }

  bool _isSubmittedExecution(WalletActionExecution execution) => const {
    WalletActionExecutionState.submitting,
    WalletActionExecutionState.providerSubmitted,
    WalletActionExecutionState.chainConfirmed,
    WalletActionExecutionState.completed,
  }.contains(execution.status);

  void _checkExecutionFailure(WalletActionExecution execution) {
    if (const {
      WalletActionExecutionState.ambiguous,
      WalletActionExecutionState.failed,
      WalletActionExecutionState.manualReview,
    }.contains(execution.status)) {
      throw UnknownFailure(
        retryable: execution.status == WalletActionExecutionState.ambiguous,
        userAction:
            execution.failureReason ??
            'bStocks sponsored execution ${execution.status.name}',
      );
    }
  }

  Future<String> _send(
    EmbeddedWalletTransactionSender sender,
    BstocksOrderAction action,
  ) async {
    if (!action.validUntil.isAfter(DateTime.now().toUtc())) {
      throw const WalletTransactionNotBroadcastFailure(
        userAction: 'Wallet action expired; reconcile the original action before retrying',
      );
    }
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
