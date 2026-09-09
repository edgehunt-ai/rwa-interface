import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/routing/app_router.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/ui/features/funding/views/deposit_screen.dart';
import 'package:rwa_interface/ui/features/funding/views/withdrawal_screen.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('deposit asset selector renders the Figma empty state', (
    tester,
  ) async {
    final router = AppRouter.create(initialLocation: '/funding/deposit/select');
    addTearDown(router.dispose);

    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();

    expect(find.byType(DepositScreen), findsOneWidget);
    expect(find.text('Deposit crypto'), findsOneWidget);
    expect(find.text('Choose token'), findsOneWidget);
    expect(find.text('Choose token first'), findsOneWidget);
    expect(find.text('Choose a token and network'), findsOneWidget);
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
