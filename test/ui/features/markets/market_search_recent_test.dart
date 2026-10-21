import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/routing/app_router.dart';
import 'package:nobell/app/routing/routes.dart';
import 'package:nobell/data/services/market_search_history_service.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/repositories/markets_repository.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/features/markets/views/market_search_screen.dart';
import 'package:nobell/ui/features/orders/views/trade_screen.dart';

import '../../../helpers/test_app.dart';

void main() {
  testWidgets('recent searches survive the hot ranking page they are missing', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_HotRankingRepository()),
          marketSearchHistoryServiceProvider.overrideWithValue(
            _MemoryMarketSearchHistoryService(
              entries: const [
                MarketProductRef(
                  symbol: 'NVDA',
                  kind: MarketProductKind.bstock,
                ),
              ],
            ),
          ),
          marketProductProvider.overrideWith(
            (_, reference) async => _product(reference.symbol, reference.kind),
          ),
        ],
        child: buildTestApp(const MarketDiscoverySearchScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No recent searches'), findsNothing);
    expect(
      tester
          .widgetList<MarketProductRow>(find.byType(MarketProductRow))
          .map((row) => row.product.symbol),
      ['NVDA'],
    );
  });

  testWidgets('opening a search result restores it in recent searches', (
    tester,
  ) async {
    final history = _MemoryMarketSearchHistoryService();
    final router = AppRouter.create(
      initialLocation: AppRoutes.marketSearchPath,
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_HotRankingRepository()),
          marketSearchHistoryServiceProvider.overrideWithValue(history),
          marketProductProvider.overrideWith(
            (_, reference) async => _product(reference.symbol, reference.kind),
          ),
        ],
        child: buildRouterTestApp(router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('No recent searches'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'nvda');
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(MarketProductRow).first);
    await tester.pumpAndSettle();

    expect(find.byType(TradeScreen), findsOneWidget);
    expect(history.entries, [
      const MarketProductRef(symbol: 'NVDA', kind: MarketProductKind.bstock),
    ]);

    router.go(AppRoutes.marketSearchPath);
    await tester.pumpAndSettle();

    expect(find.text('No recent searches'), findsNothing);
    expect(
      tester
          .widgetList<MarketProductRow>(find.byType(MarketProductRow))
          .map((row) => row.product.symbol),
      ['NVDA'],
    );
  });
}

MarketProduct _product(String symbol, MarketProductKind kind) => MarketProduct(
  symbol: symbol,
  name: symbol,
  kind: kind,
  price: DecimalValue('100', asset: 'USD', unit: 'price'),
  settlementAsset: 'USDC',
  network: 'Arbitrum',
  tradable: true,
);

/// Serves a hot ranking page that does not contain every searchable product,
/// matching production where the ranking page is capped at the default limit.
final class _HotRankingRepository implements MarketsRepository {
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    MarketProductKind? productType,
    String? group,
  }) async {
    if (query == null) {
      return DomainPage(items: [_product('TSLA', MarketProductKind.bstock)]);
    }
    return DomainPage(items: [_product('NVDA', MarketProductKind.bstock)]);
  }

  @override
  Future<MarketProduct> getProduct(MarketProductRef ref) async =>
      _product(ref.symbol, ref.kind);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _MemoryMarketSearchHistoryService
    implements MarketSearchHistoryService {
  _MemoryMarketSearchHistoryService({List<MarketProductRef> entries = const []})
    : entries = List.of(entries);

  final List<MarketProductRef> entries;

  @override
  Future<List<MarketProductRef>> read() async => List.unmodifiable(entries);

  @override
  Future<List<MarketProductRef>> record(MarketProductRef product) async {
    entries
      ..remove(product)
      ..insert(0, product);
    return List.unmodifiable(entries);
  }
}
