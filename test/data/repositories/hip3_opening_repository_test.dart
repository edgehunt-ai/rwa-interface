import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/hip3_opening_repository_impl.dart';
import 'package:rwa_interface/data/services/hip3_position_action_executor.dart';
import 'package:rwa_interface/data/services/hip3_position_action_service.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';

void main() {
  test(
    'context is read-only and preserves product-specific capabilities',
    () async {
      final service = _Service();
      final repository = _repository(service);
      final context = await repository.context('TSLA');
      expect(context.productId, 'xyz:TSLA');
      expect(context.maximumLeverage, 7);
      expect(context.currentLeverage, 2);
      expect(context.marginModes, {TradingMarginMode.cross});
      expect(context.orderTypes, {
        TradingOrderType.market,
        TradingOrderType.limit,
      });
      expect(context.availableMargin.value, '20');
      expect(service.creates, 0);
      service.foreign = true;
      await expectLater(repository.context('TSLA'), throwsFormatException);
    },
  );
  test('invalid leverage or mode cannot create an action', () async {
    final service = _Service();
    final repository = _repository(service);
    await expectLater(
      repository.setLeverage(
        'xyz:TSLA',
        8,
        TradingMarginMode.cross,
        idempotencyKey: 'invalid',
      ),
      throwsFormatException,
    );
    await expectLater(
      repository.setLeverage(
        'xyz:TSLA',
        2,
        TradingMarginMode.isolated,
        idempotencyKey: 'isolated',
      ),
      throwsFormatException,
    );
    expect(service.creates, 0);
  });
  test(
    'replaying confirmed settings fetches fresh context and retains intent',
    () async {
      final service = _Service();
      final repository = _repository(service);
      final context = await repository.setLeverage(
        'xyz:TSLA',
        3,
        TradingMarginMode.cross,
        idempotencyKey: 'settings',
      );
      expect(context.currentLeverage, 3);
      expect(service.reads, 2);
      final original = service.intent;
      await repository.setLeverage(
        'xyz:TSLA',
        3,
        TradingMarginMode.cross,
        idempotencyKey: 'settings',
      );
      expect(service.intent, original);
      expect(
        service.reads,
        3,
        reason: 'retry uses frozen preparation, then refreshes',
      );
      await expectLater(
        repository.setLeverage(
          'xyz:TSLA',
          4,
          TradingMarginMode.cross,
          idempotencyKey: 'settings',
        ),
        throwsArgumentError,
      );
    },
  );
}

Hip3OpeningRepositoryImpl _repository(_Service service) =>
    Hip3OpeningRepositoryImpl(
      service,
      Hip3PositionActionExecutor(service, _NoSigning()),
      (_) async =>
          throw StateError('Confirmed replay must not request consent'),
    );

final class _NoSigning extends Fake implements Hip3TypedDataSigner {}

final class _Service extends Fake implements Hip3PositionActionService {
  int reads = 0, creates = 0, leverage = 2;
  bool foreign = false;
  api.Hip3ActionCreateRequest? intent;
  @override
  Future<api.Hip3TradingContext> context(String productId) async {
    reads++;
    return api.standardSerializers.deserializeWith(
      api.Hip3TradingContext.serializer,
      {
        'context_id': 'context-$reads',
        'product_id': foreign ? 'xyz:NVDA' : 'xyz:TSLA',
        'symbol': foreign ? 'NVDA' : 'TSLA',
        'environment': 'testnet',
        'venue': 'xyz',
        'settlement_asset': 'USDC',
        'current_leverage': '$leverage',
        'current_margin_mode': 'cross',
        'available_margin_usdc': '20',
        'withdrawable_usdc': '20',
        'supported_operations': ['place_order', 'set_leverage'],
        'observed_at': '2026-09-10T00:00:00Z',
        'valid_until': DateTime.now()
            .toUtc()
            .add(const Duration(minutes: 1))
            .toIso8601String(),
        'rules': {
          'rules_version': 'v1',
          'size_decimals': 3,
          'price_max_significant_digits': 5,
          'price_max_decimals': 3,
          'integer_prices_allowed': true,
          'minimum_notional_usdc': '12',
          'maximum_notional_usdc': '15',
          'max_leverage': '7',
          'margin_modes': ['cross'],
          'order_types': ['market', 'limit'],
          'time_in_force': ['ioc', 'gtc'],
          'trigger_references': ['mark'],
          'observed_at': '2026-09-10T00:00:00Z',
        },
      },
    )!;
  }

  @override
  Future<api.Hip3Action> create(
    api.Hip3ActionCreateRequest request,
    String key,
  ) async {
    creates++;
    intent = request;
    leverage = 3;
    return get('action');
  }

  @override
  Future<api.Hip3Action> get(String id) async =>
      api.standardSerializers.deserializeWith(api.Hip3Action.serializer, {
        'intent': api.standardSerializers.serializeWith(
          api.Hip3ActionCreateRequest.serializer,
          intent,
        ),
        'action_id': 'action',
        'operation': 'set_leverage',
        'environment': 'testnet',
        'product_id': 'xyz:TSLA',
        'status': 'succeeded',
        'steps': <Object>[],
        'affected_order_ids': <String>[],
        'effects_applied': true,
        'created_at': '2026-09-10T00:00:00Z',
        'updated_at': '2026-09-10T00:00:00Z',
      })!;
}
