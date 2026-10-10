import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/repositories/portfolio_repository.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';

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

  test('the bStocks order balance excludes the HIP-3 account', () async {
    final container = ProviderContainer(
      overrides: [
        tradingAccountsProvider.overrideWith(
          (_) async => [
            _account(TradingAccountKind.app, '6'),
            _account(TradingAccountKind.app, '2.5'),
            _account(TradingAccountKind.bstocks, '3'),
            _account(TradingAccountKind.hip3, '10'),
          ],
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(
      (await container.read(bstocksOrderAvailableBalanceProvider.future)).value,
      '11.5',
    );
  });

  test(
    'bStocks sell availability uses one matching fresh trading wallet',
    () async {
      final repository = _BstocksAvailabilityRepository();
      final container = ProviderContainer(
        overrides: [portfolioRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      final value = await container.read(
        bstocksSellAvailabilityProvider('product-1').future,
      );

      expect(repository.productId, 'product-1');
      expect(value?.value, '1.25');
    },
  );
}

TradingAccount _account(TradingAccountKind kind, String availableUsd) =>
    TradingAccount(
      kind: kind,
      balances: const [],
      availableUsd: DecimalValue(availableUsd, asset: 'USD', unit: 'fiat'),
    );

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

final class _BstocksAvailabilityRepository
    implements PortfolioRepository, PortfolioAssetsRepository {
  String? productId;

  @override
  Future<List<TradingAccount>> listAccounts() async => const [
    TradingAccount(
      kind: TradingAccountKind.bstocks,
      balances: [],
      walletId: 'trading-wallet',
    ),
  ];

  @override
  Future<List<PortfolioAsset>> listAssets({
    String? cursor,
    String? productId,
  }) async {
    this.productId = productId;
    return [
      PortfolioAsset(
        assetId: 'valid',
        network: 'BSC',
        symbol: 'NVDAB',
        decimals: 18,
        balance: DecimalValue('2'),
        walletId: 'trading-wallet',
        productId: 'product-1',
        bstocksAvailableQuantity: DecimalValue('1.25'),
        bstocksAvailabilityStatus: 'complete',
        freshness: 'live',
      ),
      PortfolioAsset(
        assetId: 'other-wallet',
        network: 'BSC',
        symbol: 'NVDAB',
        decimals: 18,
        balance: DecimalValue('10'),
        walletId: 'another-wallet',
        productId: 'product-1',
        bstocksAvailableQuantity: DecimalValue('9'),
        bstocksAvailabilityStatus: 'complete',
        freshness: 'live',
      ),
      PortfolioAsset(
        assetId: 'stale',
        network: 'BSC',
        symbol: 'NVDAB',
        decimals: 18,
        balance: DecimalValue('10'),
        walletId: 'trading-wallet',
        productId: 'product-1',
        bstocksAvailableQuantity: DecimalValue('8'),
        bstocksAvailabilityStatus: 'complete',
        freshness: 'stale',
      ),
    ];
  }

  @override
  Future<Portfolio> getSummary() => throw UnimplementedError();

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) =>
      throw UnimplementedError();
}
