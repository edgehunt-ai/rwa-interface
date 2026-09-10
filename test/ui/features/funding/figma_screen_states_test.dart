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
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';
import 'package:rwa_interface/ui/features/funding/views/deposit_screen.dart';
import 'package:rwa_interface/ui/features/funding/views/withdrawal_screen.dart';
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
    expect(find.text('USDC on BSC'), findsOneWidget);
    expect(find.text('USDC on Arbitrum'), findsOneWidget);
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

    expect(find.text('Deposit Assets'), findsOneWidget);
    expect(find.text('Deposit received !'), findsOneWidget);
    expect(find.text('+ 1,000 USDC (Arbitrum)'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Got it'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Got it'));
    await tester.pumpAndSettle();
    expect(find.text('Deposit received !'), findsNothing);
  });

  testWidgets('withdrawal picker shows available assets', (tester) async {
    final router = AppRouter.create(
      initialLocation: '/funding/withdraw/select',
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    expect(find.byType(WithdrawalScreen), findsOneWidget);
    expect(find.text('Select asset'), findsOneWidget);
    expect(find.text('Available to withdraw'), findsOneWidget);
    expect(find.text('USD Coin · Arbitrum'), findsOneWidget);
  });

  testWidgets('withdrawal form validates input then presents its quote', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [fundingRepositoryProvider.overrideWithValue(_Funding())],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const WithdrawalScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Review withdrawal'));
    await tester.pump();
    expect(find.text('Enter a recipient address and amount.'), findsOneWidget);

    await tester.enterText(find.byType(TextField).at(0), '0xrecipient');
    await tester.enterText(find.byType(TextField).at(1), '5');
    final review = find.widgetWithText(FilledButton, 'Review withdrawal');
    await tester.drag(find.byType(ListView), const Offset(0, -160));
    await tester.pumpAndSettle();
    await tester.tap(review);
    await tester.pumpAndSettle();

    expect(find.text('Review withdrawal'), findsOneWidget);
    expect(find.text('5 USDC'), findsWidgets);
    expect(find.text('4.9 USDC'), findsOneWidget);
    expect(find.text('Authorization required'), findsOneWidget);
  });
}

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

final class _Funding implements FundingRepository {
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
