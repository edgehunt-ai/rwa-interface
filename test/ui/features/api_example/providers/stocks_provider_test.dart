import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/stock.dart';
import 'package:rwa_interface/domain/repositories/markets_repository.dart';
import 'package:rwa_interface/ui/features/api_example/providers/stocks_provider.dart';

void main() {
  test('loads domain stocks through an overridden repository', () async {
    final container = ProviderContainer(
      overrides: [
        marketsRepositoryProvider.overrideWithValue(_FakeMarketsRepository()),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(stocksProvider, (_, _) {});
    addTearDown(subscription.close);
    expect(await container.read(stocksProvider.future), [
      isA<Stock>().having((s) => s.symbol, 'symbol', 'NVDA'),
    ]);
  });

  test('family 参数隔离搜索结果', () async {
    final container = ProviderContainer(
      overrides: [
        marketsRepositoryProvider.overrideWithValue(_FakeMarketsRepository()),
      ],
    );
    addTearDown(container.dispose);
    final result = await container.read(stocksSearchProvider('nvd').future);
    expect(result.map((stock) => stock.symbol), ['NVDA']);
    expect(
      await container.read(stocksSearchProvider('missing').future),
      isEmpty,
    );
  });
}

final class _FakeMarketsRepository implements MarketsRepository {
  @override
  Future<DomainPage<Stock>> listStocks() async => const DomainPage(
    items: [Stock(symbol: 'NVDA', name: 'NVIDIA', referencePrice: '123.4500')],
  );
}
