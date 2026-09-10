import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/markets_repository_impl.dart';
import 'package:rwa_interface/data/services/markets_service.dart';
import 'package:rwa_interface/domain/models/market_product.dart';

void main() {
  test('maps product union, pagination, favorite, and decimal text', () async {
    final service = _Markets();
    final page = await MarketsRepositoryImpl(service).listProducts(cursor: 'a');
    expect(page.hasMore, isTrue);
    expect(page.nextCursor, 'b');
    expect(page.items.single.kind, MarketProductKind.bstock);
    expect(page.items.single.price.value, '123.4500');
    expect(page.items.single.isFavorite, isTrue);
  });
}

final class _Markets implements MarketsService {
  @override
  Future<api.ProductPage> listProducts({
    String? query,
    String? cursor,
    api.MarketProductGroup? group,
    api.ProductType? productType,
    int? limit,
  }) async => api.ProductPage(
    (page) => page
      ..hasMore = true
      ..nextCursor = 'b'
      ..items.add(
        api.ProductListing(
          (item) => item
            ..symbol = 'NVDA'
            ..name = 'NVIDIA'
            ..kind = api.ProductKind.bstock
            ..price = '123.4500'
            ..isFavorite = true,
        ),
      ),
  );
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
