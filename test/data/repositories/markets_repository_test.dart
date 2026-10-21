import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as wire;
import 'package:nobell/data/repositories/markets_repository_impl.dart';
import 'package:nobell/data/services/markets_service.dart';
import 'package:nobell/data/services/charts_service.dart';
import 'package:nobell/domain/models/bstocks_support.dart';
import 'package:nobell/domain/models/market_product.dart';

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
    expect(page.items.single.logoUrl, 'https://cdn.example.com/nvda.png');
    expect(page.items.single.logoText, 'ST');
    expect(page.items.single.products, [
      const MarketProductRef(symbol: 'NVDA', kind: MarketProductKind.bstock),
      const MarketProductRef(symbol: 'NVDA', kind: MarketProductKind.perp),
    ]);
  });

  test(
    'product list and detail preserve their own API logo metadata',
    () async {
      final repository = MarketsRepositoryImpl(_Markets('100'));
      final page = await repository.listProducts();
      final detail = await repository.getProduct(
        const MarketProductRef(symbol: 'NVDAB', kind: MarketProductKind.bstock),
      );

      expect(page.items.first.logoUrl, 'https://cdn.example.com/product.svg');
      expect(page.items.first.logoText, 'PR');
      expect(page.items.last.logoUrl, isNull);
      expect(page.items.last.logoText, 'NO');
      expect(detail.logoUrl, 'https://cdn.example.com/detail.png');
      expect(detail.logoText, 'DT');
      expect(detail.isFavorite, isTrue);
    },
  );

  test(
    'HIP-3 detail preserves the product identity without a product listing',
    () async {
      final product = await MarketsRepositoryImpl(_Markets('100')).getProduct(
        const MarketProductRef(symbol: 'NVDA', kind: MarketProductKind.perp),
      );

      expect(product.productId, 'xyz:NVDA');
      expect(product.tradable, isTrue);
    },
  );

  test(
    'bStocks snapshot preserves the product ID from the order book',
    () async {
      final snapshot = await MarketsRepositoryImpl(_Markets('100')).getSnapshot(
        const MarketProductRef(symbol: 'NVDAB', kind: MarketProductKind.bstock),
      );

      expect(snapshot.productId, 'bstocks:nvdab');
    },
  );

  test('只有通过准入且启用的 bStock 才可执行', () async {
    final tokens = await MarketsRepositoryImpl(_BstocksDiscovery())
        .listBstocksSupportedTokens();

    expect(tokens.map((token) => token.symbol), ['NVDAX', 'TSLAX', 'AAPLX']);
    // Discovery only ever authorises display; execution needs both signals.
    expect(tokens[0].executionStatus, BstocksExecutionStatus.discoveryOnly);
    expect(tokens[0].isExecutable, isFalse);
    expect(tokens[1].executionStatus, BstocksExecutionStatus.admitted);
    expect(tokens[1].isExecutable, isFalse);
    expect(tokens[2].isExecutable, isTrue);

    expect(tokens[2].multiplier, '1.000000000000000001');
    expect(tokens[2].decimals, 18);
    expect(tokens[2].lastUpdateTime, DateTime.utc(2026, 1, 1));
  });
}

final class _BstocksDiscovery implements MarketsService {
  @override
  Future<wire.BstocksSupportedTokenPage> listBstocksSupportedTokens() async =>
      wire.BstocksSupportedTokenPage(
        (page) => page.items.addAll([
          _token(
            'NVDAX',
            wire.BstocksSupportedTokenExecutionStatusEnum.discoveryOnly,
            false,
          ),
          _token(
            'TSLAX',
            wire.BstocksSupportedTokenExecutionStatusEnum.admitted,
            false,
          ),
          _token(
            'AAPLX',
            wire.BstocksSupportedTokenExecutionStatusEnum.admitted,
            true,
          ),
        ]),
      );

  static wire.BstocksSupportedToken _token(
    String symbol,
    wire.BstocksSupportedTokenExecutionStatusEnum status,
    bool enabled,
  ) => wire.BstocksSupportedToken(
    (token) => token
      ..symbol = symbol
      ..contractAddress = '0x1111111111111111111111111111111111111111'
      ..decimals = 18
      ..multiplier = '1.000000000000000001'
      ..lastUpdateTime = DateTime.utc(2026, 1, 1).millisecondsSinceEpoch
      ..displayEnabled = true
      ..executionStatus = status
      ..executionEnabled = enabled,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
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
  Future<wire.ProductDetail> getProduct(
    String symbol,
    wire.ProductKind kind,
  ) async => wire.ProductDetail(
    (product) => product
      ..symbol = symbol
      ..kind = kind
      ..logoUrl = 'https://cdn.example.com/detail.png'
      ..logoText = 'DT'
      ..hip3Market = kind == wire.ProductKind.perp
          ? wire.standardSerializers.deserializeWith(
              wire.Hip3PublicMarket.serializer,
              {
                'product_id': 'xyz:$symbol',
                'venue': 'xyz',
                'environment': 'mainnet',
                'settlement_asset': 'USDC',
                'tradable': true,
              },
            )
          : null
      ..isFavorite = true
      ..quote.update((quote) => quote.price = financial)
      ..assetInfo.update(
        (info) => info
          ..title = symbol
          ..badge = ''
          ..description = '',
      ),
  );

  @override
  Future<wire.OrderBook> getOrderBook(
    String symbol,
    wire.ProductKind kind,
  ) async => wire.OrderBook((book) => book.productId = 'bstocks:nvdab');

  @override
  Future<wire.ProductPage> listProducts({
    String? query,
    String? cursor,
    String? group,
    wire.ProductType? productType,
  }) async => wire.ProductPage(
    (page) => page
      ..hasMore = false
      ..items.addAll([
        wire.ProductListing(
          (product) => product
            ..symbol = 'NVDAB'
            ..kind = wire.ProductKind.bstock
            ..price = financial
            ..logoUrl = 'https://cdn.example.com/product.svg'
            ..logoText = 'PR',
        ),
        wire.ProductListing(
          (product) => product
            ..symbol = 'NVDA'
            ..kind = wire.ProductKind.perp
            ..price = financial
            ..logoText = 'NO',
        ),
      ]),
  );

  @override
  Future<wire.StockPage> listStocks() async => wire.StockPage(
    (page) => page
      ..hasMore = true
      ..nextCursor = 'next-page'
      ..items.add(
        wire.StockGroup(
          (group) => group
            ..products.addAll([
              wire.ProductListing(
                (product) => product
                  ..symbol = 'NVDA'
                  ..kind = wire.ProductKind.bstock
                  ..price = financial,
              ),
              wire.ProductListing(
                (product) => product
                  ..symbol = 'NVDA'
                  ..kind = wire.ProductKind.perp
                  ..price = financial,
              ),
            ])
            ..stock.update(
              (stock) => stock
                ..symbol = 'NVDA'
                ..name = 'NVIDIA'
                ..logoUrl = 'https://cdn.example.com/nvda.png'
                ..logoText = 'ST'
                ..referencePrice = financial,
            ),
        ),
      ),
  );
}
