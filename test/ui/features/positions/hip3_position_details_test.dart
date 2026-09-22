import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/features/positions/views/hip3_position_metrics.dart';

Position position({
  bool missing = false,
  PositionSide side = PositionSide.long,
}) => Position(
  positionId: 'p-tsla',
  productId: 'xyz:TSLA',
  symbol: 'TSLA',
  kind: MarketProductKind.perp,
  side: side,
  quantity: DecimalValue('1'),
  valueUsd: DecimalValue('100'),
  leverage: missing ? null : DecimalValue('3'),
  entryPrice: missing ? null : DecimalValue('100.123'),
  markPrice: missing ? null : DecimalValue('99.5'),
  unrealizedPnl: missing ? null : DecimalValue('-0.623'),
  unrealizedPnlPercent: missing ? null : DecimalValue('-1.869'),
  realizedPnl: DecimalValue('777'),
  margin: missing ? null : DecimalValue('33.333'),
  liquidationPrice: missing ? null : DecimalValue('67'),
  fundingPaid: missing ? null : DecimalValue('-0.000123'),
);

void main() {
  for (final side in [PositionSide.long, PositionSide.short]) {
    testWidgets('shows every HIP3 metric with signed exact values: $side', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: SingleChildScrollView(
              child: Hip3PositionMetrics(position: position(side: side)),
            ),
          ),
        ),
      );
      for (final text in [
        side == PositionSide.long ? 'Long' : 'Short',
        '3×',
        r'$100.12',
        r'$99.5',
        r'$-0.623',
        '-1.869%',
        r'$33.33',
        r'$67',
        r'$-0.000123',
      ]) {
        expect(find.text(text), findsOneWidget);
      }
      expect(find.text(r'$777'), findsNothing);
    });
  }

  testWidgets('missing values stay unavailable, never realized PnL or zero', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: Hip3PositionMetrics(
            position: position(missing: true, side: PositionSide.none),
          ),
        ),
      ),
    );
    expect(find.text('Unavailable'), findsNWidgets(9));
    expect(find.text(r'$777'), findsNothing);
    expect(find.text(r'$0'), findsNothing);
  });

  for (final size in [const Size(375, 812), const Size(812, 375)]) {
    for (final brightness in Brightness.values) {
      testWidgets('metrics adapt to $size, $brightness and large text', (
        tester,
      ) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData(brightness: brightness),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: MediaQuery(
              data: MediaQueryData(
                size: size,
                textScaler: const TextScaler.linear(2),
                disableAnimations: true,
              ),
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Hip3PositionMetrics(position: position()),
                ),
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        await tester.scrollUntilVisible(find.text('Cumulative funding'), 120);
        expect(tester.takeException(), isNull);
      });
    }
  }
}
