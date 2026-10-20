import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/markets/market_data_source.dart';
import 'package:nobell/ui/core/feedback/rwa_tooltip.dart';

import '../../../helpers/test_app.dart';

void main() {
  for (final width in [240.0, 263.0, 264.0, 393.0]) {
    testWidgets('tooltip fits a $width pixel viewport', (tester) async {
      await tester.binding.setSurfaceSize(Size(width, 852));
      addTearDown(() => tester.binding.setSurfaceSize(null));
      await tester.pumpWidget(
        buildTestApp(
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(top: 120),
              child: RwaRichTooltip(
                constrainToViewport: true,
                alignToCenter: true,
                autoFlipVertically: true,
                tooltipKey: Key('narrow-tooltip'),
                message: TextSpan(text: 'Market data source details'),
                child: Icon(Icons.info, key: Key('tooltip-trigger')),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.byKey(const Key('tooltip-trigger')));
      await tester.pump();
      expect(tester.takeException(), isNull);
      final bounds = tester.getRect(find.byKey(const Key('narrow-tooltip')));
      expect(bounds.left, greaterThanOrEqualTo(12));
      expect(bounds.right, lessThanOrEqualTo(width - 12));
      await tester.tapAt(Offset(width / 2, 700));
      await tester.pump();
      expect(find.byKey(const Key('narrow-tooltip')), findsNothing);
    });
  }

  testWidgets('source disclosure follows ranking and product filters', (
    tester,
  ) async {
    for (final kind in [null, ...MarketProductKind.values]) {
      for (final tab in [
        'Favorites',
        'Popular',
        'Gainers',
        'Losers',
        'Volume',
      ]) {
        await tester.pumpWidget(
          buildTestApp(MarketListDataSource(kind: kind, tab: tab)),
        );
        final visible =
            kind != MarketProductKind.perp &&
            const {'Gainers', 'Losers', 'Volume'}.contains(tab);
        expect(
          find.text('*Spot data is sourced from Binance for reference only.'),
          visible ? findsOneWidget : findsNothing,
          reason: '$kind / $tab',
        );
      }
    }
  });

  for (final locale in [const Locale('en'), const Locale('zh')]) {
    testWidgets(
      'source info opens and dismisses localized explanation $locale',
      (tester) async {
        await tester.binding.setSurfaceSize(const Size(393, 852));
        addTearDown(() => tester.binding.setSurfaceSize(null));
        await tester.pumpWidget(
          buildTestApp(
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 120, 20, 0),
              child: TradeMarketDataSource(),
            ),
            locale: locale,
          ),
        );
        await tester.pumpAndSettle();
        final context = tester.element(find.byType(TradeMarketDataSource));
        final l10n = AppLocalizations.of(context);
        final explanation = find.text(
          l10n.marketDataSourceDisclaimer,
          findRichText: true,
        );
        expect(find.text(l10n.marketDataSourceBinance), findsOneWidget);
        expect(explanation, findsNothing);
        await tester.tap(find.byKey(const Key('market-data-source-info')));
        await tester.pump();
        expect(explanation, findsOneWidget);
        final bounds = tester.getRect(explanation);
        expect(bounds.left, greaterThanOrEqualTo(0));
        expect(bounds.right, lessThanOrEqualTo(393));
        await tester.tapAt(const Offset(350, 700));
        await tester.pump();
        expect(explanation, findsNothing);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
