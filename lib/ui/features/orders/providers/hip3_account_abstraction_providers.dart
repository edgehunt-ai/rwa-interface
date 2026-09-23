import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../features/account/providers/account_providers.dart';
import '../../../../domain/models/hip3_account_abstraction.dart';
import '../../../../domain/models/wallet.dart';

final hip3AccountAbstractionProvider =
    FutureProvider<Hip3AccountAbstractionStatus>((ref) async {
      ref.watch(sessionGenerationProvider);
      final account = await ref.watch(accountProvider.future);
      final wallets = await ref.watch(walletsProvider(null).future);
      final owner = wallets.items
          .where((wallet) => wallet.status == WalletState.active)
          .map((wallet) => wallet.address)
          .firstOrNull;
      if (owner != null) {
        final cached = await ref
            .read(hip3AccountAbstractionCacheProvider)
            .read(accountId: account.userId, ownerAddress: owner);
        if (cached != null) return cached;
      }
      final status = await ref
          .read(hip3AccountAbstractionRepositoryProvider)
          .getStatus();
      await ref
          .read(hip3AccountAbstractionCacheProvider)
          .write(accountId: account.userId, status: status);
      return status;
    });

final hip3AccountAbstractionCommandProvider = Provider(
  (ref) => Hip3AccountAbstractionCommands(ref),
);

final class Hip3AccountAbstractionCommands {
  Hip3AccountAbstractionCommands(this._ref);

  final Ref _ref;

  Future<Hip3AccountAbstractionStatus> ensureUnifiedAccount() async {
    final current = await _ref.read(hip3AccountAbstractionProvider.future);
    if (current.isUnifiedAccount) return current;
    if (!current.switchAvailable) {
      throw StateError('Unified Account switch is unavailable');
    }
    return convertToUnifiedAccount();
  }

  Future<Hip3AccountAbstractionStatus> convertToUnifiedAccount() async {
    final now = DateTime.now().microsecondsSinceEpoch;
    final result = await _ref
        .read(hip3AccountAbstractionRepositoryProvider)
        .switchToUnifiedAccount(
          prepareIdempotencyKey: 'hip3-unified-prepare-$now',
          executeIdempotencyKey: 'hip3-unified-execute-$now',
        );
    try {
      final account = await _ref.read(accountProvider.future);
      await _ref
          .read(hip3AccountAbstractionCacheProvider)
          .write(accountId: account.userId, status: result);
    } on Object {
      // The switch result remains authoritative even if cache persistence fails.
    }
    return result;
  }
}
