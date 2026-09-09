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
final depositInstructionProvider = FutureProvider.autoDispose
    .family<DepositInstruction, ({String chain, String token})>((ref, route) {
      ref.keepAlive();
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(fundingRepositoryProvider)
          .getDepositInstruction(chain: route.chain, token: route.token);
    });
final depositRoutesProvider = FutureProvider.autoDispose<List<DepositRoute>>((
  ref,
) async {
  final catalog = await ref.watch(fundingCatalogProvider.future);
  return catalog.depositRoutes
      .map(
        (route) => DepositRoute(
          chain: route.chain,
          token: route.token,
          minimumAmount: route.minimumAmount,
          confirmationsRequired: route.confirmationsRequired,
          isRecommended: _isRecommendedDepositRoute(route),
        ),
      )
      .toList(growable: false);
});

bool _isRecommendedDepositRoute(DepositRoute route) =>
    (route.chain == 'Arbitrum' && route.token == 'USDC') ||
    (route.chain == 'BSC' && route.token == 'USDT');

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
