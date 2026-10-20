import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../data/api/idempotency_key.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/funding_transfer.dart';
import '../../../../domain/models/funding_catalog.dart';
import '../../../../domain/models/withdrawal.dart';
import '../../../../domain/models/funding_session.dart';
import '../../../../domain/models/funding_catalog_summary.dart';
import '../../../../domain/models/order_intent.dart';
import '../../../../domain/models/wallet_action_execution.dart';
import '../../activity/providers/activity_provider.dart';

import 'funding_execution_validation.dart';

final fundingCatalogProvider =
    FutureProvider.autoDispose<FundingCatalogSummary>(
      (ref) => ref.watch(fundingRepositoryProvider).getFundingCatalog(),
      retry: (_, _) => null,
    );

final transferFundingAccountProvider =
    FutureProvider.autoDispose<UnifiedFundingAccountSummary>(
      (ref) => ref.watch(fundingRepositoryProvider).getUnifiedFundingAccount(),
      retry: (_, _) => null,
    );

final transferOptionsProvider = FutureProvider.autoDispose<TransferOptions>((
  ref,
) async {
  final catalogFuture = _optionalFundingCatalog(
    ref.watch(fundingCatalogProvider.future),
  );
  final accountFuture = ref.watch(transferFundingAccountProvider.future);
  final account = await accountFuture;
  final catalog = await catalogFuture;
  return TransferOptions(account: account, catalog: catalog);
}, retry: (_, _) => null);

Future<FundingCatalogSummary?> _optionalFundingCatalog(
  Future<FundingCatalogSummary> request,
) async {
  try {
    return await request;
  } on Exception {
    // FundingCatalog is a deprecated compatibility response. An unsupported
    // deposit rail must not prevent the transfer account from being usable.
    return null;
  }
}

final class TransferOptions {
  const TransferOptions({required this.account, required this.catalog});
  final UnifiedFundingAccountSummary account;
  final FundingCatalogSummary? catalog;
}

final class OrderFundingRequirement {
  const OrderFundingRequirement({
    required this.plan,
    required this.canConfirmTransfer,
  });

  final FundingPlan plan;
  final bool canConfirmTransfer;
}

final class FundingPlanProgress {
  const FundingPlanProgress({
    required this.plan,
    required this.requiresUserAction,
  });

  final FundingPlan plan;
  final bool requiresUserAction;
}

final fundingSessionProvider = FutureProvider.autoDispose
    .family<FundingSessionSummary, String>(
      (ref, id) => ref.watch(fundingRepositoryProvider).getFundingSession(id),
    );

final fundingPlanProvider = FutureProvider.autoDispose
    .family<FundingPlan, String>(
      (ref, id) => ref.watch(fundingRepositoryProvider).getFundingPlan(id),
    );

final fundingTransferProvider = FutureProvider.autoDispose
    .family<FundingTransfer, String>(
      (ref, id) => ref.watch(fundingRepositoryProvider).getFundingTransfer(id),
    );

// A transfer command spans wallet authorization and transfer creation. It is
// intentionally retained for the provider scope so its Ref remains valid
// across those asynchronous steps even when the initiating sheet rebuilds.
final fundingTransferCommandsProvider = Provider(
  (ref) => FundingTransferCommands(ref),
);

/// Keeps plan, wallet authorization, and transfer submission in the normal
/// presentation boundary. Callers never fabricate an authorization ID.
final class FundingTransferCommands {
  FundingTransferCommands(this._ref);
  final Ref _ref;
  final IdempotentCommandGuard _commands = IdempotentCommandGuard();
  final Set<String> _submittedTransferActions = <String>{};
  final Set<String> _authorizationSubmissions = <String>{};
  final Map<String, WalletActionExecution> _executions = {};
  Future<void> _quoteTail = Future<void>.value();
  FundingSessionSummary? _transferDraft;
  String? _transferDraftDestination;
  String? _transferDraftAmount;
  int _transferDraftGeneration = 0;

  Future<FundingPlan> plan({required String tradePreviewId}) async {
    final result = await _run(
      operation: 'funding_plan',
      successContext: (plan) => {'plan_id': plan.planId},
      command: () => _commands.run(
        operation: 'funding-plan',
        fingerprint: tradePreviewId,
        command: (key) => _ref
            .read(fundingRepositoryProvider)
            .createFundingPlan(
              tradePreviewId: tradePreviewId,
              idempotencyKey: key,
            ),
      ),
    );
    _ref.invalidate(fundingPlanProvider(result.planId));
    return result;
  }

