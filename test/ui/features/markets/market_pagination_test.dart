import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_list_query.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/ui/features/markets/views/market_screen.dart';
import 'package:rwa_interface/ui/features/markets/views/market_search_screen.dart';
import 'package:rwa_interface/ui/features/markets/views/market_product_widgets.dart';

import '../../../helpers/test_app.dart';
import '../../../helpers/display_config.dart';
import 'providers/market_list_provider_test.dart' show product, page;

typedef Query = ({
  String? q,
  String? cursor,
  MarketProductKind? kind,
  MarketListGroup? group,
});

class _Markets implements MarketsRepository {
  final requests = <Query>[];
  late Future<DomainPage<MarketProduct>> Function(Query) handle;
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    MarketProductKind? kind,
    MarketListGroup? group,
    int? limit,
  }) {
    final request = (q: query, cursor: cursor, kind: kind, group: group);
    requests.add(request);
    // Unchanged stock tiles/all-stocks/home boundary.
    if (group == null) {
      return Future.value(
        page([product('NVDA', kind: MarketProductKind.bstock)]),
      );
    }
    return handle(request);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  Future<void> mount(WidgetTester tester, _Markets repo, Widget screen) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
        child: buildTestApp(screen),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> filter(WidgetTester tester, String label) async {
    await tester.ensureVisible(find.byType(MarketProductFilter));
    await tester.tap(find.byType(MarketProductFilter));
    await tester.pumpAndSettle();
    await tester.tap(find.text(label).last);
    await tester.pumpAndSettle();
  }

  List<String> visible(WidgetTester tester) => tester
      .widgetList<MarketProductRow>(find.byType(MarketProductRow))
      .map((row) => row.product.symbol)
      .toList();

  testWidgets(
    'HIP3 filter re-queries server rather than filtering mixed first page',
    (tester) async {
      final repo = _Markets()
        ..handle = (query) async => query.kind == MarketProductKind.perp
            ? page([product('GOLD')])
            : page([
                product('NVDA', kind: MarketProductKind.bstock),
              ], next: 'next');
      await mount(tester, repo, const MarketScreen());
      expect(visible(tester), contains('NVDA'));
      await filter(tester, 'HIP-3 Perps');
      expect(visible(tester), ['GOLD']);
      expect(repo.requests.last.kind, MarketProductKind.perp);
      expect(repo.requests.last.cursor, isNull);
      await tester.tap(find.text('Gainers'));
      await tester.pumpAndSettle();
      expect(repo.requests.last.group, MarketListGroup.gainers);
      expect(repo.requests.last.cursor, isNull);
      await filter(tester, 'bStocks');
      // Keep bStocks' existing sign-filtered Gainers semantics.
      expect(visible(tester), isEmpty);
      await tester.tap(find.text('Popular'));
      await tester.pumpAndSettle();
      expect(visible(tester), ['NVDA']);
    },
  );

  testWidgets(
    'search retains more than two results, page failure retries and pull refresh resets',
    (tester) async {
      var fail = true;
      final repo = _Markets()
        ..handle = (query) async {
          if (query.cursor == null) {
            return page([
              product('A'),
              product('B'),
              product('C'),
            ], next: 'next');
          }
          if (fail) throw StateError('offline');
          return page([product('C'), product('D')]);
        };
      await mount(tester, repo, const MarketDiscoverySearchScreen());
      expect(visible(tester), containsAll(['A', 'B', 'C']));
      await tester.ensureVisible(find.text('Load more'));
      await tester.tap(find.text('Load more'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('Your current results are kept.'),
        findsOneWidget,
      );
      fail = false;
      await tester.ensureVisible(find.text('Retry loading more'));
      await tester.tap(find.text('Retry loading more'));
      await tester.pumpAndSettle();
      expect(repo.requests.where((q) => q.cursor == 'next'), hasLength(2));
      expect(find.text('All results loaded'), findsOneWidget);
      expect(visible(tester).where((p) => p == 'C'), hasLength(1));
      await tester.drag(find.byType(CustomScrollView), const Offset(0, 1000));
      await tester.pumpAndSettle();
      await tester.drag(find.byType(CustomScrollView), const Offset(0, 400));
      await tester.pumpAndSettle();
      expect(repo.requests.last.cursor, isNull);
      expect(find.text('Load more'), findsOneWidget);
    },
  );

  testWidgets(
    'search and ranking changes reset cursor, late old query cannot replace new',
    (tester) async {
      final old = Completer<DomainPage<MarketProduct>>();
      final repo = _Markets()
        ..handle = (query) async {
          if (query.q == 'old') return old.future;
          return page([product(query.q ?? 'INITIAL')]);
        };
      await mount(tester, repo, const MarketDiscoverySearchScreen());
      await tester.enterText(find.byType(TextField), 'old');
      await tester.pump();
      await tester.enterText(find.byType(TextField), 'new');
      await tester.pumpAndSettle();
      old.complete(page([product('STALE')]));
      await tester.pumpAndSettle();
      expect(visible(tester), ['new']);
      await filter(tester, 'HIP-3 Perps');
      await tester.tap(find.text('Losers'));
      await tester.pumpAndSettle();
      expect(repo.requests.last, (
        q: 'new',
        cursor: null,
        kind: MarketProductKind.perp,
        group: MarketListGroup.losers,
      ));
      await tester.tap(find.byTooltip('Clear search'));
      await tester.pumpAndSettle();
      expect(repo.requests.last.q, isNull);
      expect(repo.requests.last.cursor, isNull);
    },
  );

  testWidgets(
    'empty intermediate page offers continuation, not false no-results',
    (tester) async {
      final repo = _Markets()
        ..handle = (query) async => query.cursor == null
            ? page([], next: 'next')
            : page([product('HIP3ONLY')]);
      await mount(tester, repo, const MarketDiscoverySearchScreen());
      expect(find.text('No matching products'), findsNothing);
      await tester.tap(find.text('Load more'));
      await tester.pumpAndSettle();
      expect(visible(tester), ['HIP3ONLY']);
    },
  );

  testWidgets(
    'unsupported favorites is an error, never local empty/synthetic favorites',
    (tester) async {
      final repo = _Markets()
        ..handle = (query) async {
          if (query.group == MarketListGroup.favorites) {
            throw StateError('unavailable');
          }
          return page([product('A')]);
        };
      await mount(tester, repo, const MarketDiscoverySearchScreen());
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      expect(find.text('Favorites unavailable'), findsOneWidget);
      expect(find.text('No matching products'), findsNothing);
    },
  );

  for (final size in [const Size(375, 812), const Size(812, 375)]) {
    testWidgets(
      'search list handles $size with large text and short/empty results',
      (tester) async {
        await configureDisplay(tester, size: size, textScale: 2);
        final repo = _Markets()..handle = (_) async => page([]);
        await mount(tester, repo, const MarketDiscoverySearchScreen());
        expect(tester.takeException(), isNull);
        await tester.drag(find.byType(CustomScrollView), const Offset(0, -400));
        await tester.pump();
        expect(tester.takeException(), isNull);
      },
    );
  }
}
