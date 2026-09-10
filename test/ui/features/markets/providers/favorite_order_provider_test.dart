import 'dart:async';

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
import 'package:rwa_interface/ui/features/markets/providers/favorite_order_provider.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';

MarketProduct favorite(
  String symbol, [
  MarketProductKind kind = MarketProductKind.perp,
]) => MarketProduct(
  symbol: symbol,
  name: symbol,
  kind: kind,
  price: DecimalValue('1'),
  settlementAsset: 'USDC',
  network: 'testnet',
  tradable: false,
  isFavorite: true,
);

class FavoriteRepository implements MarketsRepository {
  final pages = <Completer<DomainPage<MarketProduct>>>[];
  final cursors = <String?>[];
  final saved = <List<MarketProductRef>>[];
  Future<void> Function()? saveResult;
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    MarketProductKind? kind,
    MarketListGroup? group,
    int? limit,
  }) {
    expect(query, isNull);
    expect(kind, isNull);
    expect(group, MarketListGroup.favorites);
    cursors.add(cursor);
    final pending = Completer<DomainPage<MarketProduct>>();
    pages.add(pending);
    return pending.future;
  }

  @override
  Future<void> replaceFavorites(List<MarketProductRef> refs) async {
    saved.add(List.of(refs));
    await saveResult?.call();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late FavoriteRepository repo;
  late ProviderContainer container;
  setUp(() {
    repo = FavoriteRepository();
    container = ProviderContainer(
      overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
    );
    container.listen(favoriteOrderProvider, (_, _) {});
    container.listen(favoritesCommandProvider, (_, _) {});
  });
  tearDown(() => container.dispose());

  test(
    'same-account reload cannot let an old request overwrite the baseline',
    () async {
      final obsolete = repo.pages.first;
      container.invalidate(favoriteOrderProvider);
      await container.pump();
      repo.pages.last.complete(
        DomainPage(items: [favorite('B'), favorite('C')]),
      );
      await container.read(favoriteOrderProvider.future);
      obsolete.complete(DomainPage(items: [favorite('A')]));
      await container.pump();
      container.read(favoriteOrderProvider.notifier).move(1, 0);
      expect(await container.read(favoriteOrderProvider.notifier).save(), true);
      expect(repo.saved.single.map((p) => p.symbol), ['C', 'B']);
    },
  );

  test(
    'server maximum count prevents replacing a larger untrusted collection',
    () async {
      final failed = expectLater(
        container.read(favoriteOrderProvider.future),
        throwsA(isA<DecodingFailure>()),
      );
      repo.pages.single.complete(
        DomainPage(
          items: List.generate(
            FavoriteOrder.maximumFavorites + 1,
            (i) => favorite('P$i'),
          ),
        ),
      );
      await failed;
      expect(
        await container.read(favoriteOrderProvider.notifier).save(),
        false,
      );
      expect(repo.saved, isEmpty);
    },
  );

  test(
    'unique empty-page cursors cannot cause unbounded favorites reads',
    () async {
      final failed = expectLater(
        container.read(favoriteOrderProvider.future),
        throwsA(isA<DecodingFailure>()),
      );
      for (var index = 0; index < FavoriteOrder.maximumPages; index++) {
        repo.pages.last.complete(
          DomainPage(
            items: const [],
            nextCursor: 'cursor-$index',
            hasMore: true,
          ),
        );
        await container.pump();
      }
      await failed;
      expect(repo.pages.length, FavoriteOrder.maximumPages);
      expect(
        await container.read(favoriteOrderProvider.notifier).save(),
        false,
      );
      expect(repo.saved, isEmpty);
    },
  );

  test(
    'loads complete unfiltered set before exact-set reorder submission',
    () async {
      repo.pages[0].complete(
        DomainPage(items: [favorite('A')], nextCursor: 'next', hasMore: true),
      );
      await container.pump();
      expect(repo.cursors, [null, 'next']);
      expect(
        await container.read(favoriteOrderProvider.notifier).save(),
        false,
      );
      expect(repo.saved, isEmpty);
      repo.pages[1].complete(
        DomainPage(
          items: [favorite('B', MarketProductKind.bstock), favorite('C')],
        ),
      );
      await container.read(favoriteOrderProvider.future);
      container.read(favoriteOrderProvider.notifier).move(2, 0);
      expect(await container.read(favoriteOrderProvider.notifier).save(), true);
      expect(repo.saved.single.map((p) => p.symbol), ['C', 'A', 'B']);
      expect(repo.saved.single.last.kind, MarketProductKind.bstock);
    },
  );

  test(
    'partial page failure disables save and retry restarts at first page',
    () async {
      repo.pages[0].complete(
        DomainPage(items: [favorite('A')], nextCursor: 'next', hasMore: true),
      );
      await container.pump();
      repo.pages[1].completeError(const NetworkFailure());
      await expectLater(
        container.read(favoriteOrderProvider.future),
        throwsA(isA<NetworkFailure>()),
      );
      expect(
        await container.read(favoriteOrderProvider.notifier).save(),
        false,
      );
      container.invalidate(favoriteOrderProvider);
      await container.pump();
      expect(repo.cursors.last, isNull);
      expect(repo.saved, isEmpty);
      repo.pages.last.complete(DomainPage(items: [favorite('B')]));
      expect(
        (await container.read(favoriteOrderProvider.future)).single.symbol,
        'B',
      );
    },
  );

  test(
    '409 reloads the full set and never automatically retries obsolete order',
    () async {
      repo.pages.single.complete(
        DomainPage(items: [favorite('A'), favorite('B')]),
      );
      await container.read(favoriteOrderProvider.future);
      repo.saveResult = () async =>
          throw const ServerFailure(statusCode: 409, code: 'favorites_changed');
      expect(
        await container.read(favoriteOrderProvider.notifier).save(),
        false,
      );
      await container.pump();
      expect(repo.cursors.last, isNull);
      expect(repo.saved.length, 1);
      expect(
        await container.read(favoriteOrderProvider.notifier).save(),
        false,
      );
      repo.pages.last.complete(
        DomainPage(items: [favorite('A'), favorite('C')]),
      );
      await container.read(favoriteOrderProvider.future);
      repo.saveResult = null;
      expect(await container.read(favoriteOrderProvider.notifier).save(), true);
      expect(repo.saved.last.map((p) => p.symbol), ['A', 'C']);
    },
  );

  test('account switch rejects old collection and late save result', () async {
    final oldLoad = repo.pages.first;
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await container.pump();
    repo.pages.last.complete(DomainPage(items: [favorite('B')]));
    await container.read(favoriteOrderProvider.future);
    oldLoad.complete(DomainPage(items: [favorite('A')]));
    await container.pump();
    expect(
      container.read(favoriteOrderProvider).requireValue.single.symbol,
      'B',
    );
    final response = Completer<void>();
    repo.saveResult = () => response.future;
    final saved = container.read(favoriteOrderProvider.notifier).save();
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await container.pump();
    repo.pages.last.complete(DomainPage(items: [favorite('C')]));
    await container.read(favoriteOrderProvider.future);
    response.complete();
    expect(await saved, false);
    expect(
      container.read(favoriteOrderProvider).requireValue.single.symbol,
      'C',
    );
  });

  test(
    'replace rejects a subset or duplicate set without a network mutation',
    () async {
      final a = favorite('A').ref, b = favorite('B').ref;
      final command = container.read(favoritesCommandProvider.notifier);
      expect(await command.replace([a], expectedFavorites: [a, b]), false);
      expect(await command.replace([a, a], expectedFavorites: [a, b]), false);
      expect(repo.saved, isEmpty);
      repo.pages.single.complete(const DomainPage(items: []));
      await container.read(favoriteOrderProvider.future);
    },
  );
}
