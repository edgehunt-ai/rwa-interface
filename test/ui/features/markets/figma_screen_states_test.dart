import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/data/services/market_search_history_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/stock.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/l10n/generated/app_localizations.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';
import 'package:rwa_interface/ui/features/markets/views/market_screen.dart';
import 'package:rwa_interface/ui/features/markets/views/market_search_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('market ranking tabs remain usable at 200% text scale', (
    tester,
  ) async {
    await configureDisplay(tester, textScale: 2);
    await tester.pumpWidget(
      buildTestApp(MarketRankingTabs(active: 'Favorites', onSelected: (_) {})),
    );

    expect(tester.takeException(), isNull);
    await tester.drag(find.text('Favorites'), const Offset(-160, 0));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('logged-out ranking tabs hide favorites and select popular', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildTestApp(
        MarketRankingTabs(
          active: 'Popular',
          showFavorites: false,
          onSelected: (_) {},
        ),
      ),
    );

    expect(find.text('Favorites'), findsNothing);
    expect(find.text('Popular'), findsOneWidget);
  });

  testWidgets(
    'market stock cards fill two columns and open supported product',
    (tester) async {
      final router = GoRouter(
        routes: [
          GoRoute(path: '/', builder: (_, _) => const MarketScreen()),
          GoRoute(path: '/trade', builder: (_, state) => Text(state.uri.query)),
        ],
      );
      addTearDown(router.dispose);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          ],
          child: MaterialApp.router(
            theme: AppTheme.light,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routerConfig: router,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('bStocks'), findsWidgets);
      expect(find.text('HIP-3'), findsNWidgets(2));
      final nvda = tester.getSize(find.byKey(const Key('stock-tile-NVDA')));
      final tsla = tester.getSize(find.byKey(const Key('stock-tile-TSLA')));
      expect(nvda.width, tsla.width);
      expect(nvda.height, 92);

      await tester.tap(find.byKey(const Key('stock-tile-TSLA')));
      await tester.pumpAndSettle();
      expect(find.textContaining('symbol=TSLA&kind=perp'), findsOneWidget);
    },
  );

  testWidgets('market discovery starts with the server-backed product list', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          marketSearchHistoryServiceProvider.overrideWithValue(
            _MarketSearchHistoryService(),
          ),
        ],
        child: _marketApp(const MarketDiscoverySearchScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Recent searches'), findsOneWidget);
    expect(find.text('No recent searches'), findsOneWidget);
  });

  testWidgets('market discovery restores recent searches from history', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          marketSearchHistoryServiceProvider.overrideWithValue(
            _MarketSearchHistoryService(
              entries: const [
                MarketProductRef(
                  symbol: 'NVDA',
                  kind: MarketProductKind.bstock,
                ),
              ],
            ),
          ),
        ],
        child: _marketApp(const MarketDiscoverySearchScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Recent searches'), findsOneWidget);
  });

  testWidgets(
    'market search shows remote results after its debounced query resolves',
    (tester) async {
      final repository = _ProgressiveMarketsRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            marketsRepositoryProvider.overrideWithValue(repository),
            marketSearchHistoryServiceProvider.overrideWithValue(
              _MarketSearchHistoryService(),
            ),
          ],
          child: _marketApp(const MarketDiscoverySearchScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'nv');
      await tester.pump();

      await tester.pump(const Duration(milliseconds: 300));
      repository.completeSearch();
      await tester.pumpAndSettle();

      expect(find.text('NVDA'), findsWidgets);
      expect(find.text('TSLA'), findsOneWidget);
    },
  );

  testWidgets('all stocks filters stocks loaded from the stocks endpoint', (
    tester,
  ) async {
    final repository = _ProgressiveMarketsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
        child: _marketApp(const MarketSearchScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'nv');
    await tester.pump();

    expect(find.text('NVDA'), findsWidgets);
    expect(find.text('TSLA'), findsNothing);
  });

  testWidgets('all stocks filters locally without requesting product search', (
    tester,
  ) async {
    final repository = _ProgressiveMarketsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
        child: _marketApp(const MarketSearchScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'ts');
    await tester.pump();

    expect(find.text('NVDA'), findsNothing);
    expect(repository.productQueries, isEmpty);
  });

  testWidgets('MarketDiscoverySearchScreen debounces remote searches', (
    tester,
  ) async {
    final repository = _RecordingMarketsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(repository),
          marketSearchHistoryServiceProvider.overrideWithValue(
            _MarketSearchHistoryService(),
          ),
        ],
        child: _marketApp(const MarketDiscoverySearchScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'n');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField), 'nv');
    await tester.pump(const Duration(milliseconds: 100));
    await tester.enterText(find.byType(TextField), 'nvd');
    await tester.pump(const Duration(milliseconds: 299));

    expect(repository.queries.whereType<String>(), isEmpty);

    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump();

    expect(repository.queries.whereType<String>(), ['nvd']);
  });
}

