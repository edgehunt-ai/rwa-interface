import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as wire;
import 'package:rwa_interface/data/repositories/markets_repository_impl.dart';
import 'package:rwa_interface/data/services/charts_service.dart';
import 'package:rwa_interface/data/services/markets_service.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/market_snapshot.dart';

void main() {
  test('分页映射保留 cursor，金融字符串逐字不变', () async {
    const financial = '999999999999999999.123456789012345678';
    final repository = MarketsRepositoryImpl(_Markets(financial));
    final page = await repository.listStocks();
    expect(page.nextCursor, 'next-page');
    expect(page.items.single.referencePrice, financial);
  });

  test(
    'chart range maps to the contract window and sampling interval',
    () async {
      final charts = _Charts();
      final repository = MarketsRepositoryImpl(_Markets('1'), charts);
      const product = MarketProductRef(
        symbol: 'NVDAB',
        kind: MarketProductKind.bstock,
      );

      await repository.getCandles(product, range: CandleChartRange.oneHour);
      expect(charts.range, isNull);
      expect(charts.from, isNotNull);
      expect(charts.to, isNotNull);
      expect(charts.to!.difference(charts.from!), const Duration(hours: 1));
      expect(charts.interval, '1m');

      await repository.getCandles(product, range: CandleChartRange.fourHours);
      expect(charts.range, wire.ChartRange.n4h);
      expect(charts.from, isNull);
      expect(charts.to, isNull);
      expect(charts.interval, '5m');

      await repository.getCandles(product, range: CandleChartRange.oneDay);
      expect(charts.range, wire.ChartRange.n24h);
      expect(charts.interval, '15m');

      await repository.getCandles(product, range: CandleChartRange.oneWeek);
      expect(charts.range, wire.ChartRange.n1w);
      expect(charts.interval, '1h');
    },
  );
}

final class _Markets implements MarketsService {
  _Markets(this.financial);
  final String financial;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);

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

final class _Charts implements ChartsService {
  wire.ChartRange? range;
  DateTime? from;
  DateTime? to;
  String? interval;

  @override
  Future<wire.CandleSeries> getCandles(
    String symbol,
    wire.ProductKind kind, {
    wire.ChartRange? range,
    DateTime? from,
    DateTime? to,
    String? interval,
  }) async {
    this.range = range;
    this.from = from;
    this.to = to;
    this.interval = interval;
    return wire.CandleSeries(
      (series) => series
        ..symbol = symbol
        ..kind = kind
        ..range = wire.ChartRange.n4h,
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
