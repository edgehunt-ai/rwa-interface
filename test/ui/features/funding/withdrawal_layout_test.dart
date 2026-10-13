import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/funding/views/withdrawal_screen.dart';
import 'package:nobell/ui/features/portfolio/providers/portfolio_providers.dart';

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
}
