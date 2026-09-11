import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/routing/routes.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/views/withdrawal_screen.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

void main() {
  testWidgets('withdrawal form back button returns to asset selection', (
    tester,
  ) async {
    final router = GoRouter(
      initialLocation: AppRoutes.withdrawalSelectPath,
      routes: [
        GoRoute(
          path: AppRoutes.withdrawalSelectPath,
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
    expect(find.text('Withdraw USDC'), findsOneWidget);

    await tester.tap(find.byType(IconButton).first);
    await tester.pumpAndSettle();
    expect(find.text('Select asset'), findsOneWidget);
  });
}