  Future<OrderFundingRequirement> session({required OrderIntent intent}) async {
    final session = await _run(
      operation: 'funding_session',
      successContext: (session) => {
        'funding_session_id': session.sessionId,
        'status': session.status,
      },
      command: () => _commands.run(
        operation: 'funding-session',
        fingerprint: intent.fingerprint,
        command: (key) => _ref
            .read(fundingRepositoryProvider)
            .createFundingSession(intent: intent, idempotencyKey: key),
      ),
    );
    // A funded session already proves the target balance requirement is met.
    // Creating a plan after this response is both unnecessary and can make
    // the server re-evaluate an already-satisfied funding request.
    if (session.status == 'funded') {
      return OrderFundingRequirement(
        canConfirmTransfer: session.canConfirmTransfer,
        plan: FundingPlan(
          planId: session.sessionId,
          tradePreviewId: '',
          shortfall: DecimalValue('0'),
          status: FundingPlanState.alreadyFunded,
        ),
      );
    }
    if (!session.canSubmit) {
      // Use the session snapshot only to display funding requirements. This
      // blocked value has no executable legs and must never create a transfer.
      return OrderFundingRequirement(
        canConfirmTransfer: false,
        plan: FundingPlan(
          planId: session.sessionId,
          tradePreviewId: '',
          shortfall: DecimalValue(session.remainingMinimumTopUp ?? '0'),
          requiredTargetAmount: session.requiredTargetBalance == null
              ? null
              : DecimalValue(session.requiredTargetBalance!),
          targetAvailableAmount: session.targetAvailableAmount == null
              ? null
              : DecimalValue(session.targetAvailableAmount!),
          targetAsset: session.targetToken,
          targetNetwork: session.targetNetwork,
          status: session.requiresReview
              ? FundingPlanState.manualReview
              : FundingPlanState.blocked,
        ),
      );
    }
    final plan = await planForSession(session);
    return OrderFundingRequirement(
      plan: plan,
      canConfirmTransfer: session.canConfirmTransfer,
    );
  }

  Future<FundingPlan> transferSession({
    required String destination,
    required String amount,
    required Map<String, String> allocations,
  }) async {
    final selected = await quoteTransfer(
      destination: destination,
      amount: amount,
      allocations: allocations,
    );
    if (selected.status == 'funded') {
      return FundingPlan(
        planId: selected.sessionId,
        tradePreviewId: '',
        shortfall: DecimalValue('0'),
        status: FundingPlanState.alreadyFunded,
      );
    }
    return planForSession(selected);
  }

  Future<FundingSessionSummary> quoteTransfer({
    required String destination,
    required String amount,
    required Map<String, String> allocations,
  }) => _serializeQuote(() async {
    final existing = _transferDraft;
    late FundingSessionSummary session;
    if (existing == null ||
        _transferDraftDestination != destination ||
        _transferDraftAmount != amount) {
      session = await _createTransferDraft(
        destination: destination,
        amount: amount,
      );
    } else {
      session = await _run(
        operation: 'funding_session_refresh',
        context: {'funding_session_id': existing.sessionId},
        successContext: (session) => {'status': session.status},
        command: () => _ref
            .read(fundingRepositoryProvider)
            .getFundingSession(existing.sessionId),
      );
      _rememberTransferDraft(session, destination: destination, amount: amount);
      if (_startsFreshTransferSession(session.status)) {
        _forgetTransferDraft(session.sessionId);
        session = await _createTransferDraft(
          destination: destination,
          amount: amount,
        );
      }
    }
    if (!_selectionIsMutable(session.status)) return session;
    if (session.canConfirmTransfer &&
        _sameAllocations(session.allocations, allocations)) {
      return session;
    }

    try {
      return await _selectTransferSources(session, allocations);
    } on ServerFailure catch (failure) {
      if (failure.statusCode != 409) rethrow;
      session = await _ref
          .read(fundingRepositoryProvider)
          .getFundingSession(session.sessionId);
      _rememberTransferDraft(session, destination: destination, amount: amount);
      if (!_selectionIsMutable(session.status)) return session;
      if (session.canConfirmTransfer &&
          _sameAllocations(session.allocations, allocations)) {
        return session;
      }
      return _selectTransferSources(session, allocations);
    }
  });

