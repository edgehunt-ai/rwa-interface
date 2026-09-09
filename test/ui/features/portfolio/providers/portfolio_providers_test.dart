import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

void main() {
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
