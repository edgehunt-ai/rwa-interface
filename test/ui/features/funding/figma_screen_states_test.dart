import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/deposit.dart';
import 'package:rwa_interface/domain/models/funding_catalog.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';
import 'package:rwa_interface/ui/features/funding/views/deposit_screen.dart';
import 'package:rwa_interface/ui/features/funding/views/withdrawal_screen.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

import '../../../helpers/test_app.dart';
import '../../../helpers/display_config.dart';

void main() {
  testWidgets('deposit routes loading state fits a short viewport', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(415, 260));
    final pendingRoutes = Completer<List<DepositRoute>>();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositRoutesProvider.overrideWith((_) => pendingRoutes.future),
        ],
        child: buildTestApp(const DepositRoutesSheet()),
      ),
    );
    await tester.pump();

    expect(find.byType(SingleChildScrollView), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('deposit asset selector shows additional available routes', (
    tester,
  ) async {
    final router = AppRouter.create(initialLocation: '/funding/deposit/select');
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositRoutesProvider.overrideWith((_) async => _depositRoutes),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(DepositScreen), findsOneWidget);
    expect(find.text('Deposit crypto'), findsOneWidget);
    expect(find.text('Deposit USDC on BSC'), findsOneWidget);
    expect(find.text('Deposit USDC on Arbitrum'), findsOneWidget);
  });

  testWidgets('deposit instructions render the API QR payload', (tester) async {
    const payload =
        'ethereum:0xaf88d065e77c8cc2239327c5edb3a432268e5831@42161/'
        'transfer?address=0x1111111111111111111111111111111111111111';
    final instruction = DepositInstruction(
      chain: 'Arbitrum',
      token: 'USDC',
      tokenContract: '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
      tokenDecimals: 6,
      address: '0x1111111111111111111111111111111111111111',
      qrPayload: payload,
      minimumAmount: DecimalValue('1', asset: 'USDC', unit: 'token'),
      confirmationsRequired: 20,
      estimatedArrivalSeconds: 60,
      warning: 'Send USDC only.',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider((chain: 'Arbitrum', token: 'USDC'))
              .overrideWith((_) async => instruction),
        ],
        child: buildTestApp(
          const DepositScreen(chain: 'Arbitrum', token: 'USDC'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byKey(const ValueKey('deposit-qr')), findsOneWidget);
    expect(find.byType(QrImageView), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Network')).dy,
      lessThan(tester.getTopLeft(find.text('Token')).dy),
    );
  });

  testWidgets('balance increase opens the deposit received sheet', (
    tester,
  ) async {
    const route = (chain: 'Arbitrum', token: 'USDC');
    final instruction = _depositInstruction(route);
    final change = DepositBalanceChange(
      eventId: 'balance-1',
      chain: route.chain,
      token: route.token,
      amount: DecimalValue('1000', asset: route.token, unit: 'token'),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositInstructionProvider(route)
              .overrideWith((_) async => instruction),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => Stream.value(change)),
        ],
        child: buildTestApp(
          DepositScreen(chain: route.chain, token: route.token),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Deposit assets'), findsOneWidget);
    expect(find.text('Deposit received'), findsOneWidget);
    expect(find.text('+ 1,000 USDC (Arbitrum)'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Got it'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Got it'));
    await tester.pumpAndSettle();
    expect(find.text('Deposit received'), findsNothing);
  });

  testWidgets('withdrawal picker shows available assets', (tester) async {
    final router = AppRouter.create(
      initialLocation: '/funding/withdraw/select',
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tradingAccountsProvider.overrideWith((_) async => _accounts),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(WithdrawalScreen), findsOneWidget);
    expect(find.text('Select asset'), findsOneWidget);
    expect(find.text('USD Coin · Arbitrum'), findsOneWidget);
    expect(find.text('Native'), findsNothing);
    expect(find.text('USDT'), findsNothing);

    await tester.tap(find.text('USDC'));
    await tester.pumpAndSettle();
    expect(find.text('Withdraw USDC'), findsOneWidget);
  });

  testWidgets('withdrawal picker retry refreshes account balances', (
    tester,
  ) async {
    var requests = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tradingAccountsProvider.overrideWith((_) async {
            requests += 1;
            if (requests == 1) throw StateError('accounts unavailable');
            return _accounts;
          }),
        ],
        child: buildTestApp(const WithdrawalScreen(showSelector: true)),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Unable to load assets'), findsOneWidget);
    expect(requests, 1);

    await tester.tap(find.widgetWithText(FilledButton, 'Retry'));
    await tester.pumpAndSettle();

    expect(requests, 2);
    expect(find.text('USD Coin · Arbitrum'), findsOneWidget);
  });

  testWidgets('deposit instruction retry refreshes its directory', (
    tester,
  ) async {
    const route = (chain: 'Arbitrum', token: 'USDC');
    var requests = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          depositDirectoryProvider.overrideWith((_) async {
            requests += 1;
            if (requests == 1) throw StateError('directory unavailable');
            return DepositDirectory(
              instructions: [_depositInstruction(route)],
              updatedAt: DateTime.utc(2026),
            );
          }),
          depositBalanceChangesProvider(route)
              .overrideWith((_) => const Stream.empty()),
        ],
        child: buildTestApp(
          const DepositScreen(chain: 'Arbitrum', token: 'USDC'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Deposit instructions unavailable'), findsOneWidget);
    expect(requests, 1);

    await tester.tap(find.widgetWithText(FilledButton, 'Retry'));
    await tester.pumpAndSettle();

    expect(requests, 2);
    expect(find.byKey(const ValueKey('deposit-qr')), findsOneWidget);
  });

  testWidgets('withdrawal form validates input then presents its quote', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(_Funding()),
          tradingAccountsProvider.overrideWith((_) async => _accounts),
        ],
        child: _fundingApp(const WithdrawalScreen()),
      ),
    );

    final reviewButton = find.widgetWithText(FilledButton, 'Review withdrawal');
    await tester.scrollUntilVisible(
      reviewButton,
      160,
      scrollable: find.byType(Scrollable).first,
    );
    final disabledButton = tester.widget<FilledButton>(reviewButton);
    expect(disabledButton.onPressed, isNull);

    await tester.enterText(
      find.byType(TextField).at(0),
      '0x1111111111111111111111111111111111111111',
    );
    await tester.enterText(find.byType(TextField).at(1), '5');
    await tester.pump();
    expect(tester.widget<FilledButton>(reviewButton).onPressed, isNotNull);
    await tester.scrollUntilVisible(
      reviewButton,
      160,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(reviewButton);
    await tester.pumpAndSettle();

    expect(find.text('Review withdrawal'), findsOneWidget);
    expect(find.text('5 USDC'), findsWidgets);
    expect(find.text('4.9 USDC'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Withdraw USDC'), findsOneWidget);
  });

  testWidgets('withdrawal rejects an invalid recipient before quoting', (
    tester,
  ) async {
    final funding = _CountingFunding();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          tradingAccountsProvider.overrideWith((_) async => _accounts),
        ],
        child: _fundingApp(const WithdrawalScreen()),
      ),
    );
    await tester.pumpAndSettle();

    final addressField = find.byKey(const ValueKey('withdrawal-address-field'));
    await tester.enterText(addressField, 'ffgg');
    await tester.tap(find.byKey(const ValueKey('withdrawal-amount-field')));
    await tester.pump();

    expect(find.text('Enter a valid wallet address.'), findsOneWidget);
    expect(
      tester.widget<TextField>(addressField).decoration!.errorText,
      'Enter a valid wallet address.',
    );
    expect(funding.quoteRequests, 0);

    await tester.enterText(
      addressField,
      '0x1111111111111111111111111111111111111111',
    );
    await tester.pump();
    expect(find.text('Enter a valid wallet address.'), findsNothing);
  });
}

