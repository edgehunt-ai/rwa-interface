import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/deposit.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/funding_catalog.dart';
import '../../../../domain/models/resource_result.dart';
import '../../../../domain/models/trading_account.dart';
import '../../../../domain/repositories/realtime_repository.dart';

final depositDirectoryProvider = FutureProvider.autoDispose<DepositDirectory>((
  ref,
) {
  ref.watch(sessionGenerationProvider);
  return ref.watch(fundingRepositoryProvider).getDepositDirectory();
});
final unifiedFundingAccountProvider =
    FutureProvider.autoDispose<UnifiedFundingAccountSummary>((ref) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(fundingRepositoryProvider).getUnifiedFundingAccount();
    });
final depositInstructionProvider = FutureProvider.autoDispose
    .family<DepositInstruction, ({String chain, String token})>((ref, route) {
      ref.keepAlive();
      return ref.watch(depositDirectoryProvider.future).then((directory) {
        return directory.instructions
                .where(
                  (instruction) =>
                      instruction.chain == route.chain &&
                      instruction.token == route.token,
                )
                .firstOrNull ??
            (throw StateError(
              'Deposit route ${route.chain}:${route.token} is unavailable',
            ));
      });
    });
final depositRoutesProvider = FutureProvider.autoDispose<List<DepositRoute>>((
  ref,
) async {
  final directory = await ref.watch(depositDirectoryProvider.future);
  return directory.instructions
      .map(
        (instruction) => DepositRoute(
          chain: instruction.chain,
          token: instruction.token,
          minimumAmount: instruction.minimumAmount,
          confirmationsRequired: instruction.confirmationsRequired,
          isRecommended: _isRecommendedDepositRoute(
            DepositRoute(
              chain: instruction.chain,
              token: instruction.token,
              minimumAmount: instruction.minimumAmount,
              confirmationsRequired: instruction.confirmationsRequired,
            ),
          ),
        ),
      )
      .toList(growable: false);
});

typedef DepositBalanceMonitorKey = ({String chain, String token});

final class DepositBalanceChange {
  const DepositBalanceChange({
    required this.eventId,
    required this.chain,
    required this.token,
    required this.amount,
  });

  final String eventId;
  final String chain;
  final String token;
  final DecimalValue amount;
}

/// Watches the selected deposit asset for an increase over the opening snapshot.
final depositBalanceChangesProvider = StreamProvider.autoDispose
    .family<DepositBalanceChange, DepositBalanceMonitorKey>((
      ref,
      route,
    ) async* {
      ref.watch(sessionGenerationProvider);
      final balances = <String, DecimalValue>{};
      try {
        final accounts = await ref
            .watch(portfolioRepositoryProvider)
            .listAccounts();
        balances.addAll(_snapshotBalances(accounts, route));
      } on Object {
        // Without a trustworthy opening snapshot, the first SSE value is a
        // baseline rather than a confirmed incoming deposit.
      }

      await for (final event
          in ref
              .watch(realtimeRepositoryProvider)
              .subscribe(channels: const {'balances'})) {
        final update = _balanceUpdate(event, route);
        if (update == null) continue;
        final previous = balances[update.accountId];
        balances[update.accountId] = update.balance;
        if (previous == null || update.balance.compareTo(previous) <= 0) {
          continue;
        }
        yield DepositBalanceChange(
          eventId: event.id,
          chain: route.chain,
          token: route.token,
          amount: _difference(update.balance, previous),
        );
      }
    });

Map<String, DecimalValue> _snapshotBalances(
  List<TradingAccount> accounts,
  DepositBalanceMonitorKey route,
) => {
  for (final account in accounts)
    for (final balance in account.balances)
      if (_matches(
        route,
        symbol: balance.symbol,
        chain: balance.chain ?? account.chain,
      ))
        _accountId(
          account: account.kind.name,
          chain: account.chain,
          address: account.address,
        ): balance.balance,
};

_BalanceUpdate? _balanceUpdate(
  TypedRealtimeEvent event,
  DepositBalanceMonitorKey route,
) {
  if (event.kind != 'balance') return null;
  final data = event.payload['data'];
  if (data is! Map) return null;
  final account = data['account']?.toString();
  if (account == null) return null;
  final chain = data['chain']?.toString();
  final address = data['address']?.toString();
  final items = data['balances'];
  if (items is! List) return null;
  for (final item in items) {
    if (item is! Map) continue;
    final symbol = item['symbol']?.toString();
    final balance = item['balance']?.toString();
    final balanceChain = item['chain']?.toString() ?? chain;
    if (symbol == null ||
        balance == null ||
        !_matches(route, symbol: symbol, chain: balanceChain)) {
      continue;
    }
    try {
      return _BalanceUpdate(
        accountId: _accountId(account: account, chain: chain, address: address),
        balance: DecimalValue(balance, asset: route.token, unit: 'token'),
      );
    } on FormatException {
      return null;
    }
  }
  return null;
}

bool _matches(
  DepositBalanceMonitorKey route, {
  required String symbol,
  required String? chain,
}) => symbol == route.token && chain == route.chain;

String _accountId({
  required String account,
  required String? chain,
  required String? address,
}) => '$account|${chain ?? ''}|${address ?? ''}';

DecimalValue _difference(DecimalValue current, DecimalValue previous) {
  final scale = current.scale > previous.scale ? current.scale : previous.scale;
  final difference = _toAtomic(current, scale) - _toAtomic(previous, scale);
  final sign = difference.isNegative ? '-' : '';
  final digits = difference.abs().toString().padLeft(scale + 1, '0');
  final value = scale == 0
      ? '$sign$digits'
      : '$sign${digits.substring(0, digits.length - scale)}.'
            '${digits.substring(digits.length - scale)}';
  return DecimalValue(value, asset: current.asset, unit: current.unit);
}

BigInt _toAtomic(DecimalValue value, int scale) {
  final negative = value.value.startsWith('-');
  final unsigned = negative ? value.value.substring(1) : value.value;
  final parts = unsigned.split('.');
  final digits = '${parts.first}${parts.length == 1 ? '' : parts.last}'
      .padRight(parts.first.length + scale, '0');
  final parsed = BigInt.parse(digits);
  return negative ? -parsed : parsed;
}

final class _BalanceUpdate {
  const _BalanceUpdate({required this.accountId, required this.balance});
  final String accountId;
  final DecimalValue balance;
}

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
