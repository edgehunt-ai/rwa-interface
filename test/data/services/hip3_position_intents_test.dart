import 'package:nobell/domain/models/hip3_protection.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:nobell/data/services/hip3_position_intents.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/market_product.dart';
import 'package:nobell/domain/models/position.dart';
import 'package:nobell/domain/models/position_operation.dart';

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
    protectionOrders: [
      Hip3PositionProtectionOrder(
        orderId: 'tp-1',
        protection: Hip3ProtectionParameters(
          role: 'takeProfit',
          triggerPrice: DecimalValue('130'),
        ),
      ),
      Hip3PositionProtectionOrder(
        orderId: 'sl-1',
        protection: Hip3ProtectionParameters(
          role: 'stopLoss',
          triggerPrice: DecimalValue('110'),
        ),
      ),
    ],
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
    expect(request['operation'], 'manage_tpsl');
    expect(request['position_version'], 'v2');
    final protection =
        (request['changes']! as List).single['protection'] as Map;
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
  test('clear cancels each selected system order ID', () {
    expect(wire(Hip3PositionIntents.clearProtection(position)), {
      'operation': 'manage_tpsl',
      'position_id': 'p1',
      'position_version': 'v2',
      'changes': [
        {'operation': 'cancel', 'order_id': 'tp-1'},
        {'operation': 'cancel', 'order_id': 'sl-1'},
      ],
    });
    expect(
      wire(
        Hip3PositionIntents.clearProtection(
          position,
          scope: ProtectionClearScope.takeProfit,
        ),
      )['changes'],
      [
        {'operation': 'cancel', 'order_id': 'tp-1'},
      ],
    );
  });
  test('two new legs are two creates and do not name existing orders', () {
    final request = wire(
      Hip3PositionIntents.setProtection(
        position,
        takeProfit: '130',
        stopLoss: '110',
      ),
    );
    final changes = request['changes'] as List;
    expect(changes, hasLength(2));
    for (final change in changes) {
      expect(change['operation'], 'create');
      expect(change.containsKey('order_id'), isFalse);
      final parameters = change['protection'] as Map;
      expect(
        parameters.containsKey('take_profit') !=
            parameters.containsKey('stop_loss'),
        isTrue,
      );
    }
  });
  test('a batch mixes create modify and cancel with complete parameters', () {
    final request = wire(
      Hip3PositionIntents.manageProtection(position, [
        Hip3ProtectionChange.create(
          Hip3ProtectionParameters(
            role: 'stopLoss',
            triggerPrice: DecimalValue('115'),
          ),
        ),
        Hip3ProtectionChange.modify(
          orderId: 'tp-1',
          protection: Hip3ProtectionParameters(
            role: 'takeProfit',
            triggerPrice: DecimalValue('140'),
            limitPrice: DecimalValue('139'),
            quantity: DecimalValue('0.25'),
          ),
        ),
        const Hip3ProtectionChange.cancel('sl-1'),
      ]),
    );
    final changes = request['changes'] as List;
    expect(changes.map((dynamic change) => change['operation']), [
      'create',
      'modify',
      'cancel',
    ]);
    expect(changes[1]['order_id'], 'tp-1');
    expect(changes[1]['protection'], {
      'size_mode': 'quantity',
      'quantity': '0.25',
      'take_profit': {
        'trigger_price': '140',
        'trigger_reference': 'mark',
        'execution_type': 'limit',
        'limit_price': '139',
      },
    });
  });
  test('empty batches and repeated target IDs are rejected', () {
    expect(
      () => Hip3PositionIntents.manageProtection(position, []),
      throwsArgumentError,
    );
    expect(
      () => Hip3PositionIntents.manageProtection(position, [
        const Hip3ProtectionChange.cancel('tp-1'),
        const Hip3ProtectionChange.cancel('tp-1'),
      ]),
      throwsArgumentError,
    );
  });
  test('fixed quantity is explicit, preserved exactly and bounded', () {
    final request = wire(
      Hip3PositionIntents.setProtection(
        position,
        takeProfit: '130',
        quantity: '0.123456789012345678',
      ),
    );
    final protection = (request['changes'] as List).single['protection'] as Map;
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
