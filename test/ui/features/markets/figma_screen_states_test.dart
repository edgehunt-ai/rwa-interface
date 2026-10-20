import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/data/services/market_search_history_service.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/stock.dart';
import 'package:nobell/domain/repositories/markets_repository.dart';
import 'package:nobell/l10n/generated/app_localizations.dart';
import 'package:nobell/ui/core/theme/app_theme.dart';
import 'package:nobell/ui/features/markets/providers/market_providers.dart';
import 'package:nobell/ui/features/markets/views/market_product_widgets.dart';
import 'package:nobell/ui/features/markets/views/market_screen.dart';
import 'package:nobell/ui/features/markets/views/market_search_screen.dart';

import '../../../helpers/display_config.dart';
import '../../../helpers/test_app.dart';

void main() {
  testWidgets('market asset mark prefers a remote logo', (tester) async {
    const logoUrl =
        'data:image/png;base64,'
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mNk'
        'YAAAAAYAAjCB0C8AAAAASUVORK5CYII=';
    await tester.pumpWidget(
      buildTestApp(const MarketAssetMark(symbol: 'NVDA', logoUrl: logoUrl)),
    );

    final image = tester.widget<Image>(
      find.byKey(const ValueKey('market-network-logo-$logoUrl')),
    );
    expect(image.image, isA<NetworkImage>());
    expect((image.image as NetworkImage).url, logoUrl);
  });

  testWidgets('market ranking tabs remain usable at 200% text scale', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852), textScale: 2);
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

  testWidgets('product and ranking filters match the market design', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    await tester.pumpWidget(
      buildTestApp(
        Column(
          children: [
            MarketProductFilter(value: null, onChanged: (_) {}),
            const SizedBox(height: 12),
            MarketRankingTabs(active: 'Popular', onSelected: (_) {}),
          ],
        ),
      ),
    );

    expect(find.text('All products'), findsOneWidget);
    expect(find.text('Spot'), findsOneWidget);
    expect(find.text('Perps'), findsOneWidget);
    expect(tester.getRect(find.byType(MarketProductFilter)).height, 32);
    expect(
      tester.getRect(find.byKey(const Key('market-ranking-popular'))).height,
      24,
    );
    final popular = tester.widget<TextButton>(
      find.descendant(
        of: find.byKey(const Key('market-ranking-popular')),
        matching: find.byType(TextButton),
      ),
    );
    expect(popular.style?.shape?.resolve({}), isA<StadiumBorder>());
    expect(
      popular.style?.backgroundColor?.resolve({}),
      AppTheme.light.extension<AppRwaColors>()!.subtleSurface,
    );
  });

  testWidgets('product tabs request Spot and Perps products', (tester) async {
    await configureDisplay(tester, size: const Size(393, 852));
    final requestedKinds = <MarketProductKind?>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          marketProductsProvider.overrideWith((ref, query) async {
            requestedKinds.add(query.productType);
            return _MarketsRepository().listProducts();
          }),
        ],
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('market-product-bstock')));
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('market-product-perp')));
    await tester.pumpAndSettle();

    expect(
      requestedKinds,
      containsAllInOrder([
        null,
        MarketProductKind.bstock,
        MarketProductKind.perp,
      ]),
    );
  });

  testWidgets('volume ranking shows USD turnover instead of price change', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await configureDisplay(tester, size: const Size(393, 852));
    final requestedGroups = <String?>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketRankingTabProvider.overrideWithBuild((_, _) => 'Popular'),
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          marketProductsProvider.overrideWith((ref, query) async {
            requestedGroups.add(query.group);
            return DomainPage(
              items: [
                MarketProduct(
                  symbol: 'NVDA',
                  name: 'NVIDIA',
                  kind: MarketProductKind.bstock,
                  price: DecimalValue('120', asset: 'USD', unit: 'price'),
                  settlementAsset: 'USDC',
                  network: 'BSC',
                  tradable: true,
                  change24hPercent: DecimalValue('2.5', unit: 'percent'),
                  turnover24h: DecimalValue(
                    '1234567',
                    asset: 'USD',
                    unit: 'turnover',
                  ),
                ),
              ],
            );
          }),
        ],
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('+2.5%'), findsOneWidget);
    expect(
      find.text('*Spot data is sourced from Binance for reference only.'),
      findsNothing,
    );
    expect(find.text(r'Vol $1.23M'), findsNothing);

    await tester.drag(find.text('Popular'), const Offset(-80, 0));
    await tester.pump();
    await tester.tap(find.text('Volume'));
    await tester.pumpAndSettle();

    expect(
      find.text('*Spot data is sourced from Binance for reference only.'),
      findsOneWidget,
    );
    expect(requestedGroups, contains('volume'));
    expect(find.text('+2.5%'), findsNothing);
    expect(find.text(r'Vol $1.23M'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('empty favorites show the illustration and explore Popular', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    await configureDisplay(tester, size: const Size(393, 852));
    final requestedGroups = <String?>[];
    final repository = _MarketsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticatedStateOverride,
          marketRankingTabProvider.overrideWithBuild((_, _) => 'Favorites'),
          marketsRepositoryProvider.overrideWithValue(repository),
          marketProductsProvider.overrideWith((ref, query) async {
            requestedGroups.add(query.group);
            return query.group == 'favorites'
                ? const DomainPage<MarketProduct>(items: [])
                : repository.listProducts();
          }),
        ],
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('No favorites yet'), findsOneWidget);
    expect(find.text('No matching products'), findsNothing);
    final illustration = find.image(
      const AssetImage(
        'assets/figma/home_markets/favorites_empty_illustration.webp',
      ),
    );
    expect(illustration, findsOneWidget);
    expect(tester.getSize(illustration), const Size(120, 120));
    expect(tester.takeException(), isNull);

    final explore = find.widgetWithText(OutlinedButton, 'Explore markets');
    await tester.ensureVisible(explore);
    await tester.tap(explore);
    await tester.pumpAndSettle();

    expect(find.text('No favorites yet'), findsNothing);
    expect(requestedGroups, contains('hot'));
    expect(
      tester.widget<MarketRankingTabs>(find.byType(MarketRankingTabs)).active,
      'Popular',
    );
    expect(find.text('NVDA'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('market starts with product filters and omits stock browse', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 852));
    var stockLoads = 0;
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          marketStocksProvider.overrideWith((ref) async {
            stockLoads++;
            return const DomainPage<Stock>(items: []);
          }),
        ],
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Stocks'), findsNothing);
    expect(find.text('Browse all'), findsNothing);
    expect(find.byKey(const Key('stock-tile-NVDA')), findsNothing);
    expect(stockLoads, 0);

    final filter = tester.getRect(find.byType(MarketProductFilter));
    final tabs = tester.getRect(find.byType(MarketRankingTabs));
    final firstProduct = tester.getRect(find.byType(MarketProductRow).first);
    expect(filter.height, 32);
    expect(filter.width, 353);
    expect(tabs.top - filter.bottom, 12);
    expect(firstProduct.top - tabs.bottom, 12);
    expect(tester.takeException(), isNull);
  });

  testWidgets('product filters fit a compact market viewport', (tester) async {
    await configureDisplay(tester, size: const Size(320, 700));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
        ],
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    final filter = tester.getRect(find.byType(MarketProductFilter));
    expect(filter.right, lessThanOrEqualTo(300));
    expect(find.text('Products'), findsNothing);
    expect(find.text('All products'), findsOneWidget);
    expect(find.text('Spot'), findsOneWidget);
    expect(find.text('Perps'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('market polling pauses behind another route and resumes', (
    tester,
  ) async {
    final refreshEvents = <String>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          marketListRefreshProvider.overrideWith((ref) {
            refreshEvents.add('start');
            ref.onCancel(() => refreshEvents.add('stop'));
            ref.onResume(() => refreshEvents.add('start'));
          }),
        ],
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();
    expect(refreshEvents, ['start']);

    Navigator.of(tester.element(find.byType(MarketScreen))).push(
      MaterialPageRoute<void>(
        builder: (_) => const Scaffold(body: Text('Trade details')),
      ),
    );
    await tester.pumpAndSettle();
    expect(refreshEvents, ['start', 'stop']);

    Navigator.of(tester.element(find.text('Trade details'))).pop();
    await tester.pumpAndSettle();
    expect(refreshEvents, ['start', 'stop', 'start']);
  });

  testWidgets('market product rows are built lazily and remain scrollable', (
    tester,
  ) async {
    final products = List.generate(
      100,
      (index) => MarketProduct(
        symbol: 'PRODUCT-$index',
        name: 'Product $index',
        kind: MarketProductKind.bstock,
        price: DecimalValue('$index', asset: 'USD', unit: 'price'),
        settlementAsset: 'USDC',
        network: 'Arbitrum',
        tradable: true,
      ),
    );
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          marketProductsProvider.overrideWith(
            (ref, query) async => DomainPage(items: products),
          ),
        ],
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byType(MarketProductRow).evaluate().length, lessThan(100));
    expect(find.text('PRODUCT-99'), findsNothing);

    final marketScroll = find.descendant(
      of: find.byType(CustomScrollView),
      matching: find.byType(Scrollable),
    );
    await tester.scrollUntilVisible(
      find.text('PRODUCT-99'),
      600,
      scrollable: marketScroll.first,
    );

    expect(find.text('PRODUCT-99'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('market list loads and appends the next cursor page on scroll', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 700));
    final cursors = <String?>[];
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
          marketProductsProvider.overrideWith((ref, query) async {
            cursors.add(query.cursor);
            if (query.cursor == null) {
              return DomainPage(
                items: List.generate(
                  18,
                  (index) => _testProduct('MARKET-$index'),
                ),
                nextCursor: 'market-page-2',
                hasMore: true,
              );
            }
            return DomainPage(items: [_testProduct('MARKET-PAGE-2')]);
          }),
        ],
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(cursors, [null]);
    await tester.drag(find.byType(CustomScrollView), const Offset(0, -2400));
    await tester.pumpAndSettle();

    expect(cursors, [null, 'market-page-2']);
    expect(
      tester
          .widgetList<MarketProductRow>(find.byType(MarketProductRow))
          .map((row) => row.product.symbol),
      contains('MARKET-PAGE-2'),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('market list keeps existing rows during a background reload', (
    tester,
  ) async {
    final reload = Completer<DomainPage<MarketProduct>>();
    var requests = 0;
    final container = ProviderContainer(
      overrides: [
        marketRankingTabProvider.overrideWithBuild((_, _) => 'Popular'),
        marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
        marketProductsProvider.overrideWith((ref, query) {
          requests++;
          if (requests == 1) {
            return Future.value(DomainPage(items: [_testProduct('NVDA')]));
          }
          return reload.future;
        }),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: _marketApp(const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NVDA'), findsWidgets);

    container.invalidate(
      marketProductsProvider((
        query: null,
        cursor: null,
        group: 'hot',
        productType: null,
      )),
    );
    await tester.pump();

    expect(requests, 2);
    expect(find.text('NVDA'), findsWidgets);

    reload.complete(DomainPage(items: [_testProduct('TSLA')]));
    await tester.pumpAndSettle();

    expect(find.text('NVDA'), findsNothing);
    expect(find.text('TSLA'), findsWidgets);
  });

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
    expect(find.text('Browse all stocks'), findsNothing);
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
    'market search preserves the remote result order after its debounced query resolves',
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

      expect(
        tester
            .widgetList<MarketProductRow>(find.byType(MarketProductRow))
            .map((row) => row.product.symbol),
        ['TSLA', 'NVDA'],
      );
    },
  );

  testWidgets(
    'market search loads and appends the next cursor page on scroll',
    (tester) async {
      await configureDisplay(tester, size: const Size(393, 700));
      final searchCursors = <String?>[];
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
            marketSearchHistoryServiceProvider.overrideWithValue(
              _MarketSearchHistoryService(),
            ),
            marketProductsProvider.overrideWith((ref, query) async {
              if (query.query == null) {
                return DomainPage(items: [_testProduct('CATALOG')]);
              }
              searchCursors.add(query.cursor);
              if (query.cursor == null) {
                return DomainPage(
                  items: List.generate(
                    18,
                    (index) => _testProduct('SEARCH-$index'),
                  ),
                  nextCursor: 'search-page-2',
                  hasMore: true,
                );
              }
              return DomainPage(items: [_testProduct('SEARCH-PAGE-2')]);
            }),
          ],
          child: _marketApp(const MarketDiscoverySearchScreen()),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'search');
      await tester.pump(const Duration(milliseconds: 300));
      await tester.pumpAndSettle();
      expect(searchCursors, [null]);

      await tester.drag(find.byType(ListView), const Offset(0, -2400));
      await tester.pumpAndSettle();

      expect(searchCursors, [null, 'search-page-2']);
      expect(
        tester
            .widgetList<MarketProductRow>(find.byType(MarketProductRow))
            .map((row) => row.product.symbol),
        contains('SEARCH-PAGE-2'),
      );
      expect(tester.takeException(), isNull);
    },
  );

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

MarketProduct _testProduct(String symbol) => MarketProduct(
  symbol: symbol,
  name: symbol,
  kind: MarketProductKind.bstock,
  price: DecimalValue('100', asset: 'USD', unit: 'price'),
  settlementAsset: 'USDC',
  network: 'BSC',
  tradable: true,
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
    DomainPage(items: [_product('TSLA', 'Tesla'), _product('NVDA', 'NVIDIA')]),
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
