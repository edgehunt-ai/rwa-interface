import '../../domain/models/domain_page.dart';
import '../../domain/models/api_failure.dart';
import '../../domain/models/stock.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/market_snapshot.dart';
import '../../domain/models/market_list_query.dart';
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
    MarketProductKind? kind,
    MarketListGroup? group,
    int? limit,
  }) async {
    final page = await _service.listProducts(
      query: query,
      cursor: cursor,
      group: group == null ? null : api.MarketProductGroup.valueOf(group.name),
      productType: switch (kind) {
        MarketProductKind.perp => api.ProductType.contract,
        MarketProductKind.bstock => api.ProductType.spot,
        null => null,
      },
      limit: limit,
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
    final market = _hip3Market(value.hip3Market);
    _validateBinding(ref, market);
    return MarketProduct(
      symbol: value.symbol,
      name: value.name ?? value.symbol,
      kind: _kind(value.kind),
      price: DecimalValue(
        value.quote.price,
        asset: value.kind == api.ProductKind.bstock
            ? 'USDC'
            : market?.settlementAsset,
        unit: 'price',
      ),
      settlementAsset: value.kind == api.ProductKind.bstock
          ? 'USDC'
          : market?.settlementAsset ?? '',
      network: _network(value.kind, market),
      tradable:
          value.kind == api.ProductKind.bstock || (market?.tradable ?? false),
      hip3Market: market,
      priceKind: value.quote.priceKind?.name,
      updatedAt: value.quote.updatedAt?.toUtc(),
      validUntil: value.quote.validUntil?.toUtc(),
      isStale: value.quote.dataStatus == api.QuoteDataStatusEnum.stale,
      isFavorite: value.isFavorite ?? false,
      change24hPercent: _decimal(value.quote.change24hPercent, unit: 'percent'),
    );
  }

  @override
  Future<MarketSnapshot> getSnapshot(MarketProductRef ref) async {
    final kind = _apiKind(ref.kind);
    final product = await _service.getProduct(ref.symbol, kind);
    final market = _hip3Market(product.hip3Market);
    _validateBinding(ref, market);
    final book = await _service.getOrderBook(ref.symbol, kind);
    return MarketSnapshot(
      price: DecimalValue(
        product.quote.price,
        asset: kind == api.ProductKind.bstock
            ? 'USDC'
            : market?.settlementAsset,
        unit: 'price',
      ),
      hip3Market: market,
      priceKind: product.quote.priceKind?.name,
      quoteLabel: product.quote.label,
      validUntil: product.quote.validUntil?.toUtc(),
      isStale: product.quote.dataStatus == api.QuoteDataStatusEnum.stale,
      change24hPercent: _decimal(
        product.quote.change24hPercent,
        unit: 'percent',
      ),
      bids: book.bids.map(_bookEntry).toList(),
      asks: book.asks.map(_bookEntry).toList(),
      asOf: product.quote.updatedAt?.toUtc(),
      high24h: _decimal(product.stats?.high24h),
      low24h: _decimal(product.stats?.low24h),
      volume24h: _decimal(product.stats?.volume24h),
      turnover24h: _decimal(product.stats?.turnover24hUsd),
      fundingRate: _decimal(product.stats?.fundingRate),
      openInterestUsd: _decimal(product.stats?.openInterestUsd),
      referencePrice: _decimal(product.stats?.referencePrice),
      referenceLabel: product.stats?.referenceLabel,
      basisPercent: _decimal(product.stats?.relativePercent),
      spreadPercent: _decimal(product.stats?.spreadPercent),
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
    String? candleAsset = ref.kind == MarketProductKind.bstock ? 'USDC' : null;
    Hip3PublicMarket? candleMarket;
    // The chart endpoint has a symbol/kind path, so validate a frozen route
    // identity before asking it for candles. A mainnet quote cannot silently
    // become a testnet chart (or a different venue with the same ticker).
    if (ref.kind == MarketProductKind.perp &&
        (ref.productId != null || ref.environment != null)) {
      final product = await _service.getProduct(ref.symbol, _apiKind(ref.kind));
      final market = _hip3Market(product.hip3Market);
      _validateBinding(ref, market);
      candleMarket = market;
      candleAsset = market?.settlementAsset;
    }
    final request = range == null ? null : _candleRequest(range);
    final value = await charts.getCandles(
      ref.symbol,
      _apiKind(ref.kind),
      range: request?.range,
      interval: request?.interval ?? interval,
      from: request?.from ?? from,
      to: request?.to ?? to,
    );
    final observation = value.hip3Provenance;
    Hip3CandleProvenance? provenance;
    if (ref.kind == MarketProductKind.perp && observation != null) {
      final environment = observation.environment.name;
      final expectedInterval = request?.interval ?? interval;
      if (value.symbol != ref.symbol ||
          value.kind != api.ProductKind.perp ||
          (expectedInterval != null && value.interval != expectedInterval) ||
          observation.source_ != 'hyperliquid_$environment' ||
          !observation.productId.contains(':') ||
          !observation.freshUntil.isAfter(observation.updatedAt) ||
          ((candleMarket?.productId ?? ref.productId) != null &&
              observation.productId !=
                  (candleMarket?.productId ?? ref.productId)) ||
          ((candleMarket?.environment ?? ref.environment) != null &&
              environment != (candleMarket?.environment ?? ref.environment))) {
        throw const CompatibilityFailure();
      }
      provenance = Hip3CandleProvenance(
        productId: observation.productId,
        environment: environment,
        source: observation.source_,
        observedAt: observation.updatedAt.toUtc(),
        freshUntil: observation.freshUntil.toUtc(),
      );
    }
    final reference = ref.kind == MarketProductKind.bstock
        ? await _referencePrice(charts, ref.symbol)
        : null;
    return CandleChart(
      symbol: value.symbol,
      range: value.range.name,
      fetchedAt: DateTime.now().toUtc(),
      hip3Market: candleMarket,
      hip3Provenance: provenance,
      interval: value.interval ?? request?.interval ?? interval,
      from: value.from?.toUtc(),
      to: value.to?.toUtc(),
      points: value.points
          .map(
            (point) => Candle(
              at: point.t.toUtc(),
              close: DecimalValue(point.c, asset: candleAsset, unit: 'price'),
              open: _decimal(point.o, asset: candleAsset, unit: 'price'),
              high: _decimal(point.h, asset: candleAsset, unit: 'price'),
              low: _decimal(point.l, asset: candleAsset, unit: 'price'),
              volume: _decimal(point.v, unit: 'volume'),
              hip3Provenance: provenance,
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

  MarketProduct _listing(api.ProductListing value) {
    final market = _hip3Market(value.hip3Market);
    return MarketProduct(
      symbol: value.symbol,
      name: value.name ?? value.symbol,
      kind: _kind(value.kind),
      price: DecimalValue(
        value.price,
        asset: value.kind == api.ProductKind.bstock
            ? 'USDC'
            : market?.settlementAsset,
        unit: 'price',
      ),
      settlementAsset: value.kind == api.ProductKind.bstock
          ? 'USDC'
          : market?.settlementAsset ?? '',
      network: _network(value.kind, market),
      tradable:
          value.kind == api.ProductKind.bstock || (market?.tradable ?? false),
      hip3Market: market,
      priceKind: value.priceKind?.name,
      updatedAt: value.updatedAt?.toUtc(),
      validUntil: value.validUntil?.toUtc(),
      isStale: value.dataStatus == api.ProductListingDataStatusEnum.stale,
      change24hPercent: _decimal(value.change24hPercent, unit: 'percent'),
      volume24h: _decimal(value.volume24h, unit: value.volume24hUnit),
      turnover24hUsd: _decimal(
        value.turnover24hUsd,
        asset: 'USD',
        unit: 'notional',
      ),
      isFavorite: value.isFavorite ?? false,
    );
  }

  Hip3PublicMarket? _hip3Market(api.Hip3PublicMarket? value) {
    if (value == null) return null;
    if (!['mainnet', 'testnet'].contains(value.environment.name) ||
        !value.productId.startsWith('${value.venue}:') ||
        value.settlementAsset.isEmpty) {
      throw const CompatibilityFailure();
    }
    return Hip3PublicMarket(
      productId: value.productId,
      venue: value.venue,
      environment: value.environment.name,
      settlementAsset: value.settlementAsset,
      tradable: value.tradable,
      unavailableReason: value.unavailableReason,
    );
  }

  String _network(api.ProductKind kind, Hip3PublicMarket? market) =>
      kind == api.ProductKind.bstock
      ? 'BSC'
      : market == null
      ? 'Hyperliquid'
      : 'Hyperliquid · ${market.environment}';

  void _validateBinding(MarketProductRef ref, Hip3PublicMarket? market) {
    if ((ref.productId != null && ref.productId != market?.productId) ||
        (ref.environment != null && ref.environment != market?.environment)) {
      throw const CompatibilityFailure();
    }
  }

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
