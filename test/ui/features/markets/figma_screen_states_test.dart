import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/data/services/market_search_history_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/ui/core/theme/app_theme.dart';
import 'package:rwa_interface/ui/core/feedback/loading_skeleton.dart';
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

  testWidgets('market search does not present catalog entries as recent', (
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
        child: MaterialApp(
          theme: AppTheme.light,
          home: const MarketDiscoverySearchScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Recent searches'), findsOneWidget);
    expect(find.text('No recent searches'), findsOneWidget);
    expect(find.text('NVDA'), findsNothing);
  });

  testWidgets(
    'market search shows local results before remote results resolve',
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
          child: MaterialApp(
            theme: AppTheme.light,
            home: const MarketDiscoverySearchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'nv');
      await tester.pump();

      expect(find.text('NVDA'), findsOneWidget);
      expect(find.byType(SkeletonBlock), findsWidgets);

      repository.completeSearch();
      await tester.pumpAndSettle();

      expect(find.text('NVDA'), findsOneWidget);
      expect(find.text('TSLA'), findsOneWidget);
    },
  );

  testWidgets(
    'all stocks search shows local results before remote results resolve',
    (tester) async {
      final repository = _ProgressiveMarketsRepository();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const MarketSearchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.enterText(find.byType(TextField), 'nv');
      await tester.pump();

      expect(find.text('NVDA'), findsOneWidget);
      expect(find.byType(SkeletonBlock), findsWidgets);

      repository.completeSearch();
      await tester.pumpAndSettle();

      expect(find.text('NVDA'), findsOneWidget);
      expect(find.text('TSLA'), findsOneWidget);
    },
  );

  testWidgets('all stocks loads the next cursor page while scrolling', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(320, 568));
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(
            _PagedMarketsRepository(),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.light,
          home: const MarketSearchScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('STK0'), findsOneWidget);
    await tester.fling(find.byType(ListView), const Offset(0, -600), 1000);
    await tester.pumpAndSettle();

    expect(find.text('NVDA'), findsWidgets);
  });

  testWidgets(
    'all stocks loads another page when the first page cannot scroll',
    (tester) async {
      await configureDisplay(tester, size: const Size(320, 568));
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            marketsRepositoryProvider.overrideWithValue(
              _ShortPagedMarketsRepository(),
            ),
          ],
          child: MaterialApp(
            theme: AppTheme.light,
            home: const MarketSearchScreen(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('NVDA'), findsOneWidget);
    },
  );

  testWidgets('markets products load the next cursor page while scrolling', (
    tester,
  ) async {
    await configureDisplay(tester, size: const Size(393, 568));
    final repository = _DeferredPagedMarketsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
        child: MaterialApp(theme: AppTheme.light, home: const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    await tester.fling(
      find.byType(ListView).first,
      const Offset(0, -1800),
      1000,
    );
    await tester.pump();
    expect(find.byType(SkeletonBlock), findsWidgets);
    repository.completeNextPage();
    await tester.pumpAndSettle();

    expect(find.text('NVDA'), findsOneWidget);
  });

  testWidgets('market switches to Popular when initial favorites are empty', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          marketsRepositoryProvider.overrideWithValue(_MarketsRepository()),
        ],
        child: MaterialApp(theme: AppTheme.light, home: const MarketScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('NVDA'), findsOneWidget);
    expect(find.text('No favorites yet'), findsNothing);
    await tester.tap(find.text('Favorites'));
    await tester.pumpAndSettle();

    expect(find.text('No favorites yet'), findsOneWidget);
  });
}

final class _MarketSearchHistoryService implements MarketSearchHistoryService {
  @override
  Future<List<MarketProductRef>> read() async => const [];

  @override
  Future<List<MarketProductRef>> record(MarketProductRef product) async => [
    product,
  ];
}

final class _MarketsRepository implements MarketsRepository {
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
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

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
  }) => query == null
      ? Future.value(DomainPage(items: [_product('NVDA', 'NVIDIA')]))
      : _searchResults.future;

  void completeSearch() => _searchResults.complete(
    DomainPage(items: [_product('NVDA', 'NVIDIA'), _product('TSLA', 'Tesla')]),
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

final class _PagedMarketsRepository implements MarketsRepository {
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
  }) async {
    if (cursor == 'page-2') {
      return DomainPage(items: [_product('NVDA', 'NVIDIA')]);
    }
    return DomainPage(
      items: [
        for (var index = 0; index < 8; index++)
          _product('STK$index', 'Stock $index'),
      ],
      nextCursor: 'page-2',
      hasMore: true,
    );
  }

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

final class _ShortPagedMarketsRepository implements MarketsRepository {
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
  }) async => cursor == 'page-2'
      ? DomainPage(items: [_product('NVDA', 'NVIDIA')])
      : DomainPage(
          items: [_product('STK0', 'Stock 0')],
          nextCursor: 'page-2',
          hasMore: true,
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

final class _DeferredPagedMarketsRepository implements MarketsRepository {
  final _nextPage = Completer<DomainPage<MarketProduct>>();

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
  }) => cursor == 'page-2'
      ? _nextPage.future
      : Future.value(
          DomainPage(
            items: [
              for (var index = 0; index < 8; index++)
                _product('STK$index', 'Stock $index'),
            ],
            nextCursor: 'page-2',
            hasMore: true,
          ),
        );

  void completeNextPage() {
    _nextPage.complete(DomainPage(items: [_product('NVDA', 'NVIDIA')]));
  }

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
