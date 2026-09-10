import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/domain_page.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/order.dart';
import '../../domain/models/order_intent.dart';
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
    _requireHip3Position(position);
    var current = position;
    final clearScope = _clearScope(
      current,
      takeProfit: takeProfit,
      stopLoss: stopLoss,
    );
    if (clearScope != null) {
      current = mapPosition(
        await _service.clearTpSl(
          api.Hip3ClearTpSlActionRequest(
            (request) => request
              ..operation =
                  api.Hip3ClearTpSlActionRequestOperationEnum.clearTpsl
              ..positionId = current.positionId
              ..positionVersion = _positionVersion(current)
              ..scope = clearScope,
          ),
          idempotencyKey: '$idempotencyKey-clear',
        ),
      );
    }
    if (takeProfit == null && stopLoss == null) return current;
    return mapPosition(
      await _service.updateTpSl(
        api.Hip3SetTpSlActionRequest(
          (request) => request
            ..operation = api.Hip3SetTpSlActionRequestOperationEnum.setTpsl
            ..positionId = current.positionId
            ..positionVersion = _positionVersion(current)
            ..protection = _protection(
              takeProfit: takeProfit,
              stopLoss: stopLoss,
              stopLimit: stopLimit,
            ).toBuilder(),
        ),
        idempotencyKey: '$idempotencyKey-set',
      ),
    );
  }

  @override
  Future<Position> clearTpSl(
    String positionId, {
    required String idempotencyKey,
  }) async {
    final position = mapPosition(await _service.getPosition(positionId));
    _requireHip3Position(position);
    return mapPosition(
      await _service.clearTpSl(
        api.Hip3ClearTpSlActionRequest(
          (request) => request
            ..operation = api.Hip3ClearTpSlActionRequestOperationEnum.clearTpsl
            ..positionId = position.positionId
            ..positionVersion = _positionVersion(position)
            ..scope = api.Hip3ClearTpSlActionRequestScopeEnum.both,
        ),
        idempotencyKey: idempotencyKey,
      ),
    );
  }

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
    final productId = position.productId;
    final marginMode = position.marginMode;
    if (productId == null || marginMode == null) {
      throw StateError('HIP3 position is missing product trading context');
    }
    final context = await _service.getHip3TradingContext(productId);
    return mapPosition(
      await _service.updateLeverage(
        position.positionId,
        api.Hip3SetLeverageActionRequest(
          (request) => request
            ..operation =
                api.Hip3SetLeverageActionRequestOperationEnum.setLeverage
            ..contextId = context.contextId
            ..leverage = leverage
            ..marginMode = marginMode == TradingMarginMode.isolated
                ? api.MarginMode.isolated
                : api.MarginMode.cross,
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
      api.Hip3ClosePreviewRequest(
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

  void _requireHip3Position(Position position) {
    if (position.kind != MarketProductKind.perp) {
      throw ArgumentError('Only perpetual positions support HIP3 actions');
    }
    _positionVersion(position);
  }

  String _positionVersion(Position position) {
    final version = position.positionVersion;
    if (version == null || version.isEmpty) {
      throw StateError('HIP3 position is missing its server version');
    }
    return version;
  }

  api.Hip3ClearTpSlActionRequestScopeEnum? _clearScope(
    Position current, {
    required String? takeProfit,
    required String? stopLoss,
  }) {
    final clearTakeProfit =
        takeProfit == null && current.takeProfitPrice != null;
    final clearStopLoss = stopLoss == null && current.stopLossPrice != null;
    return switch ((clearTakeProfit, clearStopLoss)) {
      (true, true) => api.Hip3ClearTpSlActionRequestScopeEnum.both,
      (true, false) => api.Hip3ClearTpSlActionRequestScopeEnum.takeProfit,
      (false, true) => api.Hip3ClearTpSlActionRequestScopeEnum.stopLoss,
      (false, false) => null,
    };
  }

  api.Hip3ProtectionSpec _protection({
    required String? takeProfit,
    required String? stopLoss,
    required String? stopLimit,
  }) => api.Hip3ProtectionSpec(
    (builder) => builder
      ..sizeMode = api.Hip3ProtectionSpecSizeModeEnum.entirePosition
      ..takeProfit = takeProfit == null
          ? null
          : _trigger(takeProfit).toBuilder()
      ..stopLoss = stopLoss == null
          ? null
          : _trigger(stopLoss, limitPrice: stopLimit).toBuilder(),
  );

  api.Hip3TriggerSpec _trigger(String price, {String? limitPrice}) =>
      api.Hip3TriggerSpec(
        (builder) => builder
          ..triggerPrice = price
          ..triggerReference = api.Hip3TriggerSpecTriggerReferenceEnum.mark
          ..executionType = limitPrice == null
              ? api.Hip3TriggerSpecExecutionTypeEnum.market
              : api.Hip3TriggerSpecExecutionTypeEnum.limit
          ..limitPrice = limitPrice,
      );
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
