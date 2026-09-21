import '../../domain/models/bstocks_support.dart';
import '../../domain/models/api_failure.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/stock.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/market_snapshot.dart';
import '../../domain/repositories/markets_repository.dart';
import '../services/charts_service.dart';
import '../services/markets_service.dart';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

final class MarketsRepositoryImpl implements MarketsRepository {
  MarketsRepositoryImpl(this._service, [this._charts]);
  final MarketsService _service;
  final ChartsService? _charts;

  @override
  Future<DomainPage<Stock>> listStocks() async {
    final page = await _service.listStocks();
    return DomainPage(
      items: page.items
          .map(
            (group) => Stock(
              symbol: group.stock.symbol,
              name: group.stock.name,
              referencePrice: group.stock.referencePrice,
              products: group.products
                  .map(
                    (product) => MarketProductRef(
                      symbol: product.symbol,
                      kind: _kind(product.kind),
                    ),
                  )
                  .toList(growable: false),
            ),
          )
          .toList(growable: false),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<List<BstocksSupportedToken>> listBstocksSupportedTokens() async {
    final page = await _service.listBstocksSupportedTokens();
    return page.items
        .map(
          (token) => BstocksSupportedToken(
            symbol: token.symbol,
            contractAddress: token.contractAddress,
            decimals: token.decimals,
            executionStatus: switch (token.executionStatus) {
              api.BstocksSupportedTokenExecutionStatusEnum.discoveryOnly =>
                BstocksExecutionStatus.discoveryOnly,
              api.BstocksSupportedTokenExecutionStatusEnum.admitted =>
                BstocksExecutionStatus.admitted,
              _ => BstocksExecutionStatus.unknown,
            },
            executionEnabled: token.executionEnabled,
            underlyingSymbol: token.underlyingSymbol,
            feedSymbol: token.feedSymbol,
            asset: token.asset,
            multiplier: token.multiplier,
            assetType: token.assetType,
            lastUpdateTime: token.lastUpdateTime == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(
                    token.lastUpdateTime!,
                    isUtc: true,
                  ),
          ),
        )
        .toList(growable: false);
  }

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
    String? group,
    MarketProductKind? productType,
  }) async {
    final page = await _service.listProducts(
      query: query,
      cursor: cursor,
      group: group,
      productType: productType == null
          ? api.ProductType.all
          : productType == MarketProductKind.bstock
          ? api.ProductType.spot
          : api.ProductType.contract,
    );
    return DomainPage(
      items: page.items.map(_listing).toList(),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<MarketProduct> getProduct(MarketProductRef ref) async {
    final value = await _service.getProduct(ref.symbol, _apiKind(ref.kind));
    return MarketProduct(
      symbol: value.symbol,
      name: value.name ?? value.symbol,
      kind: _kind(value.kind),
      price: DecimalValue(value.quote.price, asset: 'USDC', unit: 'price'),
      settlementAsset: 'USDC',
      network: value.kind == api.ProductKind.bstock ? 'BSC' : 'Arbitrum',
      tradable: value.kind == api.ProductKind.perp
          ? (value.hip3Market?.tradable ?? false)
          : true,
      change24hPercent: _decimal(value.quote.change24hPercent, unit: 'percent'),
    );
  }

  @override
  Future<MarketSnapshot> getSnapshot(MarketProductRef ref) async {
    final kind = _apiKind(ref.kind);
    final product = await _service.getProduct(ref.symbol, kind);
    api.OrderBook? book;
    try {
      book = await _service.getOrderBook(ref.symbol, kind);
    } on ApiFailure catch (failure) {
      if (failure.kind != FailureKind.unavailable &&
          failure.kind != FailureKind.network) {
        rethrow;
      }
    }
    return MarketSnapshot(
      price: DecimalValue(product.quote.price, asset: 'USDC', unit: 'price'),
      change24hPercent: _decimal(
        product.quote.change24hPercent,
        unit: 'percent',
      ),
      bids: book?.bids.map(_bookEntry).toList() ?? const [],
      asks: book?.asks.map(_bookEntry).toList() ?? const [],
      asOf: book?.updatedAt?.toUtc() ?? product.quote.updatedAt?.toUtc(),
      high24h: _decimal(product.stats?.high24h),
      low24h: _decimal(product.stats?.low24h),
      volume24h: _decimal(product.stats?.volume24h),
      turnover24h: _decimal(product.stats?.turnover24hUsd),
      fundingRate: _decimal(product.stats?.fundingRate),
      openInterestUsd: _decimal(product.stats?.openInterestUsd),
      referencePrice: _decimal(product.stats?.referencePrice),
      bestBid: _decimal(product.stats?.bestBid),
      bestAsk: _decimal(product.stats?.bestAsk),
      referenceLabel: product.stats?.referenceLabel,
      relativeLabel: product.stats?.relativeLabel,
      basisPercent: _decimal(product.stats?.relativePercent),
      spreadPercent: _decimal(product.stats?.spreadPercent),
      assetTitle: product.assetInfo.title,
      assetBadge: product.assetInfo.badge,
      assetDescription: product.assetInfo.description,
      assetRights: product.assetInfo.rows
          .map((row) => AssetRight(label: row.label, value: row.value))
          .toList(growable: false),
    );
  }

  @override
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    CandleChartRange? range,
    String? interval,
    DateTime? from,
    DateTime? to,
  }) async {
    final charts = _charts;
    if (charts == null) throw StateError('ChartsService is not configured');
    final request = range == null ? null : _candleRequest(range);
    final value = await charts.getCandles(
      ref.symbol,
      _apiKind(ref.kind),
      range: request?.range,
      interval: request?.interval ?? interval,
      from: request?.from ?? from,
      to: request?.to ?? to,
    );
    final reference = ref.kind == MarketProductKind.bstock
        ? await _referencePrice(charts, ref.symbol)
        : null;
    return CandleChart(
      symbol: value.symbol,
      range: value.range.name,
      fetchedAt: DateTime.now().toUtc(),
      interval: value.interval ?? request?.interval ?? interval,
      from: value.from?.toUtc(),
      to: value.to?.toUtc(),
      points: value.points
          .map(
            (point) => Candle(
              at: point.t.toUtc(),
              close: DecimalValue(point.c, asset: 'USDC', unit: 'price'),
              open: _decimal(point.o, asset: 'USDC', unit: 'price'),
              high: _decimal(point.h, asset: 'USDC', unit: 'price'),
              low: _decimal(point.l, asset: 'USDC', unit: 'price'),
              volume: _decimal(point.v, unit: 'volume'),
            ),
          )
          .toList(),
      referencePoints:
          (value.referencePoints?.toList() ?? const <api.CandlePoint>[])
              .map(
                (point) => Candle(
                  at: point.t.toUtc(),
                  close: DecimalValue(point.c, asset: 'USD', unit: 'price'),
                ),
              )
              .toList(),
      referencePrice: reference == null
          ? null
          : DecimalValue(reference.price, asset: 'USD', unit: 'price'),
      referencePriceIsStale: reference?.isStale ?? false,
      sessions: (value.sessions?.toList() ?? const <api.SessionSegment>[])
          .map(
            (segment) => MarketSessionSegment(
              kind: _sessionKind(segment.session),
              start: segment.start.toUtc(),
              end: segment.end.toUtc(),
              label: segment.label,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<void> addFavorite(MarketProductRef ref) =>
      _service.addFavorite(ref.symbol, _apiKind(ref.kind));
  @override
  Future<void> removeFavorite(MarketProductRef ref) =>
      _service.removeFavorite(ref.symbol, _apiKind(ref.kind));
  @override
  Future<void> replaceFavorites(List<MarketProductRef> refs) =>
      _service.replaceFavorites(
        refs
            .map(
              (ref) => api.ProductRef(
                (builder) => builder
                  ..symbol = ref.symbol
                  ..kind = _apiKind(ref.kind),
              ),
            )
            .toList(),
      );

  MarketProduct _listing(api.ProductListing value) => MarketProduct(
    symbol: value.symbol,
    name: value.name ?? value.symbol,
    kind: _kind(value.kind),
    price: DecimalValue(value.price, asset: 'USDC', unit: 'price'),
    settlementAsset: 'USDC',
    network: value.kind == api.ProductKind.bstock ? 'BSC' : 'Arbitrum',
    tradable: true,
    productId: value.hip3Market?.productId,
    change24hPercent: _decimal(value.change24hPercent, unit: 'percent'),
    volume24h: _decimal(value.volume24h, unit: value.volume24hUnit),
    isFavorite: value.isFavorite ?? false,
  );

  OrderBookEntry _bookEntry(api.OrderBookLevel value) => OrderBookEntry(
    price: DecimalValue(value.price, asset: 'USDC', unit: 'price'),
    size: DecimalValue(value.size, unit: 'quantity'),
  );

  MarketProductKind _kind(api.ProductKind value) =>
      value == api.ProductKind.bstock
      ? MarketProductKind.bstock
      : MarketProductKind.perp;
  api.ProductKind _apiKind(MarketProductKind value) => switch (value) {
    MarketProductKind.bstock => api.ProductKind.bstock,
    MarketProductKind.perp => api.ProductKind.perp,
  };

  MarketSessionKind _sessionKind(api.SessionKind value) => switch (value) {
    api.SessionKind.premarket => MarketSessionKind.premarket,
    api.SessionKind.regular => MarketSessionKind.regular,
    api.SessionKind.after => MarketSessionKind.afterHours,
    api.SessionKind.overnight => MarketSessionKind.overnight,
    api.SessionKind.weekend => MarketSessionKind.weekend,
    _ => MarketSessionKind.holiday,
  };

  Future<api.ReferencePrice?> _referencePrice(
    ChartsService charts,
    String symbol,
  ) async {
    try {
      return await charts.getReferencePrice(symbol);
    } catch (_) {
      return null;
    }
  }

  DecimalValue? _decimal(String? value, {String? asset, String? unit}) =>
      value == null ? null : DecimalValue(value, asset: asset, unit: unit);

  _CandleRequest _candleRequest(CandleChartRange range) {
    final now = DateTime.now().toUtc();
    return switch (range) {
      CandleChartRange.oneHour => _CandleRequest(
        from: now.subtract(const Duration(hours: 1)),
        to: now,
        interval: '1m',
      ),
      CandleChartRange.fourHours => const _CandleRequest(
        range: api.ChartRange.n4h,
        interval: '5m',
      ),
      CandleChartRange.oneDay => const _CandleRequest(
        range: api.ChartRange.n24h,
        interval: '15m',
      ),
      CandleChartRange.oneWeek => const _CandleRequest(
        range: api.ChartRange.n1w,
        interval: '1h',
      ),
    };
  }
}

final class _CandleRequest {
  const _CandleRequest({
    this.range,
    this.from,
    this.to,
    required this.interval,
  });

  final api.ChartRange? range;
  final DateTime? from;
  final DateTime? to;
  final String interval;
}