  Future<FundingSessionSummary> _createTransferDraft({
    required String destination,
    required String amount,
  }) async {
    final generation = _transferDraftGeneration++;
    final session = await _run(
      operation: 'transfer_funding_session',
      successContext: (session) => {
        'funding_session_id': session.sessionId,
        'status': session.status,
      },
      command: () => _commands.run(
        operation: 'transfer-funding-session',
        fingerprint: '$destination|$amount|$generation',
        command: (key) => _ref
            .read(fundingRepositoryProvider)
            .createTransferFundingSession(
              destination: destination,
              amount: amount,
              idempotencyKey: key,
            ),
      ),
    );
    _rememberTransferDraft(session, destination: destination, amount: amount);
    return session;
  }

  bool _selectionIsMutable(String status) =>
      status == 'editing' ||
      status == 'readyToConfirm' ||
      status == 'ready_to_confirm';

  bool _startsFreshTransferSession(String status) =>
      status == 'funded' || status == 'expired' || status == 'cancelled';

  bool _sameAllocations(
    Map<String, String> current,
    Map<String, String> requested,
  ) {
    if (current.length != requested.length) return false;
    for (final entry in requested.entries) {
      if (current[entry.key] != entry.value) return false;
    }
    return true;
  }

  Future<FundingSessionSummary> _selectTransferSources(
    FundingSessionSummary session,
    Map<String, String> allocations,
  ) async {
    final selected = await _run(
      operation: 'funding_session_selection',
      context: {'funding_session_id': session.sessionId},
      successContext: (selected) => {'status': selected.status},
      command: () => _commands.run(
        operation: 'funding-session-selection',
        fingerprint: '${session.sessionId}|${session.version}|$allocations',
        command: (key) => _ref
            .read(fundingRepositoryProvider)
            .updateFundingSessionSelection(
              fundingSessionId: session.sessionId,
              version: session.version,
              allocations: allocations,
              idempotencyKey: key,
            ),
      ),
    );
    _transferDraft = selected;
    return selected;
  }

  Future<FundingSessionSummary> refreshTransferQuote(String sessionId) =>
      _serializeQuote(() async {
        final refreshingDraft = _transferDraft?.sessionId == sessionId;
        if (refreshingDraft) _transferDraft = null;
        final refreshed = await _run(
          operation: 'funding_session_refresh',
          context: {'funding_session_id': sessionId},
          successContext: (session) => {'status': session.status},
          command: () =>
              _ref.read(fundingRepositoryProvider).getFundingSession(sessionId),
        );
        if (refreshingDraft) {
          _transferDraft = refreshed;
        }
        return refreshed;
      });

  void _rememberTransferDraft(
    FundingSessionSummary session, {
    required String destination,
    required String amount,
  }) {
    _transferDraft = session;
    _transferDraftDestination = destination;
    _transferDraftAmount = amount;
  }

  void forgetTransferDraft(String sessionId) {
    _forgetTransferDraft(sessionId);
  }

  void _forgetTransferDraft(String sessionId) {
    if (_transferDraft?.sessionId != sessionId) return;
    _transferDraft = null;
    _transferDraftDestination = null;
    _transferDraftAmount = null;
  }

  Future<T> _serializeQuote<T>(Future<T> Function() operation) async {
    final previous = _quoteTail;
    final release = Completer<void>();
    _quoteTail = release.future;
    await previous;
    try {
      return await operation();
    } finally {
      release.complete();
    }
  }

  Future<FundingPlan> planForSession(FundingSessionSummary session) async {
    if (!session.canSubmit && session.status != 'transferring') {
      throw StateError('Funding session does not allow transfer confirmation');
    }
    final result = await _run(
      operation: 'funding_plan',
      context: {'funding_session_id': session.sessionId},
      successContext: (plan) => {'plan_id': plan.planId},
      command: () => _commands.run(
        operation: 'funding-plan-session',
        fingerprint: '${session.sessionId}|${session.version}',
        command: (key) => _ref
            .read(fundingRepositoryProvider)
            .createFundingSessionPlan(
              fundingSessionId: session.sessionId,
              selectionVersion: session.version,
              idempotencyKey: key,
            ),
      ),
    );
    _ref.invalidate(fundingPlanProvider(result.planId));
    return result;
  }

  Future<FundingPlan> refresh(String planId) => _run(
    operation: 'funding_plan_refresh',
    context: {'plan_id': planId},
    command: () => _ref.read(fundingRepositoryProvider).getFundingPlan(planId),
  );