final _accounts = [
  TradingAccount(
    kind: TradingAccountKind.app,
    chain: 'Arbitrum',
    balances: [
      TokenBalance(
        symbol: 'USDC',
        balance: DecimalValue('1240.20', asset: 'USDC', unit: 'token'),
        valueUsd: DecimalValue('1240.20', asset: 'USD', unit: 'fiat'),
        decimals: 2,
        chain: 'Arbitrum',
      ),
      TokenBalance(
        symbol: 'USDT',
        balance: DecimalValue('580', asset: 'USDT', unit: 'token'),
        valueUsd: DecimalValue('580', asset: 'USD', unit: 'fiat'),
        decimals: 2,
        chain: 'BSC',
      ),
    ],
  ),
];

DepositInstruction _depositInstruction(DepositBalanceMonitorKey route) =>
    DepositInstruction(
      chain: route.chain,
      token: route.token,
      tokenContract: '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
      tokenDecimals: 6,
      address: '0x1111111111111111111111111111111111111111',
      qrPayload:
          'ethereum:0xaf88d065e77c8cc2239327c5edb3a432268e5831@42161/'
          'transfer?address=0x1111111111111111111111111111111111111111',
      minimumAmount: DecimalValue('1', asset: route.token, unit: 'token'),
      confirmationsRequired: 20,
      estimatedArrivalSeconds: 60,
      warning: 'Send ${route.token} only.',
    );

Widget _fundingApp(Widget home) => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);

final _depositRoutes = [
  DepositRoute(
    chain: 'Arbitrum',
    token: 'USDC',
    minimumAmount: DecimalValue('1', asset: 'USDC', unit: 'token'),
    confirmationsRequired: 20,
    isRecommended: true,
  ),
  DepositRoute(
    chain: 'BSC',
    token: 'USDC',
    minimumAmount: DecimalValue('1', asset: 'USDC', unit: 'token'),
    confirmationsRequired: 15,
  ),
];

class _Funding implements FundingRepository {
  @override
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  }) async => WithdrawalQuote(
    quoteId: 'quote-1',
    intent: intent,
    totalFee: DecimalValue('0.1', asset: 'USDC', unit: 'token'),
    estimatedReceive: DecimalValue('4.9', asset: 'USDC', unit: 'token'),
    sufficient: true,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _CountingFunding extends _Funding {
  var quoteRequests = 0;

  @override
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  }) {
    quoteRequests += 1;
    return super.quoteWithdrawal(intent, idempotencyKey: idempotencyKey);
  }
}
