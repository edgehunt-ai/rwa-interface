import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/funding_transfer.dart';
import '../../../../domain/models/withdrawal.dart';
import '../../../../domain/models/funding_session.dart';
import '../../../../domain/models/funding_catalog_summary.dart';

final fundingCatalogProvider =
    FutureProvider.autoDispose<FundingCatalogSummary>(
      (ref) => ref.watch(fundingRepositoryProvider).getFundingCatalog(),
    );

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

  Future<FundingPlan> plan({required String tradePreviewId}) async {
    final result = await _run(
      operation: 'funding_plan',
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

  Future<WalletAuthorization> authorize(FundingPlan plan) {
    final leg = plan.nextActionableLeg;
    if (!plan.isActionable || leg == null) {
      throw StateError('Funding plan has no actionable server-selected source');
    }
    return _run(
      operation: 'funding_authorization',
      command: () => _ref
          .read(walletsRepositoryProvider)
          .authorizeFundingTransfer(
            walletId: leg.walletId,
            planId: plan.planId,
            asset: leg.asset,
            maximumAmount: leg.maximumAmount.value,
            idempotencyKey:
                'transfer-authorization-${plan.planId}-${leg.legId}',
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
    return result;
  }

  Future<T> _run<T>({
    required String operation,
    required Future<T> Function() command,
  }) {
    _recordOperation(operation, outcome: 'started');
    try {
      final request = command();
      unawaited(
        request.then<void>(
          (_) => _recordOperation(operation, outcome: 'succeeded'),
          onError: (Object error, StackTrace stackTrace) {
            _recordFailure(operation, error, stackTrace);
          },
        ),
      );
      return request;
    } on ApiFailure catch (failure, stackTrace) {
      _recordFailure(operation, failure, stackTrace);
      rethrow;
    }
  }

  void _recordOperation(String operation, {required String outcome}) {
    if (!_ref.mounted) return;
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: outcome);
  }

  void _recordFailure(String operation, Object error, StackTrace stackTrace) {
    if (!_ref.mounted || error is! ApiFailure) return;
    _ref
        .read(observabilityReporterProvider)
        .recordApiFailure(
          operation: operation,
          failure: error,
          stackTrace: stackTrace,
        );
  }
}
