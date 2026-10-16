import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/views/withdrawal_screen.dart';
import 'package:nobell/ui/features/funding/providers/withdrawal_providers.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';

void main() {
  testWidgets('withdrawal asset picker returns to the selected form', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: AppRoutes.withdrawalAssetSelectPath,
      routes: [
        GoRoute(
          path: AppRoutes.withdrawalAssetSelectPath,
          builder: (_, _) => const WithdrawalScreen(showSelector: true),
        ),
        GoRoute(
          path: AppRoutes.withdrawalPath,
          builder: (_, state) => WithdrawalScreen(
            token: state.uri.queryParameters['token'] ?? 'USDC',
            chain: state.uri.queryParameters['chain'] ?? 'Arbitrum',
          ),
        ),
        GoRoute(
          path: AppRoutes.assetsPath,
          builder: (_, _) => const Scaffold(body: Text('Assets fallback')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          withdrawalAssetsProvider.overrideWith(
            (_) async => [
              WithdrawableAsset(
                symbol: 'USDC',
                chain: 'Arbitrum',
                balance: DecimalValue('100', asset: 'USDC', unit: 'token'),
                availableBalance: DecimalValue(
                  '100',
                  asset: 'USDC',
                  unit: 'token',
                ),
                decimals: 6,
                withdrawable: true,
              ),
            ],
          ),
          tradingAccountsProvider.overrideWith(
            (_) async => [
              TradingAccount(
                kind: TradingAccountKind.app,
                chain: 'Arbitrum',
                balances: [
                  TokenBalance(
                    symbol: 'USDC',
                    balance: DecimalValue('100', asset: 'USDC', unit: 'token'),
                    chain: 'Arbitrum',
                  ),
                ],
              ),
            ],
          ),
        ],
        child: MaterialApp.router(
          theme: AppTheme.light,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('USDC').first);
    await tester.pumpAndSettle();
    expect(find.text('Spot account'), findsOneWidget);
    expect(
      find.byKey(const ValueKey('withdrawal-network-selector')),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('withdrawal-token-selector')),
      findsOneWidget,
    );
    for (final arrowKey in const [
      ValueKey('withdrawal-network-selector-arrow'),
      ValueKey('withdrawal-token-selector-arrow'),
    ]) {
      expect(find.byKey(arrowKey), findsOneWidget);
      expect(tester.getSize(find.byKey(arrowKey)), const Size.square(20));
    }
    final routeCard = tester.getRect(
      find.byKey(const ValueKey('withdrawal-route-card')),
    );
    for (final rightAlignedKey in const [
      ValueKey('withdrawal-network-selector-arrow'),
      ValueKey('withdrawal-token-selector-arrow'),
      ValueKey('withdrawal-from-value'),
    ]) {
      expect(
        routeCard.right - tester.getRect(find.byKey(rightAlignedKey)).right,
        17,
      );
    }

    await tester.enterText(
      find.byKey(const ValueKey('withdrawal-address-field')),
      '0x1111111111111111111111111111111111111111',
    );
    await tester.enterText(
      find.byKey(const ValueKey('withdrawal-amount-field')),
      '12.5',
    );

    for (final selectorKey in const [
      ValueKey('withdrawal-network-selector'),
      ValueKey('withdrawal-token-selector'),
    ]) {
      await tester.tap(find.byKey(selectorKey));
      await tester.pumpAndSettle();
      expect(find.text('Search assets'), findsOneWidget);

      await tester.tap(find.text('Withdraw'));
      await tester.pumpAndSettle();
      expect(
        find.byKey(const ValueKey('withdrawal-route-card')),
        findsOneWidget,
      );
      expect(
        tester
            .widget<TextField>(
              find.byKey(const ValueKey('withdrawal-address-field')),
            )
            .controller!
            .text,
        '0x1111111111111111111111111111111111111111',
      );
      expect(
        tester
            .widget<TextField>(
              find.byKey(const ValueKey('withdrawal-amount-field')),
            )
            .controller!
            .text,
        '12.5',
      );
    }

    await tester.tap(find.byKey(const ValueKey('withdrawal-token-selector')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('USDC').first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Withdraw'));
    await tester.pumpAndSettle();
    expect(find.text('Search assets'), findsOneWidget);
  });
}
