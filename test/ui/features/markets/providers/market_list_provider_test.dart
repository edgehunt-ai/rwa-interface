import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_list_query.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_list_provider.dart';

MarketProduct product(
  String symbol, {
  MarketProductKind kind = MarketProductKind.perp,
  String price = '1',
}) => MarketProduct(
  symbol: symbol,
  name: symbol,
  kind: kind,
  price: DecimalValue(price),
  settlementAsset: 'USDC',
  network: 'Hyperliquid',
  tradable: true,
);
DomainPage<MarketProduct> page(List<MarketProduct> items, {String? next}) =>
    DomainPage(items: items, nextCursor: next, hasMore: next != null);

final class Request {
  Request(this.query, this.cursor, this.kind, this.group, this.limit);
  final String? query, cursor;
  final MarketProductKind? kind;
  final MarketListGroup? group;
  final int? limit;
  final result = Completer<DomainPage<MarketProduct>>();
}

class ControlledMarkets implements MarketsRepository {
  final requests = <Request>[];
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    MarketProductKind? kind,
    MarketListGroup? group,
    int? limit,
  }) {
    final request = Request(query, cursor, kind, group, limit);
    requests.add(request);
    return request.result.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const query = MarketListQuery(kind: MarketProductKind.perp);
  late ControlledMarkets repo;
  late ProviderContainer container;
  setUp(() {
    repo = ControlledMarkets();
    container = ProviderContainer(
      overrides: [marketsRepositoryProvider.overrideWithValue(repo)],
    );
  });
  tearDown(() => container.dispose());
  void watch([MarketListQuery key = query]) {
    container.listen(marketListProvider(key), (_, _) {});
  }

  Future<void> complete(int index, DomainPage<MarketProduct> value) async {
    repo.requests[index].result.complete(value);
    await container.pump();
  }

  MarketListState state([MarketListQuery key = query]) =>
      container.read(marketListProvider(key));
  MarketListNotifier commands([MarketListQuery key = query]) =>
      container.read(marketListProvider(key).notifier);

  test(
    'forwards all query dimensions and requests filtered first page',
    () async {
      const key = MarketListQuery(
        kind: MarketProductKind.perp,
        group: MarketListGroup.volume,
        query: ' TSLA ',
        limit: 37,
      );
      watch(key);
      final request = repo.requests.single;
      expect(request.query, 'TSLA');
      expect(request.cursor, isNull);
      expect(request.kind, MarketProductKind.perp);
      expect(request.group, MarketListGroup.volume);
      expect(request.limit, 37);
      await complete(0, page([product('TSLA')]));
      expect(state(key).items.single.symbol, 'TSLA');
    },
  );

  test('empty HIP3 first page is not terminal and HIP3-only later products survive', () async {
    watch();
    await complete(
      0,
      page([product('NVDA', kind: MarketProductKind.bstock)], next: 'opaque-2'),
    );
    expect(state().items, isEmpty);
    expect(state().hasMore, isTrue);
    final next = commands().loadMore();
    expect(repo.requests.last.cursor, 'opaque-2');
    expect(repo.requests.last.kind, MarketProductKind.perp);
    await complete(1, page([product('GOLD')]));
    await next;
    expect(state().items.single.symbol, 'GOLD');
    expect(state().hasMore, isFalse);
  });

  test('deduplicates by symbol and kind, preserving venue variants and server ordering', () async {
    const key = MarketListQuery();
    watch(key);
    await complete(
      0,
      page([
        product('Z'),
        product('A', kind: MarketProductKind.bstock),
      ], next: 'b'),
    );
    final next = commands(key).loadMore();
    await complete(
      1,
      page([product('Z', price: '2'), product('A'), product('Z', price: '3')]),
    );
    await next;
    expect(state(key).items.map((p) => '${p.symbol}/${p.kind.name}'), [
      'Z/perp',
      'A/bstock',
      'A/perp',
    ]);
    expect(state(key).items.first.price.value, '3');
  });

  test(
    'concurrent load more sends once; terminal ignores further calls',
    () async {
      watch();
      await complete(0, page([product('A')], next: 'b'));
      final first = commands().loadMore(), second = commands().loadMore();
      expect(repo.requests.length, 2);
      expect(state().loadingMore, isTrue);
      await complete(1, page([product('B')]));
      await Future.wait([first, second]);
      await commands().loadMore();
      expect(repo.requests.length, 2);
    },
  );

  test('page failure retains items and retries the same cursor', () async {
    watch();
    await complete(0, page([product('A')], next: 'b'));
    final pending = commands().loadMore();
    repo.requests[1].result.completeError(StateError('offline'));
    await pending;
    expect(state().items.single.symbol, 'A');
    expect(state().error, isNotNull);
    expect(state().nextCursor, 'b');
    final retry = commands().loadMore();
    expect(repo.requests[2].cursor, 'b');
    await complete(2, page([product('B')]));
    await retry;
    expect(state().items, hasLength(2));
    expect(state().error, isNull);
  });

  test(
    'first-page failure refresh retries without inventing empty results',
    () async {
      watch();
      repo.requests.single.result.completeError(StateError('offline'));
      await container.pump();
      expect(state().error, isNotNull);
      expect(state().loading, isFalse);
      final refresh = commands().refresh();
      expect(state().loading, isTrue);
      expect(repo.requests.last.cursor, isNull);
      await complete(1, page([product('A')]));
      await refresh;
      expect(state().error, isNull);
    },
  );

  for (final failure in [false, true]) {
    test(
      'refresh isolates an old page arriving late (failure=$failure)',
      () async {
        watch();
        await complete(0, page([product('OLD')], next: 'b'));
        final old = commands().loadMore();
        final refresh = commands().refresh();
        expect(state().items, isEmpty);
        expect(repo.requests[2].cursor, isNull);
        await complete(2, page([product('NEW')], next: 'fresh'));
        await refresh;
        if (failure) {
          repo.requests[1].result.completeError(StateError('late error'));
        } else {
          repo.requests[1].result.complete(page([product('STALE')]));
        }
        await old;
        expect(state().items.single.symbol, 'NEW');
        expect(state().nextCursor, 'fresh');
        expect(state().error, isNull);
      },
    );
  }

  test(
    'quick query, group and kind switches isolate all late responses',
    () async {
      const newer = MarketListQuery(
        kind: MarketProductKind.bstock,
        group: MarketListGroup.losers,
        query: 'new',
      );
      watch();
      watch(newer);
      await complete(1, page([product('NEW', kind: MarketProductKind.bstock)]));
      await complete(0, page([product('OLD')]));
      expect(state(newer).items.single.symbol, 'NEW');
      container.invalidate(marketListProvider(query));
      await container.pump();
      expect(repo.requests.last.cursor, isNull);
      expect(state().items, isEmpty);
      await complete(2, page([product('RESET')]));
    },
  );

  test(
    'account change resets results and ignores previous account requests',
    () async {
      watch();
      container.read(sessionGenerationProvider.notifier).clearUserScope();
      await container.pump();
      await complete(1, page([product('NEW')]));
      await complete(0, page([product('OLD')]));
      expect(state().items.single.symbol, 'NEW');
    },
  );

  test(
    'rejects missing, repeated and cyclic cursors without an infinite loop',
    () async {
      watch();
      await complete(0, const DomainPage(items: [], hasMore: true));
      expect(state().error, isA<FormatException>());
      final refresh = commands().refresh();
      await complete(1, page([product('A')], next: 'b'));
      await refresh;
      final bad = commands().loadMore();
      await complete(2, page([product('B')], next: 'b'));
      await bad;
      expect(state().error, isA<FormatException>());
      expect(state().items.single.symbol, 'A');
      final retry = commands().loadMore();
      await complete(3, page([product('B')], next: 'c'));
      await retry;
      final cycle = commands().loadMore();
      await complete(4, page([product('C')], next: 'b'));
      await cycle;
      expect(state().error, isA<FormatException>());
      expect(state().items, hasLength(2));
    },
  );
}
