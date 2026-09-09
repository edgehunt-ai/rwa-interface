import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/domain_page.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/order.dart';
import '../../domain/models/position.dart';
import '../../domain/repositories/positions_repository.dart';
import '../services/positions_service.dart';
import 'orders_repository_impl.dart';
import 'portfolio_repository_impl.dart';

final class PositionsRepositoryImpl implements PositionsRepository {
  PositionsRepositoryImpl(this._service);
  final PositionsService _service;
  @override
  Future<DomainPage<Position>> list({
    String? symbol,
    MarketProductKind? kind,
    String? cursor,
  }) async {
    final page = await _service.listPositions(
      symbol: symbol,
      kind: _kind(kind),
      cursor: cursor,
    );
    return DomainPage(
      items: page.items.map(mapPosition).toList(),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<Position> get(String positionId) async =>
      mapPosition(await _service.getPosition(positionId));
  @override
  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? stopLoss,
    String? stopLimit,
    required String idempotencyKey,
  }) async {
    _validateDirection(position, takeProfit: takeProfit, stopLoss: stopLoss);
    final request = api.TpSlUpdateRequest(
      (builder) => builder
        ..takeProfitPrice = takeProfit
        ..stopLossPrice = stopLoss
        ..stopLimitPrice = stopLimit,
    );
    return mapPosition(
      await _service.updateTpSl(
        position.positionId,
        request,
        idempotencyKey: idempotencyKey,
      ),
    );
  }

  @override
  Future<Position> clearTpSl(
    String positionId, {
    required String idempotencyKey,
  }) async => mapPosition(
    await _service.clearTpSl(positionId, idempotencyKey: idempotencyKey),
  );
  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    required String idempotencyKey,
  }) async {
    if (position.kind != MarketProductKind.perp) {
      throw ArgumentError('Only perpetual positions have leverage');
    }
    final parsed = DecimalValue(leverage, unit: 'leverage');
    if (parsed.compareTo(DecimalValue('1', unit: 'leverage')) < 0 ||
        parsed.compareTo(DecimalValue('50', unit: 'leverage')) > 0) {
      throw ArgumentError('Leverage must be between 1 and 50');
    }
    return mapPosition(
      await _service.updateLeverage(
        position.positionId,
        api.UpdatePositionLeverageRequest(
          (builder) => builder.leverage = leverage,
        ),
        idempotencyKey: idempotencyKey,
      ),
    );
  }

  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    required String idempotencyKey,
  }) async {
    if (quantity != null && percent != null) {
      throw ArgumentError('Quantity and percent are mutually exclusive');
    }
    final value = await _service.closePosition(
      positionId,
      api.ClosePositionRequest(
        (builder) => builder
          ..quantity = quantity
          ..percent = percent,
      ),
      idempotencyKey: idempotencyKey,
    );
    return mapOrder(value);
  }

  api.ProductKind? _kind(MarketProductKind? value) => switch (value) {
    MarketProductKind.bstock => api.ProductKind.bstock,
    MarketProductKind.perp => api.ProductKind.perp,
    null => null,
  };
  void _validateDirection(
    Position position, {
    String? takeProfit,
    String? stopLoss,
  }) {
    final entry = position.entryPrice;
    if (entry == null || position.side == PositionSide.none) return;
    final take = takeProfit == null
        ? null
        : DecimalValue(takeProfit, asset: entry.asset, unit: entry.unit);
    final stop = stopLoss == null
        ? null
        : DecimalValue(stopLoss, asset: entry.asset, unit: entry.unit);
    if (position.side == PositionSide.long &&
            ((take != null && take.compareTo(entry) <= 0) ||
                (stop != null && stop.compareTo(entry) >= 0)) ||
        position.side == PositionSide.short &&
            ((take != null && take.compareTo(entry) >= 0) ||
                (stop != null && stop.compareTo(entry) <= 0))) {
      throw ArgumentError('TP/SL prices conflict with position direction');
    }
  }
}
