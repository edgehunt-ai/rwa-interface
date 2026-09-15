import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/portfolio.dart';
import '../../../../domain/models/portfolio_history.dart';
import '../../../../domain/repositories/portfolio_repository.dart';
import '../../../../domain/models/trading_account.dart';

const portfolioListCacheDuration = Duration(minutes: 30);

void _cachePortfolioList(Ref ref) {
  final link = ref.keepAlive();
  final timer = Timer(portfolioListCacheDuration, link.close);
  ref.onDispose(timer.cancel);
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

final holdingsProvider = FutureProvider.autoDispose
    .family<DomainPage<HoldingGroup>, String?>((ref, cursor) {
      _cachePortfolioList(ref);
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(portfolioRepositoryProvider)
          .listHoldings(cursor: cursor);
    });
