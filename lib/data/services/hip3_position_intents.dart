import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/market_product.dart';
import '../../domain/models/position.dart';
import '../../domain/models/position_operation.dart';

/// Converts domain inputs to the only supported mutation transport: actions.
abstract final class Hip3PositionIntents {
  static api.Hip3ActionCreateRequest setProtection(
    Position position, {
    String? takeProfit,
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
  }) {
    _position(position);
    if ((takeProfit == null && stopLoss == null) ||
        (stopLimit != null && stopLoss == null) ||
        (takeLimit != null && takeProfit == null)) {
      throw ArgumentError(
        'Specify a protection leg; each limit price requires its trigger',
      );
    }
    for (final price in [takeProfit, takeLimit, stopLoss, stopLimit]) {
      if (price != null) _positive(price);
    }
    if (quantity != null) {
      requireWithinPosition(quantity, position.quantity.value);
    }
    // A profitable stop can be above entry. Direction is relative to mark,
    // and the backend revalidates against a fresh venue observation.
    final mark = position.markPrice;
    if (mark != null && position.side != PositionSide.none) {
      bool invalid(String? price, {required bool take}) {
        if (price == null) return false;
        final comparison = DecimalValue(
          price,
          asset: mark.asset,
          unit: mark.unit,
        ).compareTo(mark);
        final above = (position.side == PositionSide.long) == take;
        return above ? comparison <= 0 : comparison >= 0;
      }

      if (invalid(takeProfit, take: true) || invalid(stopLoss, take: false)) {
        throw ArgumentError(
          'Trigger price conflicts with mark and position side',
        );
      }
    }
    Map<String, Object?> leg(String price, [String? limit]) => {
      'trigger_price': price,
      'trigger_reference': 'mark',
      'execution_type': limit == null ? 'market' : 'limit',
      'limit_price': ?limit,
    };
    return _request({
      'operation': 'set_tpsl',
      'position_id': position.positionId,
      'position_version': position.positionVersion,
      'protection': {
        'size_mode': quantity == null ? 'entire_position' : 'quantity',
        'quantity': ?quantity,
        if (takeProfit != null) 'take_profit': leg(takeProfit, takeLimit),
        if (stopLoss != null) 'stop_loss': leg(stopLoss, stopLimit),
      },
    });
  }

  static api.Hip3ActionCreateRequest clearProtection(
    Position position, {
    ProtectionClearScope scope = ProtectionClearScope.both,
  }) {
    _position(position);
    return _request({
      'operation': 'clear_tpsl',
      'position_id': position.positionId,
      'position_version': position.positionVersion,
      'scope': switch (scope) {
        ProtectionClearScope.takeProfit => 'take_profit',
        ProtectionClearScope.stopLoss => 'stop_loss',
        ProtectionClearScope.both => 'both',
      },
    });
  }

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
