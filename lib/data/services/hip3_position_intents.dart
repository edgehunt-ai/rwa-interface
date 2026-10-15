import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/position.dart';
import '../../domain/models/position_operation.dart';
import '../../domain/models/hip3_protection.dart';

/// Converts domain inputs to the only supported mutation transport: actions.
abstract final class Hip3PositionIntents {
  static api.Hip3ActionCreateRequest manageProtection(
    Position position,
    List<Hip3ProtectionChange> changes,
  ) {
    _position(position);
    if (changes.isEmpty || changes.length > 20) {
      throw ArgumentError('Specify between one and twenty protection changes');
    }
    final targets = <String>{};
    final fields = <Map<String, Object?>>[];
    for (final change in changes) {
      final orderId = change.orderId;
      if (change.operation != ProtectionChangeOperation.create) {
        if (orderId == null ||
            orderId.trim().isEmpty ||
            !targets.add(orderId)) {
          throw ArgumentError('Each existing order may be changed only once');
        }
      }
      final protection = change.protection;
      if (change.operation == ProtectionChangeOperation.cancel) {
        fields.add({'operation': 'cancel', 'order_id': orderId});
        continue;
      }
      if (protection == null ||
          !const {'takeProfit', 'stopLoss'}.contains(protection.role) ||
          protection.triggerReference != 'mark' ||
          (protection.quantity != null && protection.percent != null)) {
        throw ArgumentError('Invalid protection parameters');
      }
      _positive(protection.triggerPrice.value);
      if (protection.limitPrice != null) {
        _positive(protection.limitPrice!.value);
      }
      if (protection.quantity != null) {
        requireWithinPosition(
          protection.quantity!.value,
          position.quantity.value,
        );
      }
      if (protection.percent != null) {
        requireWithinPosition(protection.percent!.value, '100');
      }
      final mark = position.markPrice;
      if (mark != null && position.side != PositionSide.none) {
        final comparison = protection.triggerPrice.compareTo(
          DecimalValue(
            mark.value,
            asset: protection.triggerPrice.asset,
            unit: protection.triggerPrice.unit,
          ),
        );
        final above =
            (position.side == PositionSide.long) ==
            (protection.role == 'takeProfit');
        if (above ? comparison <= 0 : comparison >= 0) {
          throw ArgumentError(
            'Trigger price conflicts with mark and position side',
          );
        }
      }
      fields.add({
        'operation': change.operation.name,
        'order_id': ?orderId,
        'protection': {
          'size_mode': protection.sizeMode == 'entirePosition'
              ? 'entire_position'
              : protection.sizeMode,
          'quantity': ?protection.quantity?.value,
          'percent': ?protection.percent?.value,
          protection.role == 'takeProfit' ? 'take_profit' : 'stop_loss': {
            'trigger_price': protection.triggerPrice.value,
            'trigger_reference': 'mark',
            'execution_type': protection.executionType,
            'limit_price': ?protection.limitPrice?.value,
          },
        },
      });
    }
    return _request({
      'operation': 'manage_tpsl',
      'position_id': position.positionId,
      'position_version': position.positionVersion,
      'changes': fields,
    });
  }

  static api.Hip3ActionCreateRequest setProtection(
    Position position, {
    String? takeProfit,
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
  }) {
    if ((takeProfit == null && stopLoss == null) ||
        (stopLimit != null && stopLoss == null) ||
        (takeLimit != null && takeProfit == null)) {
      throw ArgumentError(
        'Specify a protection leg; each limit price requires its trigger',
      );
    }
    return manageProtection(position, [
      if (takeProfit != null)
        Hip3ProtectionChange.create(
          Hip3ProtectionParameters(
            role: 'takeProfit',
            triggerPrice: DecimalValue(takeProfit),
            limitPrice: takeLimit == null ? null : DecimalValue(takeLimit),
            quantity: quantity == null ? null : DecimalValue(quantity),
          ),
        ),
      if (stopLoss != null)
        Hip3ProtectionChange.create(
          Hip3ProtectionParameters(
            role: 'stopLoss',
            triggerPrice: DecimalValue(stopLoss),
            limitPrice: stopLimit == null ? null : DecimalValue(stopLimit),
            quantity: quantity == null ? null : DecimalValue(quantity),
          ),
        ),
    ]);
  }

  static api.Hip3ActionCreateRequest clearProtection(
    Position position, {
    ProtectionClearScope scope = ProtectionClearScope.both,
  }) => manageProtection(position, [
    for (final order in position.protectionOrders)
      if (scope == ProtectionClearScope.both ||
          (scope == ProtectionClearScope.takeProfit &&
              order.protection.role == 'takeProfit') ||
          (scope == ProtectionClearScope.stopLoss &&
              order.protection.role == 'stopLoss'))
        Hip3ProtectionChange.cancel(order.orderId),
  ]);

  static api.Hip3ActionCreateRequest leverage(
    api.Hip3TradingContext context,
    String value, {
    PositionMarginMode? marginMode,
  }) {
    if (!RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
      throw ArgumentError('Leverage must be a positive integer');
    }
    final mode = switch (marginMode) {
      PositionMarginMode.cross => api.MarginMode.cross,
      PositionMarginMode.isolated => api.MarginMode.isolated,
      _ => context.currentMarginMode,
    };
    if (DecimalValue(
          value,
          unit: 'leverage',
        ).compareTo(DecimalValue(context.rules.maxLeverage, unit: 'leverage')) >
        0) {
      throw ArgumentError('Leverage exceeds the current product maximum');
    }
    if (mode != api.MarginMode.cross && mode != api.MarginMode.isolated) {
      throw ArgumentError('Current margin mode is unavailable');
    }
    if (!context.rules.marginModes.contains(mode)) {
      throw ArgumentError('Selected margin mode is not supported');
    }
    return _request({
      'operation': 'set_leverage',
      'context_id': context.contextId,
      'leverage': value,
      'margin_mode': mode!.name,
    });
  }

  static api.Hip3ActionCreateRequest close(String previewId) =>
      _request({'operation': 'close_position', 'preview_id': previewId});

  static void _position(Position position) {
    if (position.kind != MarketProductKind.perp ||
        position.productId == null ||
        position.productId!.isEmpty ||
        position.positionVersion == null ||
        position.positionVersion!.isEmpty) {
      throw ArgumentError('HIP3 product and position version are required');
    }
  }

  static void _positive(String value) {
    if (DecimalValue(
          value,
          unit: 'price',
        ).compareTo(DecimalValue('0', unit: 'price')) <=
        0) {
      throw ArgumentError('Price must be positive');
    }
  }

  static api.Hip3ActionCreateRequest _request(Map<String, Object?> fields) =>
      api.standardSerializers.deserializeWith(
        api.Hip3ActionCreateRequest.serializer,
        fields,
      )!;
}
