import 'dart:convert';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/hip3_opening_context.dart';
import '../../domain/models/hip3_step_confirmation.dart';
import '../../domain/models/order_intent.dart';
import '../../domain/repositories/hip3_opening_repository.dart';
import '../services/hip3_action_binding.dart';
import '../services/hip3_position_action_service.dart';
import '../services/hip3_position_action_executor.dart';
import '../services/hip3_preparation_cache.dart';
import '../services/hip3_step_confirmation_mapper.dart';

final class Hip3OpeningRepositoryImpl implements Hip3OpeningRepository {
  Hip3OpeningRepositoryImpl(
    this._service,
    this._executor,
    this._confirm, {
    Future<void> Function(Duration)? delay,
  }) : _delay = delay ?? Future<void>.delayed;
  final Hip3PositionActionService _service;
  final Hip3PositionActionExecutor _executor;
  final Future<bool> Function(Hip3StepConfirmation) _confirm;
  final Future<void> Function(Duration) _delay;
  final _preparations = Hip3PreparationCache();

  @override
  Future<Hip3OpeningContext> context(String productOrSymbol) async {
    final value = await _service.context(productOrSymbol);
    if (productOrSymbol.contains(':')
        ? value.productId != productOrSymbol
        : value.symbol.toUpperCase() != productOrSymbol.toUpperCase()) {
      throw const FormatException(
        'HIP3 context product or environment mismatch',
      );
    }
    return _map(value);
  }

  @override
  Future<Hip3OpeningContext> setLeverage(
    String productId,
    int leverage,
    TradingMarginMode mode, {
    required String idempotencyKey,
    Future<bool> Function(Hip3StepConfirmation confirmation)? confirm,
  }) async {
    final source = await _preparations.get(
      idempotencyKey,
      jsonEncode([productId, leverage, mode.name]),
      () => _service.context(productId),
    );
    final context = _map(source);
    if (context.productId != productId ||
        leverage < 1 ||
        leverage > context.maximumLeverage ||
        !context.marginModes.contains(mode) ||
        !context.operations.contains('setLeverage')) {
      throw const FormatException('Leverage or margin mode is not supported');
    }
    final intent = api.standardSerializers.deserializeWith(
      api.Hip3ActionCreateRequest.serializer,
      {
        'operation': 'set_leverage',
        'context_id': context.contextId,
        'leverage': '$leverage',
        'margin_mode': mode.name,
      },
    );
    if (intent == null) throw const FormatException('Missing leverage intent');
    final binding = Hip3ActionBinding(
      intent: intent,
      operation: api.Hip3Operation.setLeverage,
      productId: productId,
      // The context just read is the authority; the action must not switch
      // networks behind it.
      environment: source.environment,
    );
    final action = await _service.create(intent, idempotencyKey);
    binding.validate(action);
    await _executor.resume(
      actionId: action.actionId,
      binding: binding,
      confirm: (action, step) =>
          (confirm ?? _confirm)(mapHip3StepConfirmation(action, step)),
    );
    // The action may be accepted before the venue context reflects the new
    // settings. Poll the authoritative context while keeping the same action
    // idempotency key instead of treating propagation latency as a failure.
    for (var attempt = 0; attempt < 10; attempt++) {
      final refreshed = await this.context(productId);
      if (refreshed.currentLeverage == leverage &&
          refreshed.currentMarginMode == mode) {
        return refreshed;
      }
      if (attempt < 9) await _delay(const Duration(milliseconds: 500));
    }
    throw const FormatException(
      'Leverage update was accepted but is not yet reflected by the venue',
    );
  }

  Hip3OpeningContext _map(api.Hip3TradingContext value) {
    TradingMarginMode? mode(api.MarginMode? value) => switch (value) {
      api.MarginMode.cross => TradingMarginMode.cross,
      api.MarginMode.isolated => TradingMarginMode.isolated,
      _ => null,
    };
    final maximum = int.tryParse(value.rules.maxLeverage);
    if (maximum == null || maximum < 1) {
      throw const FormatException('Invalid maximum leverage');
    }
    return Hip3OpeningContext(
      contextId: value.contextId,
      productId: value.productId,
      environment: value.environment.name,
      currentLeverage: int.tryParse(value.currentLeverage ?? ''),
      maximumLeverage: maximum,
      currentMarginMode: mode(value.currentMarginMode),
      marginModes: Set.unmodifiable(
        value.rules.marginModes.map(mode).whereType<TradingMarginMode>(),
      ),
      orderTypes: Set.unmodifiable(
        value.rules.orderTypes
            .map(
              (v) => switch (v) {
                api.Hip3TradingRulesOrderTypesEnum.market =>
                  TradingOrderType.market,
                api.Hip3TradingRulesOrderTypesEnum.limit =>
                  TradingOrderType.limit,
                _ => null,
              },
            )
            .whereType<TradingOrderType>(),
      ),
      timeInForce: Set.unmodifiable(value.rules.timeInForce.map((v) => v.name)),
      availableMargin: DecimalValue(value.availableMarginUsdc, asset: 'USDC'),
      minimumNotional: DecimalValue(
        value.rules.minimumNotionalUsdc,
        asset: 'USDC',
      ),
      maximumNotional: value.rules.maximumNotionalUsdc == null
          ? null
          : DecimalValue(value.rules.maximumNotionalUsdc!, asset: 'USDC'),
      sizeDecimals: value.rules.sizeDecimals,
      validUntil: value.validUntil.toUtc(),
      operations: Set.unmodifiable(
        value.supportedOperations.map((v) => v.name),
      ),
      blocker: value.blocker,
    );
  }
}
