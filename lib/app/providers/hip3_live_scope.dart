import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/api_failure.dart';
import '../../domain/models/hip3_live.dart';
import '../../domain/models/wallet.dart';
import 'api_providers.dart';
import 'hip3_live_provider.dart';
import 'hip3_query_refresh.dart';
import 'session_scope.dart';

/// Account execution environment, not the environment of a viewed public market.
/// Default matches the existing testnet-only client execution deployment.
final hip3AccountEnvironmentProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    'HIP3_ACCOUNT_ENVIRONMENT',
    defaultValue: 'testnet',
  ),
);

typedef Hip3LiveIdentity = ({
  String signer,
  String environment,
  int generation,
});

final hip3LiveIdentityProvider = FutureProvider.autoDispose<Hip3LiveIdentity?>((
  ref,
) async {
  final generation = ref.watch(sessionGenerationProvider).value;
  final enabled = ref.watch(hip3LiveEnabledProvider);
  final foreground = ref.watch(hip3ForegroundProvider);
  if (!enabled || !foreground) return null;
  final environment = ref.watch(hip3AccountEnvironmentProvider);
  if (environment != 'testnet' && environment != 'mainnet') {
    throw const CompatibilityFailure();
  }
  final repository = ref.watch(walletsRepositoryProvider);
  final ids = <String>{};
  final cursors = <String>{};
  final eligible = <Wallet>[];
  String? cursor;
  for (var pageIndex = 0; pageIndex < 20; pageIndex++) {
    final page = await repository.listWallets(cursor: cursor);
    if (!ref.mounted ||
        ref.read(sessionGenerationProvider).value != generation) {
      throw const CancelledFailure();
    }
    for (final wallet in page.items) {
      if (!ids.add(wallet.walletId) || ids.length > 1000) {
        throw const CompatibilityFailure();
      }
      if (wallet.chain.toLowerCase() == 'hyperliquid' &&
          wallet.status == WalletState.active) {
        eligible.add(wallet);
      }
    }
    if (!page.hasMore) {
      if (eligible.length != 1 ||
          eligible.single.address.length != 42 ||
          !RegExp(r'^0x[0-9a-fA-F]{40}$').hasMatch(eligible.single.address)) {
        throw const ServerFailure(
          statusCode: 503,
          code: 'hip3_live_wallet_unavailable',
        );
      }
      return (
        signer: eligible.single.address.toLowerCase(),
        environment: environment,
        generation: generation,
      );
    }
    cursor = page.nextCursor;
    if (cursor == null || cursor.isEmpty || !cursors.add(cursor)) {
      throw const CompatibilityFailure();
    }
  }
  throw const CompatibilityFailure();
}, retry: (_, _) => null);

/// One shared account stream, regardless of the number of visible query pages.
/// A missing/ambiguous wallet never falls back to a connected signing wallet.
final hip3AccountLiveProvider = Provider.autoDispose<Hip3LiveConnection>((ref) {
  final generation = ref.watch(sessionGenerationProvider).value;
  final identity = ref.watch(hip3LiveIdentityProvider);
  if (identity.hasError) {
    final error = identity.error;
    return Hip3LiveConnection(
      Hip3LivePhase.fallback,
      failure: error is ApiFailure ? error : const CompatibilityFailure(),
    );
  }
  final value = identity.asData?.value;
  if (value == null || value.generation != generation) {
    return const Hip3LiveConnection(Hip3LivePhase.disabled);
  }
  return ref.watch(
    hip3LiveConnectionProvider((
      query: Hip3LiveQuery(
        signer: value.signer,
        environment: value.environment,
        channels: {'hip3:orders', 'hip3:positions', 'hip3:balance'},
      ),
      generation: generation,
    )),
  );
});
