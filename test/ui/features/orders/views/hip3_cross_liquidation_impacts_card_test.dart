import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/order_intent.dart';
import 'package:nobell/domain/models/order_preview.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/orders/views/hip3_cross_liquidation_impacts_card.dart';

void main() {
  testWidgets('shows the summary and expands real liquidation changes', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Hip3CrossLiquidationImpactsCard(
            impacts: [
              Hip3CrossLiquidationImpact(
                productId: 'xyz:TSLA',
                side: TradingSide.long,
                markPrice: DecimalValue('200'),
                beforeLiquidationPrice: DecimalValue('182.4'),
                afterLiquidationPrice: DecimalValue('186.8'),
              ),
              Hip3CrossLiquidationImpact(
                productId: 'xyz:NVDA',
                side: TradingSide.short,
                beforeLiquidationPrice: DecimalValue('128.40'),
                afterLiquidationPrice: DecimalValue('131.20'),
              ),
            ],
            marketPrices: {
              // The contract snapshot must win over this stale fallback.
              'xyz:TSLA': DecimalValue('190'),
              'xyz:NVDA': DecimalValue('140'),
            },
          ),
        ),
      ),
    );

    expect(find.text('2 Cross positions will be affected'), findsOneWidget);
    expect(find.textContaining('TSLA'), findsNothing);

    await tester.tap(find.byKey(const Key('hip3-cross-liquidation-impacts')));
    await tester.pumpAndSettle();

    expect(find.text('Liq. Risk'), findsOneWidget);
    expect(find.textContaining('Long TSLA'), findsOneWidget);
    expect(find.textContaining('Short NVDA'), findsOneWidget);
    expect(find.textContaining(r'Mkt. $200'), findsOneWidget);
    expect(find.textContaining('To liq. 8.8% →6.6%'), findsOneWidget);
    expect(find.textContaining(r'Liq. $182.4 → $186.8'), findsOneWidget);
    expect(find.textContaining(r'Liq. $128.40 → $131.20'), findsOneWidget);
  });
}
