import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/markets_repository_impl.dart';
import 'package:rwa_interface/data/services/markets_service.dart';
import 'package:rwa_interface/data/services/charts_service.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/market_product.dart';

void main() {
  test(
    'bound candles reject wrong environment or venue before chart request',
    () async {
      final charts = _Charts();
      for (final ref in [
        const MarketProductRef(
          symbol: 'TSLA',
          kind: MarketProductKind.perp,
          productId: 'xyz:TSLA',
          environment: 'testnet',
        ),
        const MarketProductRef(
          symbol: 'TSLA',
          kind: MarketProductKind.perp,
          productId: 'other:TSLA',
          environment: 'mainnet',
        ),
      ]) {
        await expectLater(
          MarketsRepositoryImpl(_Markets(), charts).getCandles(ref),
          throwsA(isA<CompatibilityFailure>()),
        );
      }
      expect(charts.calls, 0);
      final series = await MarketsRepositoryImpl(_Markets(), charts).getCandles(
        const MarketProductRef(
          symbol: 'TSLA',
          kind: MarketProductKind.perp,
          productId: 'xyz:TSLA',
          environment: 'mainnet',
        ),
      );
      expect(charts.calls, 1);
      expect(series.points.single.close.asset, 'USDH');
    },
  );
  test('listing retains source environment, collateral and freshness without granting trading', () async {
    final product = (await MarketsRepositoryImpl(
      _Markets(),
    ).listProducts()).items.single;
    expect(product.hip3Market?.productId, 'xyz:TSLA');
    expect(product.hip3Market?.environment, 'mainnet');
    expect(product.settlementAsset, 'USDH');
    expect(product.price.asset, 'USDH');
    expect(product.network, 'Hyperliquid · mainnet');
    expect(product.tradable, isFalse);
    expect(product.priceKind, 'mark');
    expect(product.updatedAt, DateTime.utc(2026, 9, 10));
    expect(product.validUntil, DateTime.utc(2026, 9, 10, 0, 0, 5));
  });
  test('old HIP3 response does not assume tradable USDC on Arbitrum', () async {
    final product = (await MarketsRepositoryImpl(
      _Markets(identity: false),
    ).listProducts()).items.single;
    expect(product.hip3Market, isNull);
    expect(product.tradable, isFalse);
    expect(product.price.asset, isNull);
    expect(product.network, 'Hyperliquid');
  });
  test(
    'detail rejects same-symbol response from the wrong environment',
    () async {
      await expectLater(
        MarketsRepositoryImpl(_Markets()).getProduct(
          const MarketProductRef(
            symbol: 'TSLA',
            kind: MarketProductKind.perp,
            productId: 'xyz:TSLA',
            environment: 'testnet',
          ),
        ),
        throwsA(isA<CompatibilityFailure>()),
      );
    },
  );
}

class _Charts implements ChartsService {
  int calls = 0;
  @override
  Future<api.CandleSeries> getCandles(
    String symbol,
    api.ProductKind kind, {
    api.ChartRange? range,
    String? interval,
    DateTime? from,
    DateTime? to,
  }) async {
    calls++;
    return api.CandleSeries(
      (b) => b
        ..symbol = symbol
        ..kind = kind
        ..range = api.ChartRange.n24h
        ..points.add(
          api.CandlePoint(
            (p) => p
              ..t = DateTime.utc(2026)
              ..c = '100',
          ),
        ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Markets implements MarketsService {
  _Markets({this.identity = true});
  final bool identity;
  Map<String, Object?> get wire => {
    'symbol': 'TSLA',
    'name': 'Tesla',
    'kind': 'perp',
    'price': '100.1',
    'price_kind': 'mark',
    'data_status': 'fresh',
    'updated_at': '2026-09-10T00:00:00Z',
    'valid_until': '2026-09-10T00:00:05Z',
    if (identity)
      'hip3_market': {
        'product_id': 'xyz:TSLA',
        'venue': 'xyz',
        'environment': 'mainnet',
        'settlement_asset': 'USDH',
        'tradable': false,
        'unavailable_reason': 'mainnet_read_only',
      },
  };
  @override
  Future<api.ProductPage> listProducts({
    String? query,
    String? cursor,
    api.MarketProductGroup? group,
    api.ProductType? productType,
    int? limit,
  }) async => api.ProductPage(
    (b) => b
      ..hasMore = false
      ..items.add(
        api.standardSerializers.deserializeWith(
          api.ProductListing.serializer,
          wire,
        )!,
      ),
  );
  @override
  Future<api.ProductDetail> getProduct(
    String symbol,
    api.ProductKind kind,
  ) async =>
      api.standardSerializers.deserializeWith(api.ProductDetail.serializer, {
        ...wire,
        'quote': {'price': '100.1'},
        'asset_info': {
          'title': 'HIP-3',
          'badge': 'Mainnet',
          'description': 'Read only',
          'rows': <Object>[],
        },
      })!;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
