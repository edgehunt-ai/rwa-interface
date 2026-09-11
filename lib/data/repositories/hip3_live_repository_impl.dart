import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/hip3_live.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/market_snapshot.dart';
import '../../domain/models/order.dart';
import '../../domain/models/position.dart';
import '../../domain/repositories/hip3_live_repository.dart';
import '../api/hip3_realtime_state.dart';
import '../services/realtime_service.dart';
import 'orders_repository_impl.dart';
import 'portfolio_repository_impl.dart';

/// Reuses the authenticated transport and REST resource mappers. No requests,
/// generated models or mutable wire maps escape this repository.
final class Hip3LiveRepositoryImpl implements Hip3LiveRepository {
  Hip3LiveRepositoryImpl(this._service);
  final RealtimeService _service;

  @override
  Stream<Hip3LiveUpdate> subscribe(Hip3LiveQuery query) async* {
    final accumulator = Hip3RealtimeAccumulator(
      Hip3RealtimeScope(
        signer: query.signer,
        environment: query.environment,
        channels: query.channels,
      ),
    );
    await for (final event in _service.subscribe(channels: query.channels)) {
      try {
        if (!accumulator.apply(event)) continue;
        final state = accumulator.state;
        if (state == null) {
          yield const Hip3LiveResync();
          return;
        }
        yield _map(query, state);
      } on ApiFailure {
        rethrow;
      } catch (_) {
        throw const CompatibilityFailure();
      }
    }
    // Clean transport termination still means live data is no longer updating.
    throw const NetworkFailure();
  }

  Hip3LiveSnapshot _map(Hip3LiveQuery query, Hip3RealtimeState state) {
    final orders = <String, TradingOrder>{};
    final positions = <String, Position>{};
    final prices = <Hip3LiveMarketKey, Hip3LivePrice>{};
    final candles = <Hip3LiveCandleKey, Hip3LiveCandle>{};
    Hip3LiveBalance? balance;
    for (final resource in state.resources.values) {
      final data = resource.data;
      switch (resource.kind) {
        case 'hip3_order':
          final order = mapOrder(
            _required(
              api.standardSerializers.deserializeWith(
                api.Order.serializer,
                data,
              ),
            ),
          );
          orders[order.orderId] = order;
        case 'hip3_position':
          final position = mapPosition(
            _required(
              api.standardSerializers.deserializeWith(
                api.Position.serializer,
                data,
              ),
            ),
          );
          positions[position.positionId] = position;
        case 'hip3_price':
          final value = _required(
            api.standardSerializers.deserializeWith(
              api.Hip3RealtimePrice.serializer,
              data,
            ),
          );
          final market = _market(value);
          if (value.priceLabel !=
              api.Hip3RealtimePricePriceLabelEnum.markPrice) {
            throw const CompatibilityFailure();
          }
          prices[(
            productId: market.productId,
            environment: market.environment,
          )] = Hip3LivePrice(
            source: value.source_,
            quote: MarketSnapshot(
              price: DecimalValue(
                value.price,
                asset: market.settlementAsset,
                unit: 'price',
              ),
              change24hPercent: DecimalValue(
                value.change24hPercent,
                unit: 'percent',
              ),
              hip3Market: market,
              priceKind: 'mark',
              quoteLabel: 'Mark price',
              asOf: value.updatedAt.toUtc(),
              validUntil: value.freshUntil.toUtc(),
            ),
          );
        case 'hip3_candle':
          final value = _required(
            api.standardSerializers.deserializeWith(
              api.Hip3RealtimeCandle.serializer,
              data,
            ),
          );
          final market = _market(value);
          final point = value.point;
          final interval = switch (value.interval) {
            api.RealtimeCandleUpdateIntervalEnum.n1m => '1m',
            api.RealtimeCandleUpdateIntervalEnum.n5m => '5m',
            api.RealtimeCandleUpdateIntervalEnum.n15m => '15m',
            api.RealtimeCandleUpdateIntervalEnum.n1h => '1h',
            api.RealtimeCandleUpdateIntervalEnum.n4h => '4h',
            api.RealtimeCandleUpdateIntervalEnum.n1d => '1d',
            _ => throw const CompatibilityFailure(),
          };
          final candle = Candle(
            at: point.t.toUtc(),
            open: _optional(point.o, 'price', asset: market.settlementAsset),
            high: _optional(point.h, 'price', asset: market.settlementAsset),
            low: _optional(point.l, 'price', asset: market.settlementAsset),
            close: DecimalValue(
              point.c,
              asset: market.settlementAsset,
              unit: 'price',
            ),
            volume: _optional(point.v, 'volume'),
          );
          candles[(
            productId: market.productId,
            environment: market.environment,
            interval: interval,
            at: candle.at,
          )] = Hip3LiveCandle(
            market: market,
            interval: interval,
            point: candle,
            closed: value.closed,
            source: value.source_,
            observedAt: value.updatedAt.toUtc(),
            freshUntil: value.freshUntil.toUtc(),
          );
        case 'hip3_balance':
          final value = _required(
            api.standardSerializers.deserializeWith(
              api.Hip3RealtimeBalance.serializer,
              data,
            ),
          );
          balance = Hip3LiveBalance(
            signer: value.signer.toLowerCase(),
            environment: value.environment.name,
            summary: mapPortfolioSummary(value.summary),
            assets: value.assets.map(_asset).toList(),
          );
        default:
          throw const CompatibilityFailure();
      }
    }
    return Hip3LiveSnapshot(
      query: query,
      cursor: state.cursor,
      completedAt: state.completedAt,
      emittedAt: state.emittedAt,
      orders: orders,
      positions: positions,
      prices: prices,
      candles: candles,
      balance: balance,
    );
  }

  static T _required<T>(T? value) =>
      value ?? (throw const CompatibilityFailure());

  static Hip3PublicMarket _market(api.Hip3PublicMarket value) =>
      Hip3PublicMarket(
        productId: value.productId,
        venue: value.venue,
        environment: value.environment.name,
        settlementAsset: value.settlementAsset,
        tradable: value.tradable,
        unavailableReason: value.unavailableReason,
      );

  static DecimalValue? _optional(String? value, String unit, {String? asset}) =>
      value == null ? null : DecimalValue(value, unit: unit, asset: asset);

  static Hip3LiveAsset _asset(api.PortfolioAsset value) => Hip3LiveAsset(
    assetId: value.assetId,
    source: value.source_.name,
    network: value.network.name,
    symbol: value.symbol,
    decimals: value.decimals,
    balanceRaw: value.balanceRaw,
    balance: DecimalValue(value.balance, asset: value.symbol, unit: 'token'),
    native: value.native_,
    pricingSource: value.pricingSource.name,
    freshness: value.freshness.name,
    observedAt: value.observedAt.toUtc(),
    warnings: value.warnings.map((w) => w.name).toList(),
    walletId: value.walletId,
    accountRef: value.accountRef,
    contractAddress: value.contractAddress,
    priceUsd: value.priceUsd == null
        ? null
        : DecimalValue(value.priceUsd!, asset: 'USD', unit: 'price'),
    valueUsd: value.valueUsd == null
        ? null
        : DecimalValue(value.valueUsd!, asset: 'USD', unit: 'fiat'),
    blockNumber: value.blockNumber,
    blockHash: value.blockHash,
  );
}