  Future<FundingPlan> reconcile(FundingPlan plan) async {
    var refreshed = await refresh(plan.planId);
    if (!refreshed.shouldPoll) return refreshed;
    for (final leg in refreshed.legs) {
      final transferId = leg.transferId;
      if (transferId == null) continue;
      final transfer = await _run(
        operation: 'funding_transfer_refresh',
        context: {'plan_id': plan.planId, 'transfer_id': transferId},
        command: () =>
            _ref.read(fundingRepositoryProvider).getFundingTransfer(transferId),
      );
      await _executeNextAction(transfer);
      _ref.invalidate(fundingTransferProvider(transferId));
    }

    refreshed = await refresh(plan.planId);
    if (refreshed.isActionable) {
      final authorization = await authorize(refreshed);
      await create(plan: refreshed, authorization: authorization);
      refreshed = await refresh(plan.planId);
    }
    return refreshed;
  }

  Future<FundingPlanProgress> inspect(FundingPlan plan) async {
    // A stale transfer may no longer be readable after the plan has ended.
    // Always observe the authoritative plan before inspecting its transfers.
    final refreshed = await refresh(plan.planId);
    if (!refreshed.isExecuting && !refreshed.isActionable) {
      return FundingPlanProgress(plan: refreshed, requiresUserAction: false);
    }
    var requiresUserAction = false;
    for (final leg in refreshed.legs) {
      final transferId = leg.transferId;
      if (transferId == null) continue;
      final transfer = await _run(
        operation: 'funding_transfer_refresh',
        context: {'plan_id': plan.planId, 'transfer_id': transferId},
        command: () =>
            _ref.read(fundingRepositoryProvider).getFundingTransfer(transferId),
      );
      final actionId = transfer.nextActionId;
      if (actionId != null &&
          !_submittedTransferActions.contains('$transferId|$actionId')) {
        requiresUserAction = true;
      }
    }
    return FundingPlanProgress(
      plan: refreshed,
      requiresUserAction: requiresUserAction || refreshed.isActionable,
    );
  }

  Future<WalletAuthorization> authorize(FundingPlan plan) {
    final leg = plan.nextActionableLeg;
    if (!plan.isActionable || leg == null) {
      throw StateError('Funding plan has no actionable server-selected source');
    }
    return _run(
      operation: 'funding_authorization',
      context: {'plan_id': plan.planId, 'stage': 'authorize'},
      command: () => _ref
          .read(walletsRepositoryProvider)
          .authorizeFundingTransfer(
            walletId: leg.walletId,
            planId: plan.planId,
            asset: leg.asset,
            maximumAmount: leg.maximumAmount.value,
            idempotencyKey: scopedIdempotencyKey(
              'transfer-authorization-${plan.planId}-${leg.legId}',
            ),
          ),
    );
  }

  Future<FundingTransfer> create({
    required FundingPlan plan,
    required WalletAuthorization authorization,
  }) async {
    if (!plan.isActionable) {
      throw StateError('Funding plan does not allow transfer creation');
    }
    if (!authorization.isUsable) {
      throw StateError('Funding transfer authorization is not usable');
    }
    final result = await _run(
      operation: 'funding_transfer',
      context: {'plan_id': plan.planId, 'stage': 'create'},
      successContext: (transfer) => {'transfer_id': transfer.transferId},
      command: () => _commands.run(
        operation: 'funding-transfer',
        fingerprint: '${plan.planId}|${authorization.authorizationId}',
        command: (key) => _ref
            .read(fundingRepositoryProvider)
            .createFundingTransfer(
              planId: plan.planId,
              legId: plan.nextActionableLeg!.legId,
              authorizationId: authorization.authorizationId,
              idempotencyKey: key,
            ),
      ),
    );
    _ref.invalidate(fundingTransferProvider(result.transferId));
    _ref.invalidate(activityProvider);
    await _executeNextAction(result);
    return result;
  }

