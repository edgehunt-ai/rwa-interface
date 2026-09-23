import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/order_preview.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/orders/views/hip3_cross_liquidation_impacts_card.dart';

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
          ),
        ),
      ),
    );

    expect(find.text('2 Cross positions will be affected'), findsOneWidget);
    expect(find.textContaining('TSLA'), findsNothing);

    await tester.tap(find.byKey(const Key('hip3-cross-liquidation-impacts')));
    await tester.pumpAndSettle();

    expect(find.textContaining('Long TSLA Liq. Price'), findsOneWidget);
    expect(find.textContaining('Short NVDA Liq. Price'), findsOneWidget);
    expect(find.textContaining(r'$182.4 → $186.8'), findsOneWidget);
    expect(find.textContaining(r'$128.40 → $131.20'), findsOneWidget);
  });
}
