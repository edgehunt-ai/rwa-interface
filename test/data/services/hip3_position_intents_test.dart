import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/services/hip3_position_intents.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/models/position_operation.dart';

void main() {
  final position = Position(
    positionId: 'p1',
    productId: 'xyz:TSLA',
    positionVersion: 'v2',
    symbol: 'TSLA',
    kind: MarketProductKind.perp,
    side: PositionSide.long,
    quantity: DecimalValue('1', unit: 'quantity'),
    valueUsd: DecimalValue('120', unit: 'fiat'),
    entryPrice: DecimalValue('100', unit: 'price'),
    markPrice: DecimalValue('120', unit: 'price'),
  );
  Map<Object?, Object?> wire(api.Hip3ActionCreateRequest request) =>
      api.standardSerializers.serializeWith(
            api.Hip3ActionCreateRequest.serializer,
            request,
          )!
          as Map;

  test('profitable stop binds current position version and mark trigger', () {
    final request = wire(
      Hip3PositionIntents.setProtection(position, stopLoss: '110'),
    );
    expect(request['operation'], 'set_tpsl');
    expect(request['position_version'], 'v2');
    final protection = request['protection']! as Map;
    expect(protection['size_mode'], 'entire_position');
    expect(protection['stop_loss'], {
      'trigger_price': '110',
      'trigger_reference': 'mark',
      'execution_type': 'market',
    });
    expect(protection.containsKey('take_profit'), isFalse);
  });
  test('invalid mark direction is rejected', () {
    expect(
      () => Hip3PositionIntents.setProtection(position, stopLoss: '121'),
      throwsArgumentError,
    );
    expect(
      () => Hip3PositionIntents.setProtection(position, takeProfit: '119'),
      throwsArgumentError,
    );
  });
  test('stop limit cannot exist without stop trigger', () {
    expect(
      () => Hip3PositionIntents.setProtection(position, stopLimit: '109'),
      throwsArgumentError,
    );
  });
  test('clear uses supported both scope', () {
    expect(wire(Hip3PositionIntents.clearProtection(position)), {
      'operation': 'clear_tpsl',
      'position_id': 'p1',
      'position_version': 'v2',
      'scope': 'both',
    });
  });
  test('clear targets exactly the selected protection leg', () {
    expect(
      wire(
        Hip3PositionIntents.clearProtection(
          position,
          scope: ProtectionClearScope.takeProfit,
        ),
      )['scope'],
      'take_profit',
    );
    expect(
      wire(
        Hip3PositionIntents.clearProtection(
          position,
          scope: ProtectionClearScope.stopLoss,
        ),
      )['scope'],
      'stop_loss',
    );
  });
  test('fixed quantity is explicit, preserved exactly and bounded', () {
    final protection =
        wire(
              Hip3PositionIntents.setProtection(
                position,
                takeProfit: '130',
                quantity: '0.123456789012345678',
              ),
            )['protection']
            as Map;
    expect(protection['size_mode'], 'quantity');
    expect(protection['quantity'], '0.123456789012345678');
    expect(protection.containsKey('percent'), isFalse);
    for (final bad in ['0', '-1', '1.000000000000000001']) {
      expect(
        () => Hip3PositionIntents.setProtection(
          position,
          takeProfit: '130',
          quantity: bad,
        ),
        throwsArgumentError,
      );
    }
  });
  test('close references a frozen preview, never direct position mutation', () {
    expect(wire(Hip3PositionIntents.close('preview-1')), {
      'operation': 'close_position',
      'preview_id': 'preview-1',
    });
  });
}
