import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_screen.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/features/markets/views/market_search_screen.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';

import '../../helpers/test_app.dart';

MarketProduct product(String symbol, MarketProductKind kind) => MarketProduct(
  symbol: symbol,
  name: symbol,
  kind: kind,
  price: DecimalValue('100', asset: 'USD'),
  settlementAsset: 'USDC',
  network: 'Arbitrum',
  tradable: true,
);

void main() {
  test('market links encode product identifiers', () {
    final uri = Uri.parse(
      AppRoutes.tradeLocation(symbol: ' xyz:BRK/B +?# ', kind: 'perp'),
    );
    expect(uri.path, '/trade');
    expect(uri.queryParameters, {'symbol': 'xyz:BRK/B +?#', 'kind': 'perp'});
    expect(() => AppRoutes.tradeLocation(symbol: '  '), throwsArgumentError);
  });

  for (final entry in ['/markets', '/markets/search', '/']) {
    for (final kind in MarketProductKind.values) {
      testWidgets(
        '$entry ${kind.name} updates URL and reloads the selected product',
        (tester) async {
          final selected = product('TSLA', kind);
          final router = AppRouter.create(initialLocation: entry);
          addTearDown(router.dispose);
          await tester.pumpWidget(
            ProviderScope(
              overrides: [
                marketProductsProvider.overrideWith(
                  (_, _) async => DomainPage(items: [selected]),
                ),
                marketProductProvider.overrideWith(
                  (_, ref) async => product(ref.symbol, ref.kind),
                ),
              ],
              child: buildRouterTestApp(router),
            ),
          );
          await tester.pumpAndSettle();
          if (entry == '/markets/search') {
            await tester.enterText(find.byType(TextField), 'TSLA');
            await tester.pump(const Duration(milliseconds: 350));
            await tester.pumpAndSettle();
          }
          await tester.tap(find.byType(MarketProductRow).first);
          await tester.pumpAndSettle();
          final location = router.routeInformationProvider.value.uri.toString();
          expect(
            location,
            AppRoutes.tradeLocation(symbol: 'TSLA', kind: kind.name),
          );
          expect(find.byType(TradeScreen), findsOneWidget);
          expect(
            tester.widget<TradeScreen>(find.byType(TradeScreen)).initialKind,
            kind,
          );
          // Recreate the router from only the URL: no in-memory navigation extra.
          final reloaded = AppRouter.create(initialLocation: location);
          addTearDown(reloaded.dispose);
          await tester.pumpWidget(
            ProviderScope(
              key: UniqueKey(),
              overrides: [
                marketProductProvider.overrideWith(
                  (_, ref) async => product(ref.symbol, ref.kind),
                ),
              ],
              child: buildRouterTestApp(reloaded),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text('TSLA'), findsWidgets);
          expect(
            tester.widget<TradeScreen>(find.byType(TradeScreen)).initialKind,
            kind,
          );
          expect(tester.takeException(), isNull);
        },
      );
    }
  }

  testWidgets('new deep links on an open detail page switch symbol and kind', (
    tester,
  ) async {
    final router = AppRouter.create(
      initialLocation: '/trade?symbol=TSLA&kind=bstock',
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketProductProvider.overrideWith(
            (_, ref) async => product(ref.symbol, ref.kind),
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    for (final location in [
      '/trade?symbol=ETH&kind=perp',
      '/trade?symbol=ETH&kind=bstock',
      '/trade?symbol=TSLA&kind=bstock',
    ]) {
      router.go(location);
      await tester.pumpAndSettle();
      final uri = Uri.parse(location);
      expect(
        tester.widget<Text>(find.byKey(const Key('trade-product-symbol'))).data,
        uri.queryParameters['symbol'],
      );
      expect(
        tester.widget<TradeScreen>(find.byType(TradeScreen)).initialKind.name,
        uri.queryParameters['kind'],
      );
      expect(tester.takeException(), isNull);
    }
    await tester.tap(find.bySemanticsLabel('Back').first);
    await tester.pumpAndSettle();
    expect(find.byType(MarketScreen), findsOneWidget);
  });

  testWidgets('blank symbols recover to markets', (tester) async {
    final router = AppRouter.create(initialLocation: '/trade?symbol=%20%20');
    addTearDown(router.dispose);
    await tester.pumpWidget(ProviderScope(child: buildRouterTestApp(router)));
    await tester.pumpAndSettle();
    expect(find.byType(MarketScreen), findsOneWidget);
    expect(find.byType(TradeScreen), findsNothing);
    expect(find.byType(MarketDiscoverySearchScreen), findsNothing);
  });
}
