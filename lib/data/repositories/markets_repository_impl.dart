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
            ),
          )
          .toList(growable: false),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<DomainPage<MarketProduct>> listProducts({
    String? query,
    String? cursor,
  }) async {
    final page = await _service.listProducts(query: query, cursor: cursor);
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
      tradable: true,
      change24hPercent: _decimal(value.quote.change24hPercent, unit: 'percent'),
    );
  }

  @override
  Future<MarketSnapshot> getSnapshot(MarketProductRef ref) async {
    final kind = _apiKind(ref.kind);
    final product = await _service.getProduct(ref.symbol, kind);
    final book = await _service.getOrderBook(ref.symbol, kind);
    return MarketSnapshot(
      price: DecimalValue(product.quote.price, asset: 'USDC', unit: 'price'),
      change24hPercent: _decimal(
        product.quote.change24hPercent,
        unit: 'percent',
      ),
      bids: book.bids.map(_bookEntry).toList(),
      asks: book.asks.map(_bookEntry).toList(),
      asOf: book.updatedAt?.toUtc() ?? product.quote.updatedAt?.toUtc(),
    );
  }

  @override
  Future<CandleChart> getCandles(
    MarketProductRef ref, {
    required CandleChartRange range,
  }) async {
    final charts = _charts;
    if (charts == null) throw StateError('ChartsService is not configured');
    final request = _candleRequest(range);
    final value = await charts.getCandles(
      ref.symbol,
      _apiKind(ref.kind),
      range: request.range,
      from: request.from,
      to: request.to,
      interval: request.interval,
    );
    return CandleChart(
      symbol: value.symbol,
      range: value.range.name,
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
