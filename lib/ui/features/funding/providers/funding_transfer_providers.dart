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
    if (!session.canConfirmTransfer) {
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
          status: FundingPlanState.blocked,
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
      final generation = _transferDraftGeneration++;
      session = await _run(
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
    } else {
      session = existing;
    }
    if (session.status == 'funded') return session;
    if (_sameAllocations(session.allocations, allocations)) return session;

    try {
      return await _selectTransferSources(session, allocations);
    } on ServerFailure catch (failure) {
      if (failure.statusCode != 409) rethrow;
      session = await _ref
          .read(fundingRepositoryProvider)
          .getFundingSession(session.sessionId);
      _rememberTransferDraft(session, destination: destination, amount: amount);
      if (session.status == 'funded') return session;
      if (_sameAllocations(session.allocations, allocations)) return session;
      return _selectTransferSources(session, allocations);
    }
  });

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
        final refreshed = await _run(
          operation: 'funding_session_refresh',
          context: {'funding_session_id': sessionId},
          successContext: (session) => {'status': session.status},
          command: () =>
              _ref.read(fundingRepositoryProvider).getFundingSession(sessionId),
        );
        if (_transferDraft?.sessionId == sessionId) {
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
    for (final leg in plan.legs) {
      final transferId = leg.transferId;
      if (transferId == null) continue;
      final transfer = await _run(
        operation: 'funding_transfer_refresh',
        context: {'plan_id': plan.planId, 'transfer_id': transferId},
        command: () =>
            _ref.read(fundingRepositoryProvider).getFundingTransfer(transferId),
      );
      await _executeNextAction(transfer);
    }

    var refreshed = await refresh(plan.planId);
    if (refreshed.isActionable) {
      final authorization = await authorize(refreshed);
      await create(plan: refreshed, authorization: authorization);
      refreshed = await refresh(plan.planId);
    }
    return refreshed;
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
    await _executeNextAction(result);
    return result;
  }

  Future<void> _executeNextAction(FundingTransfer transfer) async {
    final actionId = transfer.nextActionId;
    if (actionId == null) return;
    final actionKey = '${transfer.transferId}|$actionId';
    if (_submittedTransferActions.contains(actionKey)) return;

    await _run(
      operation: 'funding_transfer_execute',
      context: {
        'transfer_id': transfer.transferId,
        'action_id': actionId,
        'mode': GasPaymentMode.appSponsored.name,
        'stage': 'execute',
      },
      command: () => _executeNextActionCommand(
        transfer: transfer,
        actionId: actionId,
        actionKey: actionKey,
      ),
    );
  }

  Future<void> _executeNextActionCommand({
    required FundingTransfer transfer,
    required String actionId,
    required String actionKey,
  }) async {
    final executions = _ref.read(walletActionExecutionRepositoryProvider);
    final execution = await executions.createTransferWalletActionExecution(
      transferId: transfer.transferId,
      actionId: actionId,
      mode: GasPaymentMode.appSponsored,
      idempotencyKey: scopedIdempotencyKey(
        'funding-transfer-execution-${transfer.transferId}-$actionId',
      ),
    );
    if (execution.requiresUserPaidFallback) {
      throw StateError('Sponsored transfer execution is unavailable');
    }
    final authorization = execution.authorization;
    if (!execution.awaitsAuthorization || authorization == null) {
      throw StateError(
        'Transfer execution is not awaiting wallet authorization',
      );
    }
    final signature = await _ref
        .read(walletAuthorizationSignerProvider)
        .signWalletAuthorization(
          expectedSigner: authorization.transaction.from,
          request: authorization,
        );
    final submitted = await executions.submitAuthorization(
      executionId: execution.executionId,
      signature: signature,
      idempotencyKey: scopedIdempotencyKey(
        'funding-transfer-execution-submit-${execution.executionId}',
      ),
    );
    switch (submitted.status) {
      case WalletActionExecutionState.submitting ||
          WalletActionExecutionState.providerSubmitted ||
          WalletActionExecutionState.chainConfirmed ||
          WalletActionExecutionState.completed:
        _submittedTransferActions.add(actionKey);
        return;
      case WalletActionExecutionState.awaitingUserAuthorization ||
          WalletActionExecutionState.userGasConfirmationRequired ||
          WalletActionExecutionState.failed ||
          WalletActionExecutionState.ambiguous ||
          WalletActionExecutionState.manualReview ||
          WalletActionExecutionState.unknown:
        throw StateError(
          submitted.failureReason ??
              'Transfer wallet execution did not start: ${submitted.status.name}',
        );
    }
  }

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
