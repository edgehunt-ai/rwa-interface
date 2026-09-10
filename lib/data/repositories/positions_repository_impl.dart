import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/domain_page.dart';
import '../services/hip3_action_binding.dart';
import '../services/hip3_position_action_executor.dart';
import '../services/hip3_position_action_service.dart';
import '../services/hip3_position_intents.dart';
import '../services/hip3_preparation_cache.dart';
import '../services/hip3_step_confirmation_mapper.dart';
import '../../domain/models/hip3_step_confirmation.dart';
import '../../domain/models/hip3_action_summary.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/order.dart';
import '../../domain/models/position.dart';
import '../../domain/repositories/positions_repository.dart';
import '../services/positions_service.dart';
import 'orders_repository_impl.dart';
import 'portfolio_repository_impl.dart';

final class PositionsRepositoryImpl implements PositionsRepository {
  PositionsRepositoryImpl(
    this._service, {
    required this._actions,
    required this._executor,
    required this._confirm,
  });
  final Hip3PositionActionService _actions;
  final Hip3PositionActionExecutor _executor;
  final Future<bool> Function(Hip3StepConfirmation) _confirm;
  final PositionsService _service;
  final Hip3PreparationCache _preparations = Hip3PreparationCache();

  @override
  Future<DomainPage<Hip3ActionSummary>> activeHip3Actions({
    String? cursor,
  }) async {
    final page = await _actions.active(cursor: cursor);
    return DomainPage(
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
      items: page.items
          .map(
            (action) => Hip3ActionSummary(
              actionId: action.actionId,
              productId: action.productId,
              operation: action.operation.name,
              status: action.status.name,
              positionId: action.positionId,
              orderId: action.orderId,
              effectsApplied: action.effectsApplied,
              canResumePositionAction:
                  action.environment == api.Hip3Environment.testnet &&
                  const [
                    api.Hip3Operation.setTpsl,
                    api.Hip3Operation.clearTpsl,
                    api.Hip3Operation.setLeverage,
                    api.Hip3Operation.closePosition,
                  ].contains(action.operation) &&
                  const [
                    api.Hip3ActionStatus.awaitingSignature,
                    api.Hip3ActionStatus.submitting,
                    api.Hip3ActionStatus.reconciling,
                    api.Hip3ActionStatus.ambiguous,
                  ].contains(action.status),
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<void> resumeHip3Action(String actionId) async {
    final action = await _actions.get(actionId);
    final intent = action.intent.oneOf.value;
    final matches = switch (intent) {
      api.Hip3SetTpSlActionRequest value =>
        action.operation == api.Hip3Operation.setTpsl &&
            action.positionId == value.positionId,
      api.Hip3ClearTpSlActionRequest value =>
        action.operation == api.Hip3Operation.clearTpsl &&
            action.positionId == value.positionId,
      api.Hip3SetLeverageActionRequest _ =>
        action.operation == api.Hip3Operation.setLeverage,
      api.Hip3CloseActionRequest value =>
        action.operation == api.Hip3Operation.closePosition &&
            action.closePreview?.previewId == value.previewId &&
            action.closePreview?.positionId == action.positionId &&
            action.closePreview?.productId == action.productId &&
            action.closePreview?.environment == action.environment,
      _ => false,
    };
    if (!matches ||
        action.environment != api.Hip3Environment.testnet ||
        action.actionId != actionId ||
        action.productId.isEmpty) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    await _executor.resume(
      actionId: actionId,
      binding: Hip3ActionBinding(
        intent: action.intent,
        operation: action.operation,
        productId: action.productId,
        environment: action.environment,
        positionId: action.positionId,
        orderId: action.orderId,
      ),
      confirm: (current, step) =>
          _confirm(mapHip3StepConfirmation(current, step)),
    );
  }

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
    final intent = await _preparations.get(
      idempotencyKey,
      jsonEncode([
        'set_tpsl',
        position.positionId,
        position.productId,
        takeProfit,
        stopLoss,
        stopLimit,
      ]),
      () async => Hip3PositionIntents.setProtection(
        position,
        takeProfit: takeProfit,
        stopLoss: stopLoss,
        stopLimit: stopLimit,
      ),
    );
    await _run(position, intent, api.Hip3Operation.setTpsl, idempotencyKey);
    return get(position.positionId);
  }

  @override
  Future<Position> clearTpSl(
    String positionId, {
    required String idempotencyKey,
  }) async {
    final position = await _preparations.get(
      idempotencyKey,
      jsonEncode(['clear_tpsl', positionId]),
      () => get(positionId),
    );
    await _run(
      position,
      Hip3PositionIntents.clearProtection(position),
      api.Hip3Operation.clearTpsl,
      idempotencyKey,
    );
    return get(positionId);
  }

  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    required String idempotencyKey,
  }) async {
    if (!RegExp(r'^[1-9][0-9]*$').hasMatch(leverage)) {
      throw ArgumentError('Leverage must be a positive integer');
    }
    _requireProduct(position);
    final context = await _preparations.get(
      idempotencyKey,
      jsonEncode([
        'set_leverage',
        position.positionId,
        position.productId,
        leverage,
      ]),
      () => _actions.context(position.productId!),
    );
    if (context.productId != position.productId ||
        context.environment != api.Hip3Environment.testnet) {
      throw const FormatException('Trading context binding mismatch');
    }
    await _run(
      position,
      Hip3PositionIntents.leverage(context, leverage),
      api.Hip3Operation.setLeverage,
      idempotencyKey,
      bindPosition: false,
    );
    return get(position.positionId);
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
    final (position, preview) = await _preparations.get(
      idempotencyKey,
      jsonEncode([
        'close_position',
        positionId,
        quantity,
        percent ?? (quantity == null ? '100' : null),
      ]),
      () async {
        final position = await get(positionId);
        _requireProduct(position);
        final preview = await _actions.previewClose(
          positionId,
          api.Hip3ClosePreviewRequest(
            (b) => b
              ..type = api.Hip3ClosePreviewRequestTypeEnum.market
              ..quantity = quantity
              ..percent = percent ?? (quantity == null ? '100' : null),
          ),
          '$idempotencyKey-preview',
        );
        return (position, preview);
      },
    );
    if (preview.positionId != positionId ||
        preview.productId != position.productId ||
        preview.environment != api.Hip3Environment.testnet) {
      throw const FormatException('Close preview binding mismatch');
    }
    final completed = await _run(
      position,
      Hip3PositionIntents.close(preview.previewId),
      api.Hip3Operation.closePosition,
      idempotencyKey,
    );
    final orderId = completed.orderId;
    if (orderId == null) {
      throw const FormatException('Close action missing order');
    }
    return mapOrder(await _actions.order(orderId));
  }

  Future<api.Hip3Action> _run(
    Position position,
    api.Hip3ActionCreateRequest intent,
    api.Hip3Operation operation,
    String key, {
    bool bindPosition = true,
  }) async {
    _requireProduct(position);
    final binding = Hip3ActionBinding(
      intent: intent,
      operation: operation,
      productId: position.productId!,
      environment: api.Hip3Environment.testnet,
      positionId: bindPosition ? position.positionId : null,
    );
    final created = await _actions.create(intent, key);
    binding.validate(created);
    return _executor.resume(
      actionId: created.actionId,
      binding: binding,
      confirm: (action, step) =>
          _confirm(mapHip3StepConfirmation(action, step)),
    );
  }

  void _requireProduct(Position position) {
    if (position.kind != MarketProductKind.perp ||
        position.productId == null ||
        position.productId!.isEmpty) {
      throw ArgumentError('HIP3 product is required');
    }
  }

  api.ProductKind? _kind(MarketProductKind? value) => switch (value) {
    MarketProductKind.bstock => api.ProductKind.bstock,
    MarketProductKind.perp => api.ProductKind.perp,
    null => null,
  };
}
