import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';
import 'package:nobell/ui/features/activity/views/activity_screen.dart';

import '../../helpers/test_app.dart';

Widget app(GoRouter router) => ProviderScope(
  overrides: [
    marketProductProvider.overrideWith(
      (_, product) async => MarketProduct(
        symbol: product.symbol,
        name: product.symbol,
        kind: product.kind,
        price: DecimalValue('100', asset: 'USD'),
        settlementAsset: 'USDC',
        network: 'Arbitrum',
        tradable: true,
      ),
    ),
  ],
  child: buildRouterTestApp(router),
);

void main() {
  const origin = 'nobell-app://app';

  testWidgets('$origin cold launch opens the selected market', (tester) async {
    tester.platformDispatcher.defaultRouteNameTestValue =
        '$origin/trade?symbol=ETH&kind=perp';
    addTearDown(tester.platformDispatcher.clearDefaultRouteNameTestValue);
    final router = AppRouter.create();
    addTearDown(router.dispose);
    await tester.pumpWidget(app(router));
    await tester.pumpAndSettle();
    final screen = tester.widget<TradeScreen>(find.byType(TradeScreen));
    expect(screen.symbol, 'ETH');
    expect(screen.initialKind, MarketProductKind.perp);
    expect(find.text('ETH'), findsWidgets);
  });

  testWidgets('$origin delivery to a running app switches details', (
    tester,
  ) async {
    final router = AppRouter.create();
    addTearDown(router.dispose);
    await tester.pumpWidget(app(router));
    await tester.pumpAndSettle();
    for (final target in [
      'trade?symbol=TSLA&kind=bstock',
      'trade?symbol=ETH&kind=perp',
    ]) {
      await router.routeInformationProvider.didPushRouteInformation(
        RouteInformation(uri: Uri.parse('$origin/$target')),
      );
      await tester.pumpAndSettle();
      final screen = tester.widget<TradeScreen>(find.byType(TradeScreen));
      expect(screen.symbol, Uri.parse(target).queryParameters['symbol']);
      expect(
        screen.initialKind.name,
        Uri.parse(target).queryParameters['kind'],
      );
    }
    await router.routeInformationProvider.didPushRouteInformation(
      RouteInformation(uri: Uri.parse('$origin/activity/order%2F123')),
    );
    await tester.pumpAndSettle();
    expect(
      tester
          .widget<ActivityDetailScreen>(find.byType(ActivityDetailScreen))
          .recordId,
      'order/123',
    );
    expect(tester.takeException(), isNull);
  });
}
