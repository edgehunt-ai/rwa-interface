import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/deposit.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/funding_catalog.dart';
import '../../../../domain/models/resource_result.dart';

final fundingCatalogProvider = FutureProvider.autoDispose<FundingCatalog>((
  ref,
) {
  ref.watch(sessionGenerationProvider);
  return ref.watch(fundingRepositoryProvider).getCatalog();
});
final depositsProvider = FutureProvider.autoDispose
    .family<DomainPage<ResourceResult<Deposit>>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(fundingRepositoryProvider).listDeposits(cursor: cursor);
    });
final depositProvider = FutureProvider.autoDispose
    .family<ResourceResult<Deposit>, String>((ref, id) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(fundingRepositoryProvider).getDeposit(id);
    });
final depositCommandsProvider = Provider.autoDispose(
  (ref) => DepositCommands(ref),
);

final class DepositCommands {
  DepositCommands(this._ref);
  final Ref _ref;
  final IdempotentCommandGuard _commands = IdempotentCommandGuard();
  Future<ResourceResult<Deposit>> create({
    required String chain,
    String? amount,
  }) async {
    final result = await _commands.run(
      operation: 'deposit',
      fingerprint: '$chain|$amount',
      command: (key) => _ref
          .read(fundingRepositoryProvider)
          .createDeposit(chain: chain, amount: amount, idempotencyKey: key),
    );
    _ref.invalidate(depositsProvider);
    _ref.invalidate(depositProvider(result.resource.depositId));
    return result;
  }
}