Widget _marketApp(Widget home) => MaterialApp(
  theme: AppTheme.light,
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  supportedLocales: AppLocalizations.supportedLocales,
  home: home,
);

final class _MarketSearchHistoryService implements MarketSearchHistoryService {
  _MarketSearchHistoryService({List<MarketProductRef> entries = const []})
    : _entries = List.unmodifiable(entries);

  final List<MarketProductRef> _entries;

  @override
  Future<List<MarketProductRef>> read() async => _entries;

  @override
  Future<List<MarketProductRef>> record(MarketProductRef product) async => [
    product,
    ..._entries.where((entry) => entry != product),
  ];
}

final class _MarketsRepository implements MarketsRepository {
  @override
  Future<DomainPage<Stock>> listStocks() async => const DomainPage(
    items: [
      Stock(
        symbol: 'NVDA',
        name: 'NVIDIA',
        referencePrice: '120',
        products: [
          MarketProductRef(symbol: 'NVDA', kind: MarketProductKind.bstock),
          MarketProductRef(symbol: 'NVDA', kind: MarketProductKind.perp),
        ],
      ),
      Stock(
        symbol: 'TSLA',
        name: 'Tesla',
        referencePrice: '240',
        products: [
          MarketProductRef(symbol: 'TSLA', kind: MarketProductKind.perp),
        ],
      ),
    ],
  );

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    dynamic kind,
    dynamic group,
    dynamic productType,
    int? limit,
  }) async => DomainPage(
    items: [
      MarketProduct(
        symbol: 'NVDA',
        name: 'NVIDIA',
        kind: MarketProductKind.bstock,
        price: DecimalValue('120', asset: 'USD', unit: 'price'),
        settlementAsset: 'USDC',
        network: 'Arbitrum',
        tradable: true,
      ),
    ],
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _ProgressiveMarketsRepository implements MarketsRepository {
  final _searchResults = Completer<DomainPage<MarketProduct>>();
  final productQueries = <String?>[];

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    dynamic kind,
    dynamic group,
    dynamic productType,
    int? limit,
  }) {
    productQueries.add(query);
    return query == null
        ? Future.value(DomainPage(items: [_product('NVDA', 'NVIDIA')]))
        : _searchResults.future;
  }

  void completeSearch() => _searchResults.complete(
    DomainPage(items: [_product('NVDA', 'NVIDIA'), _product('TSLA', 'Tesla')]),
  );

  @override
  Future<DomainPage<Stock>> listStocks() async => DomainPage(
    items: [
      const Stock(symbol: 'NVDA', name: 'NVIDIA', referencePrice: '120'),
      const Stock(symbol: 'TSLA', name: 'Tesla', referencePrice: '240'),
    ],
  );

  MarketProduct _product(String symbol, String name) => MarketProduct(
    symbol: symbol,
    name: name,
    kind: MarketProductKind.bstock,
    price: DecimalValue('120', asset: 'USD', unit: 'price'),
    settlementAsset: 'USDC',
    network: 'Arbitrum',
    tradable: true,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _RecordingMarketsRepository implements MarketsRepository {
  final queries = <String?>[];

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    dynamic kind,
    dynamic group,
    dynamic productType,
    int? limit,
  }) async {
    queries.add(query);
    return DomainPage(items: [_product('NVDA', 'NVIDIA')]);
  }

  @override
  Future<DomainPage<Stock>> listStocks() async => const DomainPage(
    items: [Stock(symbol: 'NVDA', name: 'NVIDIA', referencePrice: '120')],
  );

  MarketProduct _product(String symbol, String name) => MarketProduct(
    symbol: symbol,
    name: name,
    kind: MarketProductKind.bstock,
    price: DecimalValue('120', asset: 'USD', unit: 'price'),
    settlementAsset: 'USDC',
    network: 'Arbitrum',
    tradable: true,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
