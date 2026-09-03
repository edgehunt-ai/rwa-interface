import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as wire;
import 'package:rwa_interface/data/repositories/markets_repository_impl.dart';
import 'package:rwa_interface/data/services/markets_service.dart';

void main() {
  test('分页映射保留 cursor，金融字符串逐字不变', () async {
    const financial = '999999999999999999.123456789012345678';
    final repository = MarketsRepositoryImpl(_Markets(financial));
    final page = await repository.listStocks();
    expect(page.nextCursor, 'next-page');
    expect(page.items.single.referencePrice, financial);
  });
}

final class _Markets implements MarketsService {
  _Markets(this.financial);
  final String financial;

  @override
  Future<wire.StockPage> listStocks() async => wire.StockPage(
    (page) => page
      ..hasMore = true
      ..nextCursor = 'next-page'
      ..items.add(
        wire.StockGroup(
          (group) => group
            ..products.clear()
            ..stock.update(
              (stock) => stock
                ..symbol = 'NVDA'
                ..name = 'NVIDIA'
                ..referencePrice = financial,
            ),
        ),
      ),
  );
}
