import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/portfolio.dart';
import '../../../../domain/models/portfolio_history.dart';
import '../../../../domain/models/portfolio_allocation.dart';
import '../../../../domain/repositories/portfolio_repository.dart';
import '../../../../domain/models/trading_account.dart';

const portfolioListCacheDuration = Duration(minutes: 30);
const portfolioListRefreshInterval = Duration(seconds: 30);

void _cachePortfolioList(Ref ref) {
  final link = ref.keepAlive();
  Timer? expiryTimer;
  Timer? refreshTimer;

  void stopTimers() {
    refreshTimer?.cancel();
    expiryTimer?.cancel();
  }

  void startRefresh() {
    refreshTimer?.cancel();
    refreshTimer = Timer.periodic(
      portfolioListRefreshInterval,
      (_) => ref.invalidateSelf(),
    );
  }

  void startExpiry() {
    expiryTimer?.cancel();
    expiryTimer = Timer(portfolioListCacheDuration, link.close);
  }

  startExpiry();
  startRefresh();
  ref.onCancel(stopTimers);
  ref.onResume(() {
    startExpiry();
    startRefresh();
  });
  ref.onDispose(() {
    expiryTimer?.cancel();
    refreshTimer?.cancel();
  });
}

final portfolioSummaryProvider = FutureProvider.autoDispose<Portfolio>((ref) {
  _cachePortfolioList(ref);
  ref.watch(sessionGenerationProvider);
  return ref.watch(portfolioRepositoryProvider).getSummary();
});

final portfolioRailAllocationProvider =
    FutureProvider.autoDispose<PortfolioRailAllocation>((ref) {
      _cachePortfolioList(ref);
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(portfolioRepositoryProvider);
      if (repository is PortfolioAllocationRepository) {
        return (repository as PortfolioAllocationRepository)
            .getRailAllocation();
      }
      return repository.listAccounts().then(_legacyAllocation);
    });

PortfolioRailAllocation _legacyAllocation(List<TradingAccount> accounts) {
  final labels = <TradingAccountKind, String>{
    TradingAccountKind.app: 'Cash',
    TradingAccountKind.bstocks: 'bStocks',
    TradingAccountKind.hip3: 'Perps',
  };
  final values = <TradingAccountKind, double>{};
  for (final account in accounts) {
    final accountValue = account.totalValueUsd == null
        ? account.balances.fold<double>(
            0,
            (sum, balance) =>
                sum +
                double.parse((balance.valueUsd ?? DecimalValue('0')).value),
          )
        : double.parse(account.totalValueUsd!.value);
    values[account.kind] = (values[account.kind] ?? 0) + accountValue;
  }
  final total = values.values.fold<double>(0, (sum, value) => sum + value);
  return PortfolioRailAllocation(
    items: values.entries
        .where((entry) => labels.containsKey(entry.key))
        .map(
          (entry) => PortfolioRailAllocationItem(
            rail: entry.key == TradingAccountKind.app
                ? 'cash'
                : entry.key == TradingAccountKind.bstocks
                ? 'bstock'
                : 'perp',
            valueUsd: DecimalValue(
              entry.value.toStringAsFixed(2),
              asset: 'USD',
              unit: 'fiat',
            ),
            percent: DecimalValue(
              total == 0 ? '0' : (entry.value / total * 100).toStringAsFixed(1),
              unit: 'percent',
            ),
          ),
        )
        .toList(growable: false),
    valuedTotalUsd: DecimalValue(
      total.toStringAsFixed(2),
      asset: 'USD',
      unit: 'fiat',
    ),
    unvaluedAssetCount: 0,
  );
}

final portfolioHistoryProvider = FutureProvider.autoDispose
    .family<PortfolioHistory?, PortfolioHistoryRange>((ref, range) {
      _cachePortfolioList(ref);
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(portfolioRepositoryProvider);
      if (repository is! PortfolioHistoryRepository) return null;
      return (repository as PortfolioHistoryRepository).getHistory(range);
    });

final tradingAccountsProvider =
    FutureProvider.autoDispose<List<TradingAccount>>((ref) {
      _cachePortfolioList(ref);
      ref.watch(sessionGenerationProvider);
      return ref.watch(portfolioRepositoryProvider).listAccounts();
    });

final bstocksOrderAvailableBalanceProvider =
    FutureProvider.autoDispose<DecimalValue>((ref) async {
      final accounts = await ref.watch(tradingAccountsProvider.future);
      return _sumAvailableUsd(
        accounts.where((account) => account.kind != TradingAccountKind.hip3),
      );
    });

final hip3OrderAvailableBalanceProvider =
    FutureProvider.autoDispose<DecimalValue>((ref) async {
      final accounts = await ref.watch(tradingAccountsProvider.future);
      return _sumAvailableUsd(accounts);
    });

DecimalValue _sumAvailableUsd(Iterable<TradingAccount> accounts) {
  final amounts = accounts
      .map((account) => account.availableUsd)
      .whereType<DecimalValue>()
      .toList(growable: false);
  if (amounts.isEmpty) {
    return DecimalValue('0', asset: 'USD', unit: 'fiat');
  }
  final scale = amounts.fold<int>(
    0,
    (current, amount) => current > amount.scale ? current : amount.scale,
  );
  var sum = BigInt.zero;
  for (final amount in amounts) {
    final negative = amount.value.startsWith('-');
    final unsigned = negative ? amount.value.substring(1) : amount.value;
    final parts = unsigned.split('.');
    final digits = '${parts.first}${parts.length == 1 ? '' : parts.last}'
        .padRight(parts.first.length + scale, '0');
    final parsed = BigInt.parse(digits);
    sum += negative ? -parsed : parsed;
  }
  final negative = sum.isNegative;
  final digits = sum.abs().toString().padLeft(scale + 1, '0');
  final value = scale == 0
      ? '${negative ? '-' : ''}$digits'
      : '${negative ? '-' : ''}${digits.substring(0, digits.length - scale)}.${digits.substring(digits.length - scale)}';
  return DecimalValue(value, asset: 'USD', unit: 'fiat');
}

final holdingsProvider = FutureProvider.autoDispose
    .family<DomainPage<HoldingGroup>, String?>((ref, cursor) {
      _cachePortfolioList(ref);
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(portfolioRepositoryProvider)
          .listHoldings(cursor: cursor);
    });
