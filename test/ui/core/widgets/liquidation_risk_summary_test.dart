import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/core/widgets/liquidation_risk_summary.dart';

void main() {
  group('liquidationRiskLevel', () {
    LiquidationRiskPosition position(String? liquidationPrice) =>
        LiquidationRiskPosition(
          title: 'Long NVDA',
          marketPrice: DecimalValue('100'),
          afterLiquidationPrice: liquidationPrice == null
              ? null
              : DecimalValue(liquidationPrice),
        );

    test('uses the specified inclusive boundaries', () {
      expect(liquidationRiskLevel(position('90')), LiquidationRiskLevel.safe);
      expect(
        liquidationRiskLevel(position('95')),
        LiquidationRiskLevel.caution,
      );
      expect(
        liquidationRiskLevel(position('95.01')),
        LiquidationRiskLevel.high,
      );
    });

    test('returns unknown when a required price is missing', () {
      expect(
        liquidationRiskLevel(position(null)),
        LiquidationRiskLevel.unknown,
      );
    });
  });

  testWidgets('uses the most urgent position and supports a custom label', (
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
          body: LiquidationRiskSummaryCard(
            affectedLabel: 'Withdrawal affects 2 positions',
            initiallyExpanded: true,
            positions: [
              LiquidationRiskPosition(
                title: 'Long NVDA',
                marketPrice: DecimalValue('100'),
                beforeLiquidationPrice: DecimalValue('80'),
                afterLiquidationPrice: DecimalValue('85'),
              ),
              LiquidationRiskPosition(
                title: 'Long TSLA',
                marketPrice: DecimalValue('100'),
                beforeLiquidationPrice: DecimalValue('90'),
                afterLiquidationPrice: DecimalValue('96'),
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Withdrawal affects 2 positions'), findsOneWidget);
    expect(find.text('High Liq. Risk'), findsOneWidget);
    expect(find.text('Long NVDA'), findsOneWidget);
    expect(find.text('Long TSLA'), findsOneWidget);
  });

  testWidgets('renders all three design states and toggles the details', (
    tester,
  ) async {
    Future<void> pumpRisk(String liquidationPrice) => tester.pumpWidget(
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
          body: LiquidationRiskSummaryCard(
            key: const Key('liquidation-risk-summary'),
            positions: [
              LiquidationRiskPosition(
                title: 'Long NVDA',
                marketPrice: DecimalValue('100'),
                beforeLiquidationPrice: DecimalValue('80'),
                afterLiquidationPrice: DecimalValue(liquidationPrice),
              ),
            ],
          ),
        ),
      ),
    );

    await pumpRisk('90');
    expect(find.text('Safe'), findsOneWidget);
    expect(find.text('Long NVDA'), findsNothing);

    await pumpRisk('94');
    expect(find.text('Liq. Risk'), findsOneWidget);

    await pumpRisk('96');
    expect(find.text('High Liq. Risk'), findsOneWidget);

    await tester.tap(find.byKey(const Key('liquidation-risk-summary')));
    await tester.pumpAndSettle();
    expect(find.text('Long NVDA'), findsOneWidget);
    expect(find.text('To liq. 20.0% →4.0%'), findsOneWidget);

    await tester.tap(find.byKey(const Key('liquidation-risk-summary')));
    await tester.pumpAndSettle();
    expect(find.text('Long NVDA'), findsNothing);
  });
}
