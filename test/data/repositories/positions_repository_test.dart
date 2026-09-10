import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/positions_repository_impl.dart';
import 'package:rwa_interface/data/services/positions_service.dart';
import 'package:rwa_interface/data/services/hip3_position_action_service.dart';
import 'package:rwa_interface/data/services/hip3_position_action_executor.dart';
import 'package:rwa_interface/domain/services/hip3_typed_data_signer.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/position.dart';

void main() {
  final service = _Positions();
  final actions = _Actions();
  final repository = PositionsRepositoryImpl(
    service,
    actions: actions,
    executor: Hip3PositionActionExecutor(actions, _Signer()),
    confirm: (_) async => false,
  );
  final position = Position(
    positionId: 'position-1',
    productId: 'xyz:XYZ',
    positionVersion: 'version-1',
    symbol: 'XYZ',
    kind: MarketProductKind.perp,
    side: PositionSide.long,
    quantity: DecimalValue('1', unit: 'quantity'),
    valueUsd: DecimalValue('100', asset: 'USD', unit: 'fiat'),
    markPrice: DecimalValue(
      '100.000000000000000001',
      asset: 'USDC',
      unit: 'price',
    ),
  );

  test(
    'leverage context maps exact limits and refuses wrong product/network/mode',
    () async {
      actions.tradingContext = _context();
      final context = await repository.leverageContext('xyz:XYZ');
      expect(context.maximum.value, '10');
      expect(context.current!.value, '2');
      expect(context.marginMode, PositionMarginMode.cross);
      expect(context.canChange, isTrue);
      actions.tradingContext = _context().rebuild(
        (b) => b.productId = 'xyz:OTHER',
      );
      await expectLater(
        repository.leverageContext('xyz:XYZ'),
        throwsFormatException,
      );
      actions.tradingContext = _context().rebuild(
        (b) => b.environment = api.Hip3Environment.mainnet,
      );
      expect((await repository.leverageContext('xyz:XYZ')).canChange, isFalse);
      actions.tradingContext = _context().rebuild(
        (b) => b.currentMarginMode = null,
      );
      expect((await repository.leverageContext('xyz:XYZ')).canChange, isFalse);
      actions.tradingContext = _context().rebuild(
        (b) => b.currentLeverage = null,
      );
      expect((await repository.leverageContext('xyz:XYZ')).current, isNull);
      actions.tradingContext = _context().rebuild(
        (b) => b.supportedOperations.clear(),
      );
      expect((await repository.leverageContext('xyz:XYZ')).canChange, isFalse);
    },
  );

  test('TP/SL direction uses decimal comparisons without precision loss', () {
    expect(
      () => repository.updateTpSl(
        position,
        takeProfit: '100.000000000000000000',
        idempotencyKey: 'key',
      ),
      throwsArgumentError,
    );
  });

  test('leverage range and mutually exclusive close inputs are validated', () {
    expect(
      () => repository.updateLeverage(
        position,
        leverage: '50.000000000000000001',
        idempotencyKey: 'key',
      ),
      throwsArgumentError,
    );
    expect(
      () => repository.close(
        position.positionId,
        quantity: '1',
        percent: '100',
        idempotencyKey: 'key',
      ),
      throwsArgumentError,
    );
  });

  test(
    'recovery reads the same action without creating or signing another',
    () async {
      actions.recovered = _recovered();
      actions.reads = 0;
      await repository.resumeHip3Action('action-1');
      expect(actions.reads, 2);
      // Every other service method and signer method fail through noSuchMethod.
    },
  );

  test('recovery rejects an action from another network', () async {
    actions.recovered = _recovered().rebuild(
      (b) => b.environment = api.Hip3Environment.mainnet,
    );
    await expectLater(
      repository.resumeHip3Action('action-1'),
      throwsA(isA<Hip3SigningFailure>()),
    );
  });

  test('recovery rejects inconsistent frozen intent and position', () async {
    actions.recovered = _recovered().rebuild(
      (b) => b.positionId = 'other-position',
    );
    await expectLater(
      repository.resumeHip3Action('action-1'),
      throwsA(isA<Hip3SigningFailure>()),
    );
  });

  test(
    'active recovery list preserves cursor and distinguishes manual review',
    () async {
      actions.page = api.Hip3ActionPage(
        (b) => b
          ..hasMore = true
          ..nextCursor = 'next-page'
          ..items.addAll([
            _recovered().rebuild(
              (a) => a.status = api.Hip3ActionStatus.awaitingSignature,
            ),
            _recovered().rebuild(
              (a) => a
                ..actionId = 'review-1'
                ..status = api.Hip3ActionStatus.manualReview,
            ),
          ]),
      );
      final result = await repository.activeHip3Actions(cursor: 'current-page');
      expect(actions.cursor, 'current-page');
      expect(result.nextCursor, 'next-page');
      expect(result.hasMore, isTrue);
      expect(result.items.first.canResumePositionAction, isTrue);
      expect(result.items.last.canResumePositionAction, isFalse);
      expect(result.items.last.effectsApplied, isTrue);
      expect(result.items.last.status, 'manualReview');
    },
  );
}

final class _Positions implements PositionsService {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Actions implements Hip3PositionActionService {
  api.Hip3TradingContext? tradingContext;
  @override
  Future<api.Hip3TradingContext> context(String productId) async =>
      tradingContext!;
  api.Hip3ActionPage? page;
  String? cursor;
  @override
  Future<api.Hip3ActionPage> active({String? cursor}) async {
    this.cursor = cursor;
    return page!;
  }

  api.Hip3Action? recovered;
  int reads = 0;
  @override
  Future<api.Hip3Action> get(String actionId) async {
    reads++;
    return recovered!;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

api.Hip3TradingContext _context() =>
    api.standardSerializers.deserializeWith(api.Hip3TradingContext.serializer, {
      'context_id': 'ctx1',
      'environment': 'testnet',
      'product_id': 'xyz:XYZ',
      'symbol': 'XYZ',
      'venue': 'xyz',
      'settlement_asset': 'USDC',
      'current_leverage': '2',
      'current_margin_mode': 'cross',
      'available_margin_usdc': '100',
      'withdrawable_usdc': '100',
      'supported_operations': ['set_leverage'],
      'observed_at': '2026-09-10T00:00:00Z',
      'valid_until': '2099-01-01T00:00:00Z',
      'rules': {
        'rules_version': 'r1',
        'size_decimals': 3,
        'price_max_significant_digits': 5,
        'price_max_decimals': 3,
        'integer_prices_allowed': true,
        'minimum_notional_usdc': '10',
        'max_leverage': '10',
        'margin_modes': ['cross'],
        'order_types': ['market', 'limit'],
        'time_in_force': ['gtc', 'ioc'],
        'trigger_references': ['mark'],
        'observed_at': '2026-09-10T00:00:00Z',
      },
    })!;

api.Hip3Action _recovered() => api.standardSerializers.deserializeWith(
  api.Hip3Action.serializer,
  <String, Object?>{
    'action_id': 'action-1',
    'operation': 'clear_tpsl',
    'intent': {
      'operation': 'clear_tpsl',
      'position_id': 'position-1',
      'position_version': 'v1',
      'scope': 'both',
    },
    'position_id': 'position-1',
    'product_id': 'xyz:XYZ',
    'environment': 'testnet',
    'status': 'succeeded',
    'steps': <Object?>[],
    'affected_order_ids': <String>[],
    'effects_applied': true,
    'created_at': '2026-09-10T00:00:00Z',
    'updated_at': '2026-09-10T00:00:00Z',
  },
)!;

final class _Signer implements Hip3TypedDataSigner {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
