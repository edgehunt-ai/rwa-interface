import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/providers/withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/views/withdrawal_screen.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('withdrawal inputs keep comfortable height and unit spacing', (
    tester,
  ) async {
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
        child: MaterialApp(
          theme: AppTheme.light,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: const WithdrawalScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.getSize(find.byKey(const ValueKey('withdrawal-address-card'))),
      const Size(760, 80),
    );
    expect(
      tester.getSize(find.byKey(const ValueKey('withdrawal-amount-card'))),
      const Size(760, 96),
    );
    final addressCardFinder = find.descendant(
      of: find.byKey(const ValueKey('withdrawal-address-card')),
      matching: find.byType(Container),
    );
    final amountCardFinder = find.descendant(
      of: find.byKey(const ValueKey('withdrawal-amount-card')),
      matching: find.byType(Container),
    );
    final addressCard = tester.widget<Container>(addressCardFinder.first);
    final amountCard = tester.widget<Container>(amountCardFinder.first);
    expect(addressCard.padding, const EdgeInsets.all(12));
    expect(amountCard.padding, const EdgeInsets.all(12));
    expect(
      (addressCard.decoration! as BoxDecoration).borderRadius,
      BorderRadius.circular(12),
    );
    expect(
      (amountCard.decoration! as BoxDecoration).borderRadius,
      BorderRadius.circular(12),
    );

    final addressField = tester.widget<TextField>(
      find.byKey(const ValueKey('withdrawal-address-field')),
    );
    final amountFieldFinder = find.byKey(
      const ValueKey('withdrawal-amount-field'),
    );
    final amountField = tester.widget<TextField>(amountFieldFinder);
    expect(addressField.decoration!.contentPadding, EdgeInsets.zero);
    expect(addressField.decoration!.border, InputBorder.none);
    expect(addressField.decoration!.enabledBorder, InputBorder.none);
    expect(addressField.decoration!.focusedBorder, InputBorder.none);
    expect(addressField.decoration!.isCollapsed, isTrue);
    expect(amountField.decoration!.contentPadding, EdgeInsets.zero);
    expect(amountField.decoration!.border, InputBorder.none);
    expect(amountField.decoration!.enabledBorder, InputBorder.none);
    expect(amountField.decoration!.focusedBorder, InputBorder.none);
    expect(amountField.decoration!.isCollapsed, isTrue);

    final addressFieldFinder = find.byKey(
      const ValueKey('withdrawal-address-field'),
    );
    final pasteButton = find.byKey(const ValueKey('withdrawal-address-paste'));
    expect(
      tester.getTopLeft(pasteButton).dx -
          tester.getTopRight(addressFieldFinder).dx,
      12,
    );

    final amountUnit = find.byKey(const ValueKey('withdrawal-amount-unit'));
    expect(
      tester.getTopLeft(amountUnit).dx -
          tester.getTopRight(amountFieldFinder).dx,
      12,
    );
  });

  testWidgets(
    'withdrawal uses available balance for its label, Max and limit',
    (tester) async {
      await _pumpAvailableWithdrawal(tester, available: '20');

      expect(find.text('Available 20 USDC'), findsOneWidget);
      expect(find.text('Available 100 USDC'), findsNothing);
      final amount = find.byKey(const ValueKey('withdrawal-amount-field'));
      final review = find.widgetWithText(FilledButton, 'Review withdrawal');
      await tester.enterText(
        find.byKey(const ValueKey('withdrawal-address-field')),
        '0x1111111111111111111111111111111111111111',
      );
      await tester.tap(find.widgetWithText(TextButton, 'Max'));
      await tester.pump();

      expect(tester.widget<TextField>(amount).controller!.text, '20');
      expect(tester.widget<FilledButton>(review).onPressed, isNotNull);

      await tester.enterText(amount, '20.000000000000000001');
      await tester.pump();
      expect(tester.widget<FilledButton>(review).onPressed, isNull);

      await tester.enterText(amount, '100');
      await tester.pump();
      expect(tester.widget<FilledButton>(review).onPressed, isNull);
    },
  );

  for (final available in <String?>['0', null]) {
    testWidgets(
      'withdrawal disables Max and review with availability $available',
      (tester) async {
        await _pumpAvailableWithdrawal(tester, available: available);

        expect(find.text('Available ${available ?? '—'} USDC'), findsOneWidget);
        expect(find.text('Available 100 USDC'), findsNothing);
        final max = find.widgetWithText(TextButton, 'Max');
        expect(tester.widget<TextButton>(max).onPressed, isNull);
        await tester.enterText(
          find.byKey(const ValueKey('withdrawal-address-field')),
          '0x1111111111111111111111111111111111111111',
        );
        await tester.enterText(
          find.byKey(const ValueKey('withdrawal-amount-field')),
          '1',
        );
        await tester.pump();
        expect(
          tester
              .widget<FilledButton>(
                find.widgetWithText(FilledButton, 'Review withdrawal'),
              )
              .onPressed,
          isNull,
        );
      },
    );
  }

  testWidgets('withdrawal Max and review preserve exact available precision', (
    tester,
  ) async {
    const available = '20.123456789012345678';
    await _pumpAvailableWithdrawal(tester, available: available);
    final amount = find.byKey(const ValueKey('withdrawal-amount-field'));
    final review = find.widgetWithText(FilledButton, 'Review withdrawal');
    await tester.enterText(
      find.byKey(const ValueKey('withdrawal-address-field')),
      '0x1111111111111111111111111111111111111111',
    );
    await tester.tap(find.widgetWithText(TextButton, 'Max'));
    await tester.pump();

    expect(tester.widget<TextField>(amount).controller!.text, available);
    expect(tester.widget<FilledButton>(review).onPressed, isNotNull);

    await tester.enterText(amount, '20.123456789012345679');
    await tester.pump();
    expect(tester.widget<FilledButton>(review).onPressed, isNull);

    await tester.enterText(amount, '20.123456789012345677');
    await tester.pump();
    expect(tester.widget<FilledButton>(review).onPressed, isNotNull);
  });

  testWidgets('withdrawal picker retains total balance and USD valuation', (
    tester,
  ) async {
    await _pumpAvailableWithdrawal(tester, available: '20', showSelector: true);

    expect(find.text('100'), findsOneWidget);
    expect(find.text(r'$100'), findsOneWidget);
    expect(find.text('20'), findsNothing);
  });
}

Future<void> _pumpAvailableWithdrawal(
  WidgetTester tester, {
  required String? available,
  bool showSelector = false,
}) async {
  await configureDisplay(tester, size: const Size(800, 1000));
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        withdrawalAssetsProvider.overrideWith(
          (_) async => [
            WithdrawableAsset(
              symbol: 'USDC',
              chain: 'BSC',
              balance: DecimalValue('100', asset: 'USDC', unit: 'token'),
              availableBalance: available == null
                  ? null
                  : DecimalValue(available, asset: 'USDC', unit: 'token'),
              valueUsd: DecimalValue('100', asset: 'USD', unit: 'fiat'),
              decimals: 18,
              withdrawable: true,
            ),
          ],
        ),
        tradingAccountsProvider.overrideWith((_) async => const []),
      ],
      child: buildTestApp(
        WithdrawalScreen(chain: 'BSC', showSelector: showSelector),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
