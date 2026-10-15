import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/domain_page.dart';
import '../api/idempotency_key.dart';
import '../services/hip3_action_binding.dart';
import '../services/hip3_position_action_executor.dart';
import '../services/hip3_position_action_service.dart';
import '../services/hip3_position_intents.dart';
import '../services/hip3_preparation_cache.dart';
import '../services/hip3_step_confirmation_mapper.dart';
import '../../domain/models/hip3_step_confirmation.dart';
import '../../domain/models/hip3_action_summary.dart';
import '../../domain/models/hip3_action_pending.dart';
import '../../domain/models/hip3_protection.dart';
import '../services/hip3_action_mapper.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/order.dart';
import '../../domain/models/position.dart';
import '../../domain/models/position_leverage_context.dart';
import '../../domain/models/position_close_preview.dart';
import '../../domain/models/position_operation.dart';
import '../../domain/models/decimal_value.dart';
import '../../domain/models/order_intent.dart';
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
  Future<int> sizeDecimals(String productId) async {
    final context = await _actions.context(productId);
    if (context.productId != productId) {
      throw const FormatException('Trading context binding mismatch');
    }
    return context.rules.sizeDecimals;
  }

  @override
  Future<PositionLeverageContext> leverageContext(String productId) async {
    final context = await _actions.context(productId);
    if (context.productId != productId) {
      throw const FormatException('Trading context binding mismatch');
    }
    final mode = switch (context.currentMarginMode) {
      api.MarginMode.cross => PositionMarginMode.cross,
      api.MarginMode.isolated => PositionMarginMode.isolated,
      _ => null,
    };
    final modes = context.rules.marginModes
        .map(
          (value) => switch (value) {
            api.MarginMode.cross => PositionMarginMode.cross,
            api.MarginMode.isolated => PositionMarginMode.isolated,
            _ => null,
          },
        )
        .whereType<PositionMarginMode>()
        .toSet();
    return PositionLeverageContext(
      productId: productId,
      maximum: DecimalValue(context.rules.maxLeverage),
      current: context.currentLeverage == null
          ? null
          : DecimalValue(context.currentLeverage!),
      marginMode: mode,
      marginModes: Set.unmodifiable(modes),
      validUntil: context.validUntil.toUtc(),
      canChange:
          mode != null &&
          context.supportedOperations.contains(api.Hip3Operation.setLeverage) &&
          context.blocker == null,
    );
  }

  @override
  Future<DomainPage<Hip3ActionSummary>> activeHip3Actions({
    String? cursor,
  }) async {
    final page = await _actions.active(cursor: cursor);
    return DomainPage(
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
      items: page.items.map(mapHip3ActionSummary).toList(growable: false),
    );
  }

  @override
  Future<void> resumeHip3Action(String actionId) async {
    final action = await _actions.get(actionId);
    final request = hip3CurrentIntent(action);
    final intent = request.oneOf.value;
    final matches = switch (intent) {
      api.Hip3ManageTpSlActionRequest value =>
        action.operation == 'manage_tpsl' &&
            action.positionId == value.positionId,
      api.Hip3SetLeverageActionRequest _ => action.operation == 'set_leverage',
      api.Hip3CloseActionRequest value =>
        action.operation == 'close_position' &&
            action.closePreview?.previewId == value.previewId &&
            action.closePreview?.positionId == action.positionId &&
            action.closePreview?.productId == action.productId &&
            action.closePreview?.environment == action.environment,
      _ => false,
    };
    if (!matches || action.actionId != actionId || action.productId.isEmpty) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    await _executor.resume(
      actionId: actionId,
      binding: Hip3ActionBinding(
        intent: request,
        operation: api.standardSerializers.deserializeWith(
          api.Hip3Operation.serializer,
          action.operation,
        )!,
        productId: action.productId,
        environment: action.environment,
        positionId: action.positionId,
        orderId: action.orderId,
      ),
      confirm: (_, _) async => true,
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
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
    ProtectionClearScope? clearScope,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async {
    final changes = <Hip3ProtectionChange>[];
    if (clearScope != null) {
      final existing = await _protectionOrders(position);
      for (final order in existing) {
        if (clearScope == ProtectionClearScope.both ||
            (clearScope == ProtectionClearScope.takeProfit &&
                order.protection.role == 'takeProfit') ||
            (clearScope == ProtectionClearScope.stopLoss &&
                order.protection.role == 'stopLoss')) {
          changes.add(Hip3ProtectionChange.cancel(order.orderId));
        }
      }
    }
    for (final (role, trigger, limit) in [
      ('takeProfit', takeProfit, takeLimit),
      ('stopLoss', stopLoss, stopLimit),
    ]) {
      if (trigger == null) {
        if (limit != null) throw ArgumentError('A limit requires its trigger');
        continue;
      }
      changes.add(
        Hip3ProtectionChange.create(
          Hip3ProtectionParameters(
            role: role,
            triggerPrice: DecimalValue(trigger),
            limitPrice: limit == null ? null : DecimalValue(limit),
            quantity: quantity == null ? null : DecimalValue(quantity),
          ),
        ),
      );
    }
    final result = await _manageTpSl(
      position,
      changes,
      idempotencyKey,
      confirmBeforeSigning: confirmBeforeSigning,
    );
    _requireProtectionSuccess(result);
    return get(position.positionId);
  }

  @override
  Future<Position> clearTpSl(
    String positionId, {
    ProtectionClearScope scope = ProtectionClearScope.both,
    required String idempotencyKey,
  }) async {
    final position = await _preparations.get(
      '$idempotencyKey-position',
      jsonEncode([positionId, scope.name]),
      () => get(positionId),
    );
    final orders = await _protectionOrders(position);
    final changes = [
      for (final order in orders)
        if (scope == ProtectionClearScope.both ||
            (scope == ProtectionClearScope.takeProfit &&
                order.protection.role == 'takeProfit') ||
            (scope == ProtectionClearScope.stopLoss &&
                order.protection.role == 'stopLoss'))
          Hip3ProtectionChange.cancel(order.orderId),
    ];
    final result = await _manageTpSl(position, changes, idempotencyKey);
    _requireProtectionSuccess(result);
    return get(positionId);
  }

  Future<List<Hip3PositionProtectionOrder>> _protectionOrders(
    Position position,
  ) async {
    if (position.protectionOrders.isNotEmpty) return position.protectionOrders;
    return Future.wait(
      position.protectionOrderIds.map((id) async {
        final order = mapOrder(await _actions.order(id));
        final leg = order.conditional;
        if (order.positionId != position.positionId ||
            order.productId != position.productId ||
            leg == null) {
          throw const FormatException('Protection order binding mismatch');
        }
        return Hip3PositionProtectionOrder(
          orderId: id,
          protection: Hip3ProtectionParameters(
            role: leg.role,
            triggerPrice: leg.triggerPrice,
            quantity: leg.sizeMode == 'entirePosition'
                ? null
                : DecimalValue(leg.quantity),
            limitPrice: leg.executionType == 'limit' ? order.limitPrice : null,
          ),
        );
      }),
    );
  }

  @override
  Future<Hip3ActionSummary> hip3Action(String actionId) async {
    final action = await _actions.get(actionId);
    if (action.actionId != actionId) {
      throw const FormatException('Action binding mismatch');
    }
    return mapHip3ActionSummary(action);
  }

  @override
  Future<Hip3ActionSummary> manageTpSl(
    Position position, {
    required List<Hip3ProtectionChange> changes,
    required String idempotencyKey,
    bool confirmBeforeSigning = true,
  }) => _manageTpSl(
    position,
    changes,
    idempotencyKey,
    confirmBeforeSigning: confirmBeforeSigning,
  );

  Future<Hip3ActionSummary> _manageTpSl(
    Position position,
    List<Hip3ProtectionChange> changes,
    String key, {
    bool confirmBeforeSigning = true,
  }) async {
    final request = Hip3PositionIntents.manageProtection(position, changes);
    if (changes.any((change) => change.orderId != null)) {
      final existing = await _protectionOrders(position);
      for (final change in changes.where((change) => change.orderId != null)) {
        final targets = existing.where(
          (order) => order.orderId == change.orderId,
        );
        if (targets.length != 1 ||
            (change.protection != null &&
                targets.single.protection.role != change.protection!.role)) {
          throw const FormatException(
            'Protection order binding or role mismatch',
          );
        }
      }
    }
    final frozen = await _preparations.get(
      key,
      jsonEncode(
        api.standardSerializers.serializeWith(
          api.Hip3ActionCreateRequest.serializer,
          request,
        ),
      ),
      () async => request,
    );
    api.Hip3Action? latest;
    try {
      final completed = await _run(
        position,
        frozen,
        api.Hip3Operation.manageTpsl,
        key,
        confirmBeforeSigning: confirmBeforeSigning,
        onUpdate: (value) => latest = value,
      );
      return mapHip3ActionSummary(completed);
    } on Hip3ActionPending {
      if (latest == null) rethrow;
      return mapHip3ActionSummary(latest!);
    } on Hip3SigningFailure {
      if (latest == null ||
          !const {
            'failed',
            'cancelled',
            'expired',
          }.contains(latest!.status.name)) {
        rethrow;
      }
      final result = mapHip3ActionSummary(latest!);
      if (result.protectionOrders.isEmpty) rethrow;
      return result;
    }
  }

  void _requireProtectionSuccess(Hip3ActionSummary result) {
    if (result.isSuccessful) return;
    if (const {'failed', 'cancelled', 'expired'}.contains(result.status)) {
      throw Hip3SigningFailure(
        Hip3SigningFailureCode.invalidPayload,
        reason: result.failureReason,
        failureCode: result.failureCode,
      );
    }
    throw Hip3ActionPending(
      result.actionId,
      requiresReview: result.status == 'manualReview',
    );
  }

  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    PositionMarginMode? marginMode,
    bool confirmBeforeSigning = true,
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
        marginMode?.name,
      ]),
      () => _actions.context(position.productId!),
    );
    if (context.productId != position.productId) {
      throw const FormatException('Trading context binding mismatch');
    }
    await _run(
      position,
      Hip3PositionIntents.leverage(context, leverage, marginMode: marginMode),
      api.Hip3Operation.setLeverage,
      idempotencyKey,
      bindPosition: false,
      environment: context.environment,
      confirmBeforeSigning: confirmBeforeSigning,
    );
    return get(position.positionId);
  }

  @override
  Future<PositionClosePreview> previewClose(
    Position position, {
    required String quantity,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    required String idempotencyKey,
  }) async {
    _requireProduct(position);
    if (position.side == PositionSide.none) {
      throw ArgumentError('No open position');
    }
    requireWithinPosition(quantity, position.quantity.value);
    if (type == TradingOrderType.limit) {
      if (limitPrice == null) throw ArgumentError('Limit price is required');
      requirePositiveDecimal(limitPrice);
    } else if (limitPrice != null) {
      throw ArgumentError('Market close must not include a limit price');
    }
    final preview = await _actions.previewClose(
      position.positionId,
      api.Hip3ClosePreviewRequest(
        (b) => b
          ..type = type == TradingOrderType.limit
              ? api.Hip3ClosePreviewRequestTypeEnum.limit
              : api.Hip3ClosePreviewRequestTypeEnum.market
          ..quantity = quantity
          ..limitPrice = limitPrice,
      ),
      idempotencyKey,
    );
    final mapped = _mapClosePreview(preview);
    _validateClosePreview(mapped, position, type, quantity, limitPrice);
    return mapped;
  }

  PositionClosePreview _mapClosePreview(api.Hip3ClosePreview preview) {
    return PositionClosePreview(
      previewId: preview.previewId,
      positionId: preview.positionId,
      productId: preview.productId,
      positionVersion: preview.positionVersion,
      environment: preview.environment.name,
      side: preview.side.name == 'long'
          ? PositionSide.long
          : PositionSide.short,
      type: preview.type.name == 'limit'
          ? TradingOrderType.limit
          : TradingOrderType.market,
      quantity: DecimalValue(preview.quantity),
      notional: DecimalValue(preview.notionalUsdc),
      entryPrice: DecimalValue(preview.entryPrice),
      markPrice: DecimalValue(preview.markPrice),
      estimatedPrice: DecimalValue(preview.estimatedPrice),
      estimatedFee: DecimalValue(preview.estimatedFeeUsdc),
      estimatedRealizedPnl: DecimalValue(preview.estimatedRealizedPnlUsdc),
      limitPrice: preview.limitPrice == null
          ? null
          : DecimalValue(preview.limitPrice!),
      liquidationPrice: preview.liquidationPrice == null
          ? null
          : DecimalValue(preview.liquidationPrice!),
      expiresAt: preview.quoteExpiresAt.toUtc(),
      observedAt: preview.observedAt.toUtc(),
    );
  }

  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    PositionClosePreview? preview,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async {
    if (quantity != null && percent != null) {
      throw ArgumentError('Quantity and percent are mutually exclusive');
    }
    if (type == TradingOrderType.limit) {
      if (limitPrice == null) throw ArgumentError('Limit price is required');
      requirePositiveDecimal(limitPrice);
    } else if (limitPrice != null) {
      throw ArgumentError('Market close must not include a limit price');
    }
    if (percent != null) requireWithinPosition(percent, '100');
    if (quantity != null) requirePositiveDecimal(quantity);
    final (position, preparedPreview) = await _preparations.get(
      idempotencyKey,
      jsonEncode([
        'close_position',
        positionId,
        quantity,
        percent ?? (quantity == null ? '100' : null),
        type.name,
        limitPrice,
        expectedPosition?.productId,
        expectedPosition?.positionVersion,
        expectedPosition?.side.name,
        expectedPosition?.quantity.value,
        preview?.previewId,
      ]),
      () async {
        final position = await get(positionId);
        _requireProduct(position);
        if (position.side == PositionSide.none ||
            (expectedPosition != null &&
                (expectedPosition.positionId != positionId ||
                    expectedPosition.productId != position.productId ||
                    expectedPosition.positionVersion !=
                        position.positionVersion ||
                    expectedPosition.side != position.side ||
                    expectedPosition.quantity.value !=
                        position.quantity.value))) {
          throw const FormatException(
            'Position changed; refresh before closing',
          );
        }
        if (quantity != null) {
          requireWithinPosition(quantity, position.quantity.value);
        }
        final acceptedPreview = preview;
        if (acceptedPreview != null) return (position, acceptedPreview);
        final generatedPreview = await _actions.previewClose(
          positionId,
          api.Hip3ClosePreviewRequest(
            (b) => b
              ..type = type == TradingOrderType.limit
                  ? api.Hip3ClosePreviewRequestTypeEnum.limit
                  : api.Hip3ClosePreviewRequestTypeEnum.market
              ..limitPrice = limitPrice
              ..quantity = quantity
              ..percent = percent ?? (quantity == null ? '100' : null),
          ),
          scopedIdempotencyKey('$idempotencyKey-preview'),
        );
        return (position, _mapClosePreview(generatedPreview));
      },
    );
    _validateClosePreview(
      preparedPreview,
      position,
      type,
      quantity ?? percentageQuantity(position.quantity.value, percent ?? '100'),
      limitPrice,
    );
    final completed = await _run(
      position,
      Hip3PositionIntents.close(preparedPreview.previewId),
      api.Hip3Operation.closePosition,
      idempotencyKey,
      environment: _closePreviewEnvironment(preparedPreview.environment),
      confirmBeforeSigning: confirmBeforeSigning,
    );
    final orderId = completed.orderId;
    if (orderId == null) {
      throw const FormatException('Close action missing order');
    }
    return mapOrder(await _actions.order(orderId));
  }

  void _validateClosePreview(
    PositionClosePreview preview,
    Position position,
    TradingOrderType type,
    String maximumQuantity,
    String? limitPrice,
  ) {
    if (preview.isExpired ||
        preview.positionId != position.positionId ||
        preview.productId != position.productId ||
        preview.positionVersion != position.positionVersion ||
        preview.type != type ||
        preview.side !=
            (position.side == PositionSide.long
                ? PositionSide.short
                : PositionSide.long) ||
        (type == TradingOrderType.limit && preview.limitPrice == null)) {
      throw const FormatException('Close preview binding mismatch');
    }
    requireWithinPosition(preview.quantity.value, maximumQuantity);
    if (limitPrice != null) {
      requirePositiveDecimal(preview.limitPrice!.value);
      final comparison = preview.limitPrice!.compareTo(
        DecimalValue(limitPrice),
      );
      if ((position.side == PositionSide.long && comparison < 0) ||
          (position.side == PositionSide.short && comparison > 0)) {
        throw const FormatException(
          'Close preview exceeds the requested limit',
        );
      }
    }
  }

  api.Hip3Environment _closePreviewEnvironment(String environment) {
    try {
      return api.Hip3Environment.valueOf(environment);
    } on ArgumentError {
      throw const FormatException('Close preview binding mismatch');
    }
  }

  Future<api.Hip3Action> _run(
    Position position,
    api.Hip3ActionCreateRequest intent,
    api.Hip3Operation operation,
    String key, {
    bool bindPosition = true,
    api.Hip3Environment? environment,
    bool confirmBeforeSigning = true,
    void Function(api.Hip3Action)? onUpdate,
  }) async {
    _requireProduct(position);
    final binding = Hip3ActionBinding(
      intent: intent,
      operation: operation,
      productId: position.productId!,
      environment: environment,
      positionId: bindPosition ? position.positionId : null,
    );
    final created = await _actions.create(intent, key);
    binding.validate(created);
    onUpdate?.call(created);
    return _executor.resume(
      actionId: created.actionId,
      binding: binding,
      onUpdate: onUpdate,
      confirm: confirmBeforeSigning
          ? (action, step) => _confirm(mapHip3StepConfirmation(action, step))
          : (_, _) async => true,
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
