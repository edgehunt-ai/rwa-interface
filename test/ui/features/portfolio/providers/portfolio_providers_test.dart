import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/app/providers/hip3_query_refresh.dart';
import 'package:rwa_interface/domain/models/portfolio_read_status.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

void main() {
  test('combining pages never upgrades partial or stale evidence', () {
    const partial = PortfolioReadStatus(
      completeness: PortfolioCompleteness.partial,
      freshness: PortfolioFreshness.stale,
      warnings: ['usingLastGood'],
    );
    const complete = PortfolioReadStatus(
      completeness: PortfolioCompleteness.complete,
      freshness: PortfolioFreshness.live,
    );
    for (final status in [partial.merge(complete), complete.merge(partial)]) {
      expect(status.reliable, isFalse);
      expect(status.completeness, PortfolioCompleteness.partial);
      expect(status.freshness, PortfolioFreshness.stale);
      expect(status.warnings, ['usingLastGood']);
    }
  });
  test('holdings refresh rereads all requested pages and restarts changed snapshot once', () async {
    final repository = _PagedPortfolio();
    final container = ProviderContainer(
      overrides: [portfolioRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(holdingsOverviewProvider, (_, _) {});
    addTearDown(subscription.close);
    expect(
      (await container.read(holdingsOverviewProvider.future))
          .items
          .single
          .symbol,
      'A1',
    );
    container.read(holdingsPageCountProvider.notifier).loadMore();
    final page = await container.read(holdingsOverviewProvider.future);
    expect(page.items.map((i) => i.symbol), ['B1', 'B2']);
    expect(repository.cursors, [null, null, 'A:1', null, 'B:1']);
    repository.version = 'C';
    container.read(hip3QueryRevisionProvider.notifier).refresh();
    expect(
      (await container.read(holdingsOverviewProvider.future)).items
          .map((i) => i.symbol),
      ['C1', 'C2'],
    );
    expect(repository.cursors.sublist(5), [null, 'C:1']);
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    expect(
      (await container.read(holdingsOverviewProvider.future)).items.length,
      1,
    );
  });
  test('summary is session-scoped and independent from accounts', () async {
    final repository = _PortfolioRepository();
    final container = ProviderContainer(
      overrides: [portfolioRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(portfolioSummaryProvider, (_, _) {});
    addTearDown(subscription.close);
    expect(
      (await container.read(portfolioSummaryProvider.future))
          .totalValueUsd
          .value,
      '1',
    );
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    expect(
      (await container.read(portfolioSummaryProvider.future))
          .totalValueUsd
          .value,
      '2',
    );
    expect(repository.accountCalls, 0);
  });
}

final class _PagedPortfolio implements PortfolioRepository {
  final cursors = <String?>[];
  var version = 'A';
  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async {
    cursors.add(cursor);
    if (cursor == 'A:1') {
      version = 'B';
      throw const ServerFailure(
        statusCode: 422,
        code: 'cursor_snapshot_changed',
      );
    }
    return DomainPage(
      items: [
        HoldingGroup(
          symbol: '$version${cursor == null ? 1 : 2}',
          totalValueUsd: DecimalValue('1', asset: 'USD', unit: 'fiat'),
          positions: const [],
        ),
      ],
      hasMore: cursor == null,
      nextCursor: cursor == null ? '$version:1' : null,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _PortfolioRepository implements PortfolioRepository {
  int summaryCalls = 0;
  int accountCalls = 0;
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue(
      '${++summaryCalls}',
      asset: 'USD',
      unit: 'fiat',
    ),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
  );
  @override
  Future<List<TradingAccount>> listAccounts() async {
    accountCalls++;
    return [];
  }

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}