  Future<void> _executeNextAction(FundingTransfer transfer) async {
    final actionId = transfer.nextActionId;
    if (actionId == null || !transfer.canExecuteNextAction) return;
    final action = transfer.nextAction;
    if (action == null || action.actionId != actionId || action.mode == null) {
      throw StateError(
        'Transfer has no authoritative wallet action or gas mode',
      );
    }
    final actionKey = '${transfer.transferId}|$actionId';

    await _run(
      operation: 'funding_transfer_execute',
      context: {
        'transfer_id': transfer.transferId,
        'action_id': actionId,
        'mode': action.mode!.name,
        'stage': 'execute',
      },
      command: () => _commands.run(
        operation: 'funding-transfer-execute',
        fingerprint: actionKey,
        command: (_) => _executeNextActionCommand(
          transfer: transfer,
          action: action,
          actionKey: actionKey,
        ),
      ),
    );
  }

  Future<void> _executeNextActionCommand({
    required FundingTransfer transfer,
    required FundingTransferAction action,
    required String actionKey,
  }) async {
    final executions = _ref.read(walletActionExecutionRepositoryProvider);
    final created =
        _executions[actionKey] ??
        await executions.createTransferWalletActionExecution(
          transferId: transfer.transferId,
          actionId: action.actionId,
          mode: action.mode!,
          idempotencyKey: scopedIdempotencyKey(
            'funding-transfer-execution-${transfer.transferId}-${action.actionId}',
          ),
        );
    _validateTransferExecution(created, transfer, action);
    _executions[actionKey] = created;
    // A create replay is historical; only a fresh GET can grant signing authority.
    final execution = await executions.get(created.executionId);
    _validateTransferExecution(execution, transfer, action, previous: created);
    _executions[actionKey] = execution;
    if (_authorizationSubmissions.contains(execution.executionId) ||
        !execution.awaitsAuthorization) {
      return;
    }
    if (action.status != 'ready' ||
        !action.validUntil.isAfter(DateTime.now().toUtc())) {
      throw StateError('Transfer wallet action is no longer ready');
    }
    validateFundingAuthorization(execution);
    if (execution.authorizationExpiresAt!.isAfter(action.validUntil)) {
      throw StateError(
        'Authorization exceeds the frozen transfer action lifetime',
      );
    }
    final signature = await _ref
        .read(walletAuthorizationSignerProvider)
        .signWalletAuthorization(
          expectedSigner: action.from,
          request: execution.authorization!,
        );
    // Submission may reach the provider even when its response is lost.
    _authorizationSubmissions.add(execution.executionId);
    _submittedTransferActions.add(actionKey);
    await executions.submitAuthorization(
      executionId: execution.executionId,
      signature: signature,
      idempotencyKey: scopedIdempotencyKey(
        'funding-transfer-execution-submit-${execution.executionId}',
      ),
    );
  }

  void _validateTransferExecution(
    WalletActionExecution execution,
    FundingTransfer transfer,
    FundingTransferAction action, {
    WalletActionExecution? previous,
  }) => validateFundingExecution(
    execution: execution,
    resourceId: transfer.transferId,
    mode: action.mode!,
    chainId: action.chainId,
    from: action.from,
    transaction: action.transaction,
    previous: previous,
  );

  Future<T> _run<T>({
    required String operation,
    Map<String, String> context = const {},
    Map<String, String> Function(T result)? successContext,
    required Future<T> Function() command,
  }) async {
    final stopwatch = Stopwatch()..start();
    _recordOperation(operation, outcome: 'started', context: context);
    try {
      final result = await command();
      _recordOperation(
        operation,
        outcome: 'succeeded',
        context: {...context, ...?successContext?.call(result)},
        duration: stopwatch.elapsed,
      );
      return result;
    } on Object catch (error, stackTrace) {
      _recordFailure(
        operation,
        error,
        stackTrace,
        context: context,
        duration: stopwatch.elapsed,
      );
      rethrow;
    }
  }

  void _recordOperation(
    String operation, {
    required String outcome,
    Map<String, String> context = const {},
    Duration? duration,
  }) {
    if (!_ref.mounted) return;
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(
          operation,
          outcome: outcome,
          context: context,
          duration: duration,
        );
  }

  void _recordFailure(
    String operation,
    Object error,
    StackTrace stackTrace, {
    Map<String, String> context = const {},
    Duration? duration,
  }) {
    if (!_ref.mounted) return;
    final reporter = _ref.read(observabilityReporterProvider);
    if (error is ApiFailure) {
      reporter.recordApiFailure(
        operation: operation,
        failure: error,
        stackTrace: stackTrace,
        context: context,
        duration: duration,
      );
    } else {
      reporter.recordError(
        operation: operation,
        error: error,
        stackTrace: stackTrace,
        context: context,
        duration: duration,
      );
    }
  }
}
