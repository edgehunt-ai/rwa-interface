// The test verifies serialization of the API's preview-bound compatibility
// request while its supported FundingSession replacement is exercised elsewhere.
// ignore_for_file: deprecated_member_use

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/trade_intent_repository_impl.dart';
import 'package:rwa_interface/data/services/trade_intent_service.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/trade_intent.dart';

void main() {
  test(
    'creates an auto multi-source intent and retains API wire values',
    () async {
      final service = _TradeIntentService();
      final repository = TradeIntentRepositoryImpl(service);
      final result = await repository.create(
        TradeIntentCreateInput(
          previewId: 'preview-1',
          authorizationId: 'order-authorization-1',
          executionPolicy: TradeIntentExecutionPolicy(
            limitPrice: DecimalValue('101.25', unit: 'price'),
            executeBefore: DateTime.utc(2026, 9, 10, 1),
          ),
        ),
        idempotencyKey: 'intent-key',
      );

      final request =
          service.request!.oneOf.value
              as api.AutoMultiSourceTradeIntentCreateRequest;
      expect(request.previewId, 'preview-1');
      expect(request.authorizationId, 'order-authorization-1');
      expect(request.fundingMode.name, 'autoMultiSource');
      expect(request.executionPolicy.limitPrice, '101.25');
      expect(service.idempotencyKey, 'intent-key');
      expect(result.productId, 'xyz:NVDA');
      expect(result.status, 'awaiting_funding');
      expect(result.nextAction, 'authorize_funding');
      expect(result.fundingLegs.single.status, 'action_released');
    },
  );

  test('returns null when there is no active trade intent', () async {
    final service = _TradeIntentService();
    final repository = TradeIntentRepositoryImpl(service);

    expect(await repository.getCurrent(), isNull);
  });
}

final class _TradeIntentService implements TradeIntentService {
  api.TradeIntentCreateRequest? request;
  String? idempotencyKey;

  @override
  Future<api.TradeIntent> create(
    api.TradeIntentCreateRequest request, {
    required String idempotencyKey,
  }) async {
    this.request = request;
    this.idempotencyKey = idempotencyKey;
    return _intent();
  }

  @override
  Future<api.TradeIntent?> getCurrent() async => null;

  @override
  Future<api.TradeIntent> get(String tradeIntentId) async => _intent();

  @override
  Future<api.TradeIntent> cancel(
    String tradeIntentId, {
    required String idempotencyKey,
  }) async => _intent();
}

api.TradeIntent _intent() =>
    api.standardSerializers.deserializeWith(api.TradeIntent.serializer, {
      'trade_intent_id': 'intent-1',
      'preview_id': 'preview-1',
      'authorization_id': 'order-authorization-1',
      'product_id': 'xyz:NVDA',
      'status': 'awaiting_funding',
      'next_action': 'authorize_funding',
      'blocker': null,
      'execution_policy': {
        'order_type': 'ioc',
        'limit_price': '101.25',
        'execute_before': '2026-09-10T01:00:00Z',
      },
      'funding_mode': 'auto_multi_source',
      'funding_plan_id': 'plan-1',
      'transfer_id': null,
      'funding_legs': [
        {
          'leg_id': 'leg-1',
          'ordinal': 1,
          'transfer_id': null,
          'status': 'action_released',
        },
      ],
      'order_id': null,
      'created_at': '2026-09-10T00:00:00Z',
      'updated_at': '2026-09-10T00:00:00Z',
      'expires_at': '2026-09-10T01:00:00Z',
    })!;
