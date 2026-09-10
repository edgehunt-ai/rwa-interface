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
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';
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
        child: MaterialApp(
          theme: AppTheme.light,
          home: const MarketDiscoverySearchScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Products'), findsOneWidget);
    expect(find.text('Recent searches'), findsNothing);
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
          child: MaterialApp(
            theme: AppTheme.light,
            home: const MarketDiscoverySearchScreen(),
          ),
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

  testWidgets(
    'all stocks shows remote results after its debounced query resolves',
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

      await tester.pump(const Duration(milliseconds: 300));
      repository.completeSearch();
      await tester.pumpAndSettle();

      expect(find.text('NVDA'), findsWidgets);
      expect(find.text('TSLA'), findsOneWidget);
    },
  );

  for (final searchScreen in <Widget>[
    const MarketDiscoverySearchScreen(),
    const MarketSearchScreen(),
  ]) {
    testWidgets('${searchScreen.runtimeType} debounces remote searches', (
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
          child: MaterialApp(theme: AppTheme.light, home: searchScreen),
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
    dynamic kind,
    dynamic group,
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

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    dynamic kind,
    dynamic group,
    int? limit,
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

final class _RecordingMarketsRepository implements MarketsRepository {
  final queries = <String?>[];

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    dynamic kind,
    dynamic group,
    int? limit,
  }) async {
    queries.add(query);
    return DomainPage(items: [_product('NVDA', 'NVIDIA')]);
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
