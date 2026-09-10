import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_list_query.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/ui/features/markets/views/market_screen.dart';
import 'package:rwa_interface/ui/features/markets/views/favorite_order_screen.dart';

import '../../../helpers/test_app.dart';

MarketProduct product(String symbol, MarketProductKind kind) => MarketProduct(
  symbol: symbol,
  name: symbol,
  kind: kind,
  price: DecimalValue('1'),
  settlementAsset: 'USDC',
  network: 'testnet',
  tradable: false,
  isFavorite: true,
);

class Repository implements MarketsRepository {
  final bstock = product('NVDAB', MarketProductKind.bstock);
  final perp = product('TSLA', MarketProductKind.perp);
  Completer<DomainPage<MarketProduct>>? pageGate;
  bool failSave = false;
  List<MarketProductRef>? saved;
  final queryKinds = <MarketProductKind?>[];
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    MarketProductKind? kind,
    MarketListGroup? group,
    int? limit,
  }) async {
    if (group != MarketListGroup.favorites) return const DomainPage(items: []);
    queryKinds.add(kind);
    if (cursor == null) {
      return DomainPage(items: [bstock], hasMore: true, nextCursor: 'next');
    }
    return pageGate == null
        ? DomainPage(items: [perp])
        : await pageGate!.future;
  }

  @override
  Future<void> replaceFavorites(List<MarketProductRef> refs) async {
    if (failSave) {
      throw const ServerFailure(statusCode: 409, code: 'favorites_changed');
    }
    saved = refs;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets(
    'favorites tab opens complete-set editor and saves server ordering',
    (tester) async {
      final repo = Repository()..pageGate = Completer();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
          child: buildTestApp(const MarketScreen()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text('Favorites'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Reorder favorites'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      expect(find.text('Loading all favorites…'), findsOneWidget);
      expect(
        tester
            .widget<FilledButton>(
              find.widgetWithText(FilledButton, 'Save order'),
            )
            .onPressed,
        isNull,
      );
      repo.pageGate!.complete(DomainPage(items: [repo.perp]));
      await tester.pumpAndSettle();
      expect(find.text('NVDAB · bStocks'), findsOneWidget);
      expect(find.text('TSLA · HIP3'), findsOneWidget);
      await tester.tap(find.byTooltip('Move favorite down').first);
      await tester.pump();
      final titles = tester
          .widgetList<ListTile>(find.byType(ListTile))
          .map((tile) => (tile.title! as Text).data)
          .toList();
      expect(titles, ['TSLA · HIP3', 'NVDAB · bStocks']);
      await tester.tap(find.text('Save order'));
      await tester.pumpAndSettle();
      expect(repo.saved!.map((ref) => ref.symbol), ['TSLA', 'NVDAB']);
      expect(repo.queryKinds.every((kind) => kind == null), true);
      expect(find.byType(FavoriteOrderScreen), findsNothing);
    },
  );

  testWidgets(
    '409 remains in editor with reload guidance; account switch discards local order',
    (tester) async {
      final repo = Repository()..failSave = true;
      final container = ProviderContainer(
        overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
      );
      addTearDown(container.dispose);
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: buildTestApp(const FavoriteOrderScreen()),
        ),
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Move favorite down').first);
      await tester.pump();
      await tester.tap(find.text('Save order'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('The order was not confirmed.'),
        findsOneWidget,
      );
      expect(find.byType(FavoriteOrderScreen), findsOneWidget);
      expect(repo.saved, isNull);
      await tester.tap(find.byTooltip('Move favorite down').first);
      await tester.pump();
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await tester.pumpAndSettle();
      expect(
        (tester.widgetList<ListTile>(find.byType(ListTile)).first.title!
                as Text)
            .data,
        'NVDAB · bStocks',
      );
      expect(find.textContaining('The order was not confirmed.'), findsNothing);
    },
  );
}
