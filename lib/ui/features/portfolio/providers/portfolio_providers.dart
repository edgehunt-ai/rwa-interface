import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/portfolio.dart';
import '../../../../domain/models/trading_account.dart';

final portfolioSummaryProvider = FutureProvider.autoDispose<Portfolio>((ref) {
  ref.watch(sessionGenerationProvider);
  return ref.watch(portfolioRepositoryProvider).getSummary();
});

final tradingAccountsProvider =
    FutureProvider.autoDispose<List<TradingAccount>>((ref) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(portfolioRepositoryProvider).listAccounts();
    });

final holdingsProvider = FutureProvider.autoDispose
    .family<DomainPage<HoldingGroup>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(portfolioRepositoryProvider)
          .listHoldings(cursor: cursor);
    });
