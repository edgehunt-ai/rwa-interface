import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/portfolio.dart';
import '../../../../domain/models/portfolio_history.dart';
import '../../../../domain/repositories/portfolio_repository.dart';
import '../../../../domain/models/trading_account.dart';

const portfolioListCacheDuration = Duration(minutes: 30);
const portfolioListRefreshInterval = Duration(seconds: 30);

void _cachePortfolioList(Ref ref) {
  final link = ref.keepAlive();
  Timer? expiryTimer;
  Timer? refreshTimer;

  void stopRefresh() => refreshTimer?.cancel();
  void startRefresh() {
    refreshTimer?.cancel();
    refreshTimer = Timer.periodic(
      portfolioListRefreshInterval,
      (_) => ref.invalidateSelf(),
    );
  }

  expiryTimer = Timer(portfolioListCacheDuration, link.close);
  startRefresh();
  ref.onCancel(stopRefresh);
  ref.onResume(startRefresh);
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
