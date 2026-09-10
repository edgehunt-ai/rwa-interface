import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as wire;
import 'package:rwa_interface/data/repositories/markets_repository_impl.dart';
import 'package:rwa_interface/data/services/markets_service.dart';
import 'package:rwa_interface/data/services/charts_service.dart';
import 'package:rwa_interface/domain/models/market_product.dart';

void main() {
  test(
    'HIP3 candle mapping retains OHLCV decimals and explicit time window',
    () async {
      final charts = _Charts();
      final repository = MarketsRepositoryImpl(_Markets('1'), charts);
      final to = DateTime.utc(2026, 9, 10, 10);
      final from = to.subtract(const Duration(hours: 1));
      final chart = await repository.getCandles(
        const MarketProductRef(symbol: 'TSLA', kind: MarketProductKind.perp),
        interval: '1m',
        from: from,
        to: to,
      );
      expect(charts.from, from);
      expect(charts.to, to);
      expect(chart.points.single.open!.value, '100.0000');
      expect(chart.points.single.high!.value, '103.0000');
      expect(chart.points.single.low!.value, '99.0000');
      expect(chart.points.single.close.value, '101.0000');
      expect(chart.points.single.volume!.value, '0.001');
      expect(chart.from, from);
      expect(chart.to, to);
      expect(chart.interval, '1m');
    },
  );
  test('分页映射保留 cursor，金融字符串逐字不变', () async {
    const financial = '999999999999999999.123456789012345678';
    final repository = MarketsRepositoryImpl(_Markets(financial));
    final page = await repository.listStocks();
    expect(page.nextCursor, 'next-page');
    expect(page.items.single.referencePrice, financial);
  });
}

class _Charts implements ChartsService {
  DateTime? from, to;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  @override
  Future<wire.CandleSeries> getCandles(
    String symbol,
    wire.ProductKind kind, {
    wire.ChartRange? range,
    String? interval,
    DateTime? from,
    DateTime? to,
  }) async {
    expect(symbol, 'TSLA');
    expect(kind, wire.ProductKind.perp);
    this.from = from;
    this.to = to;
    return wire.CandleSeries(
      (b) => b
        ..symbol = symbol
        ..kind = kind
        ..range = wire.ChartRange.n24h
        ..interval = interval
        ..from = from
        ..to = to
        ..points.add(
          wire.CandlePoint(
            (p) => p
              ..t = from
              ..o = '100.0000'
              ..h = '103.0000'
              ..l = '99.0000'
              ..c = '101.0000'
              ..v = '0.001',
          ),
        ),
    );
  }
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
