import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/self_custodial_withdrawal.dart';

final selfCustodialWithdrawalProvider = FutureProvider.autoDispose
    .family<SelfCustodialWithdrawalSummary, String>(
      (ref, id) =>
          ref.watch(fundingRepositoryProvider).getSelfCustodialWithdrawal(id),
    );

final selfCustodialWithdrawalCommandsProvider = Provider(
  (ref) => SelfCustodialWithdrawalCommands(ref),
);

final class SelfCustodialWithdrawalCommands {
  SelfCustodialWithdrawalCommands(this._ref);
  final Ref _ref;
  final _guard = IdempotentCommandGuard();

  Future<SelfCustodialWithdrawalSummary> submit({
    required String withdrawalId,
    required String txHash,
  }) async {
    const operation = 'submit_self_custodial_withdrawal';
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
      final result = await _guard.run(
        operation: 'self-custodial-withdrawal-submit',
        fingerprint: '$withdrawalId|$txHash',
        command: (key) => _ref
            .read(fundingRepositoryProvider)
            .submitSelfCustodialWithdrawal(
              id: withdrawalId,
              txHash: txHash,
              idempotencyKey: key,
            ),
      );
      _ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'succeeded');
      _ref.invalidate(selfCustodialWithdrawalProvider(withdrawalId));
      return result;
    } on ApiFailure catch (failure, stackTrace) {
      _ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
          );
      rethrow;
    }
  }
}
