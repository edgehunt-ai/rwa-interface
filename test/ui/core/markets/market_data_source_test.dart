import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/markets/market_data_source.dart';

import '../../../helpers/test_app.dart';

void main() {
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
