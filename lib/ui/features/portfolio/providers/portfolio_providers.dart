import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../app/providers/hip3_query_refresh.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/portfolio.dart';
import '../../../../domain/models/trading_account.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/portfolio_read_status.dart';

final holdingsPageCountProvider =
    NotifierProvider.autoDispose<HoldingsPageCount, int>(HoldingsPageCount.new);

final class HoldingsPageCount extends Notifier<int> {
  @override
  int build() {
    ref.watch(sessionGenerationProvider);
    return 1;
  }

  void loadMore() => state++;
}

/// Every refresh starts from page one and follows that snapshot's cursors.
/// Never append a new snapshot to the previously displayed holdings.
final holdingsOverviewProvider =
    FutureProvider.autoDispose<DomainPage<HoldingGroup>>((ref) {
      final repository = ref.watch(portfolioRepositoryProvider);
      final pages = ref.watch(holdingsPageCountProvider);
      return hip3RefreshingQuery(ref, () async {
        for (var attempt = 0; attempt < 2; attempt++) {
          final items = <HoldingGroup>[];
          final seen = <String>{};
          String? cursor;
          PortfolioReadStatus? status;
          try {
            for (var index = 0; index < pages; index++) {
              if (!ref.mounted) throw const CancelledFailure();
              final page = await repository.listHoldings(cursor: cursor);
              if (!ref.mounted) throw const CancelledFailure();
              items.addAll(page.items);
              final current =
                  page.portfolioStatus ?? const PortfolioReadStatus();
              status = status?.merge(current) ?? current;
              cursor = page.nextCursor;
              if (page.hasMore &&
                  (cursor == null || cursor.isEmpty || !seen.add(cursor))) {
                throw const DecodingFailure();
              }
              if (!page.hasMore || index == pages - 1) {
                return DomainPage(
                  items: List.unmodifiable(items),
                  nextCursor: page.nextCursor,
                  hasMore: page.hasMore,
                  portfolioStatus: status,
                );
              }
            }
          } on ServerFailure catch (failure) {
            if (attempt == 0 && failure.code == 'cursor_snapshot_changed') {
              continue;
            }
            rethrow;
          }
        }
        throw const DecodingFailure();
      });
    });

final portfolioSummaryProvider = FutureProvider.autoDispose<Portfolio>((ref) {
  ref.watch(sessionGenerationProvider);
  final repository = ref.watch(portfolioRepositoryProvider);
  return hip3RefreshingQuery(ref, repository.getSummary);
});

final tradingAccountsProvider =
    FutureProvider.autoDispose<List<TradingAccount>>((ref) {
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(portfolioRepositoryProvider);
      return hip3RefreshingQuery(ref, repository.listAccounts);
    });

final holdingsProvider = FutureProvider.autoDispose
    .family<DomainPage<HoldingGroup>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(portfolioRepositoryProvider);
      return hip3RefreshingQuery(
        ref,
        () => repository.listHoldings(cursor: cursor),
      );
    });
