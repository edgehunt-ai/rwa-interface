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
  testWidgets('Assets exposes allocation and type-tab states', (tester) async {
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
    expect(find.text('Allocation'), findsOneWidget);
    expect(find.text('Cash balances'), findsOneWidget);
    await tester.tap(find.text('Allocation'));
    await tester.pump();
    expect(find.text('bStocks · 45%'), findsOneWidget);
    await tester.tap(find.text('bStocks'));
    await tester.pumpAndSettle();
    expect(find.text('bStocks'), findsWidgets);
  });
}

final class _Portfolio implements PortfolioRepository {
  @override
  Future<Portfolio> getSummary() async => Portfolio(
    totalValueUsd: DecimalValue('12580.42', asset: 'USD', unit: 'fiat'),
    availableToTradeUsd: DecimalValue('0', asset: 'USD', unit: 'fiat'),
  );

  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
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
  ];

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) async =>
      const DomainPage(items: []);
}
