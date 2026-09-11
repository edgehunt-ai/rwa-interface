import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/portfolio/views/assets_screen.dart';

void main() {
  testWidgets('Assets exposes API-backed allocation and type-tab states', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const AssetsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Assets'), findsWidgets);
    expect(find.text(r'$248.32 (+2.01%) Today'), findsOneWidget);
    expect(find.text('View portfolio trend'), findsNothing);
    expect(find.byKey(const Key('portfolio-trend-trigger')), findsOneWidget);
    expect(find.text('Allocation'), findsOneWidget);
    expect(find.text('Cash balances'), findsOneWidget);
    await tester.tap(find.text('Allocation'));
    await tester.pump();
    expect(find.text('Cash · 25.8%'), findsOneWidget);
    expect(find.text('bStocks · 44.6%'), findsOneWidget);
    expect(find.text('Perps · 29.6%'), findsOneWidget);
    expect(find.text('\$3,240.2'), findsOneWidget);
    expect(find.text('\$5,610.22'), findsOneWidget);
    expect(find.text('\$3,730'), findsOneWidget);
    await tester.tap(find.text('bStocks'));
    await tester.pumpAndSettle();
    expect(find.text('bStocks'), findsWidgets);
    expect(find.text('Buy a bStock to see it here.'), findsOneWidget);
    await tester.tap(find.byKey(const Key('portfolio-trend-trigger')));
    await tester.pump();
    expect(find.text('Portfolio trend'), findsOneWidget);
  });

  testWidgets('Assets keeps allocation loading within its layout bounds', (
    tester,
  ) async {
    final accounts = Completer<List<TradingAccount>>();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _LoadingAccountsPortfolio(accounts),
          ),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const AssetsScreen()),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(tester.takeException(), isNull);
    expect(find.text('Allocation'), findsOneWidget);
    accounts.complete(const []);
  });

  testWidgets('Assets derives allocation from available account balances', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _BalanceOnlyPortfolio(),
          ),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const AssetsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Allocation unavailable'), findsNothing);
    expect(
      find.text('Cash 100.0% · bStocks 0.0% · Perps 0.0%'),
      findsOneWidget,
    );
  });

  testWidgets('Assets shows the Figma empty portfolio state', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(_EmptyPortfolio()),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const AssetsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text(r'$0.00'), findsOneWidget);
    expect(find.text('No assets yet'), findsOneWidget);
    expect(
      find.text('Deposit a supported asset to start\nbuilding your portfolio.'),
      findsOneWidget,
    );
    expect(find.text('Withdraw'), findsNothing);
    expect(find.text('Allocation'), findsNothing);
    expect(find.text('Cash'), findsNothing);
  });
}

final class _Portfolio implements PortfolioRepository {
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
    todayPnl: DecimalValue('248.32', asset: 'USD', unit: 'fiat'),
    todayPnlPercent: DecimalValue('2.01', unit: 'percent'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
      totalValueUsd: DecimalValue('3240.20', asset: 'USD', unit: 'fiat'),
      balances: [
        TokenBalance(
          symbol: 'USDC',
          chain: 'Arbitrum',
          decimals: 6,
          balance: DecimalValue('1240.2', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('1240.2', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
    TradingAccount(
      kind: TradingAccountKind.bstocks,
      totalValueUsd: DecimalValue('5610.22', asset: 'USD', unit: 'fiat'),
      balances: const [],
    ),
    TradingAccount(
      kind: TradingAccountKind.hip3,
      totalValueUsd: DecimalValue('3730.00', asset: 'USD', unit: 'fiat'),
      balances: const [],
    ),
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}

final class _LoadingAccountsPortfolio implements PortfolioRepository {
  _LoadingAccountsPortfolio(this._accounts);

  final Completer<List<TradingAccount>> _accounts;

  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('1', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() => _accounts.future;

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}

final class _BalanceOnlyPortfolio implements PortfolioRepository {
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('42', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('42', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
      balances: [
        TokenBalance(
          symbol: 'USDC',
          balance: DecimalValue('42', asset: 'USDC', unit: 'token'),
          valueUsd: DecimalValue('42', asset: 'USD', unit: 'fiat'),
        ),
      ],
    ),
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}

final class _EmptyPortfolio implements PortfolioRepository {
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => const [];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}
