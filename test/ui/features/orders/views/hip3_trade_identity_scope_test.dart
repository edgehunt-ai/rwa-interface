import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/providers/hip3_chart_provider.dart';
import 'package:rwa_interface/ui/features/orders/providers/order_providers.dart';
import 'package:rwa_interface/ui/features/orders/views/trade_screen.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';

import '../../../../helpers/test_app.dart';

void main() {
  for (final environment in ['mainnet', 'testnet']) {
    testWidgets(
      '$environment details preserve bound quote and account query scope',
      (tester) async {
        final positions = <PositionFilter>[];
        final orders = <Hip3OpenOrderQuery>[];
        final snapshots = <MarketProductRef>[];
        final market = Hip3PublicMarket(
          productId: 'xyz:TSLA',
          venue: 'xyz',
          environment: environment,
          settlementAsset: 'USDC',
          tradable: environment == 'testnet',
        );
        final product = MarketProduct(
          symbol: 'TSLA',
          name: 'Tesla',
          kind: MarketProductKind.perp,
          price: DecimalValue('100'),
          settlementAsset: 'USDC',
          network: 'Hyperliquid',
          tradable: market.tradable,
          hip3Market: market,
        );
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              marketProductsProvider.overrideWith(
                (ref, query) async => DomainPage(items: [product]),
              ),
              marketSnapshotProvider.overrideWith((ref, query) async {
                snapshots.add(query);
                return MarketSnapshot(
                  price: product.price,
                  hip3Market: market,
                  priceKind: 'mark',
                );
              }),
              hip3ChartProvider.overrideWith(
                (ref, query) async =>
                    const CandleChart(symbol: 'TSLA', range: '1h', points: []),
              ),
              positionsProvider.overrideWith((ref, query) async {
                positions.add(query);
                return const DomainPage(items: []);
              }),
              hip3OpenOrdersProvider.overrideWith((ref, query) async {
                orders.add(query);
                return const DomainPage(items: []);
              }),
            ],
            child: buildTestApp(
              const TradeScreen(
                symbol: 'TSLA',
                initialKind: MarketProductKind.perp,
              ),
            ),
          ),
        );
        await tester.pumpAndSettle();
        // Once authoritative product data arrives, header and Details share the
        // same bound family; Details must not request a second unbound snapshot.
        expect(snapshots.where((ref) => ref.productId == null), hasLength(1));
        expect(snapshots.last.productId, 'xyz:TSLA');
        expect(snapshots.last.environment, environment);
        for (final label in ['Position', 'Open']) {
          final tab = find.widgetWithText(TextButton, label);
          await tester.scrollUntilVisible(
            tab,
            180,
            scrollable: find.byType(Scrollable).first,
          );
          await Scrollable.ensureVisible(tester.element(tab), alignment: 0.2);
          await tester.pumpAndSettle();
          await tester.tap(tab);
          await tester.pumpAndSettle();
        }
        if (environment == 'mainnet') {
          expect(positions, isEmpty);
          expect(orders, isEmpty);
          expect(
            find.textContaining(
              'Account positions and orders currently use Testnet.',
            ),
            findsOneWidget,
          );
        } else {
          expect(positions.single.symbol, 'xyz:TSLA');
          expect(positions.single.kind, MarketProductKind.perp);
          expect(orders.single.productId, 'xyz:TSLA');
          expect(orders.single.symbol, 'TSLA');
        }
        expect(snapshots.where((ref) => ref.productId == null), hasLength(1));
        expect(snapshots.last.productId, 'xyz:TSLA');
        expect(snapshots.last.environment, environment);
        expect(tester.takeException(), isNull);
      },
    );
  }
}
