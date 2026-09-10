import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/services/hip3_action_binding.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

api.Hip3Action action() =>
    api.standardSerializers.deserializeWith(api.Hip3Action.serializer, {
      'intent': {
        'operation': 'set_leverage',
        'context_id': 'context-1',
        'leverage': '2',
        'margin_mode': 'cross',
      },
      'action_id': 'action-1',
      'operation': 'set_leverage',
      'environment': 'testnet',
      'product_id': 'xyz:TSLA',
      'position_id': 'position-1',
      'status': 'reconciling',
      'steps': <Object?>[],
      'affected_order_ids': <String>[],
      'effects_applied': true,
      'created_at': '2026-09-10T00:00:00Z',
      'updated_at': '2026-09-10T00:00:00Z',
    })!;

void main() {
  final original = action();
  final binding = Hip3ActionBinding(
    intent: original.intent,
    operation: api.Hip3Operation.setLeverage,
    productId: 'xyz:TSLA',
    environment: api.Hip3Environment.testnet,
    positionId: 'position-1',
  );

  test('accepts independently deserialized matching intent', () {
    binding.validate(action(), expectedActionId: 'action-1');
  });

  for (final mutation in <String, void Function(api.Hip3ActionBuilder)>{
    'action': (b) => b.actionId = 'other',
    'product': (b) => b.productId = 'xyz:NVDA',
    'position': (b) => b.positionId = 'other',
    'network': (b) => b.environment = api.Hip3Environment.mainnet,
    'operation': (b) => b.operation = api.Hip3Operation.closePosition,
    'intent': (b) => b.intent.replace(
      api.standardSerializers.deserializeWith(
        api.Hip3ActionCreateRequest.serializer,
        {
          'operation': 'set_leverage',
          'context_id': 'context-1',
          'leverage': '10',
          'margin_mode': 'cross',
        },
      )!,
    ),
  }.entries) {
    test('rejects changed ${mutation.key} before signing', () {
      expect(
        () => binding.validate(
          original.rebuild(mutation.value),
          expectedActionId: 'action-1',
        ),
        throwsA(isA<Hip3SigningFailure>()),
      );
    });
  }
}
