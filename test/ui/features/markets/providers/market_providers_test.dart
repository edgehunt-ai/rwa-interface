import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rwa_interface/domain/models/market_list_query.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/ui/features/markets/providers/market_providers.dart';

void main() {
  test('isolates complete query parameters', () async {
    final repository = _MarketsRepository();
    final container = ProviderContainer(
      overrides: [marketsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    const first = (query: 'nv', cursor: 'a');
    const second = (query: 'nv', cursor: 'b');
    expect(
      (await container.read(marketProductsProvider(first).future)).nextCursor,
      'a',
    );
    expect(
      (await container.read(marketProductsProvider(second).future)).nextCursor,
      'b',
    );
  });
}

final class _MarketsRepository implements MarketsRepository {
  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    MarketProductKind? kind,
    MarketListGroup? group,
    int? limit,
  }) async => DomainPage(items: const [], nextCursor: cursor);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
