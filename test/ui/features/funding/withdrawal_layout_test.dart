import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/funding/views/withdrawal_screen.dart';
import 'package:rwa_interface/ui/features/portfolio/providers/portfolio_providers.dart';

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
          home: const WithdrawalScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester.getSize(find.byKey(const ValueKey('withdrawal-address-card'))),
      const Size(760, 112),
    );
    expect(
      tester.getSize(find.byKey(const ValueKey('withdrawal-amount-card'))),
      const Size(760, 128),
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
    expect(addressCard.padding, const EdgeInsets.all(16));
    expect(amountCard.padding, const EdgeInsets.all(16));
    expect(
      (addressCard.decoration! as BoxDecoration).borderRadius,
      BorderRadius.circular(8),
    );
    expect(
      (amountCard.decoration! as BoxDecoration).borderRadius,
      BorderRadius.circular(8),
    );

    final addressField = tester.widget<TextField>(
      find.byKey(const ValueKey('withdrawal-address-field')),
    );
    final amountFieldFinder = find.byKey(
      const ValueKey('withdrawal-amount-field'),
    );
    final amountField = tester.widget<TextField>(amountFieldFinder);
    expect(
      addressField.decoration!.contentPadding,
      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
    expect(
      (addressField.decoration!.border! as OutlineInputBorder).borderRadius,
      BorderRadius.circular(6),
    );
    expect(
      (addressField.decoration!.enabledBorder! as OutlineInputBorder)
          .borderRadius,
      BorderRadius.circular(6),
    );
    expect(
      (addressField.decoration!.focusedBorder! as OutlineInputBorder)
          .borderRadius,
      BorderRadius.circular(6),
    );
    expect(
      amountField.decoration!.contentPadding,
      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
    );
    expect(
      (amountField.decoration!.border! as OutlineInputBorder).borderRadius,
      BorderRadius.circular(6),
    );
    expect(
      (amountField.decoration!.enabledBorder! as OutlineInputBorder)
          .borderRadius,
      BorderRadius.circular(6),
    );
    expect(
      (amountField.decoration!.focusedBorder! as OutlineInputBorder)
          .borderRadius,
      BorderRadius.circular(6),
    );

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
