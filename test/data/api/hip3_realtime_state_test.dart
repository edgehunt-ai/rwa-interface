import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/api/hip3_realtime_state.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/realtime_envelope.dart';

const signer = '0x1111111111111111111111111111111111111111';
const at = '2026-09-11T00:00:00Z';
const marketChannel = 'hip3:price:mainnet:xyz:TSLA';
const candleChannel = 'hip3:candle:mainnet:1m:xyz:TSLA';
const channels = {
  'hip3:orders',
  'hip3:positions',
  'hip3:balance',
  marketChannel,
  candleChannel,
};

Hip3RealtimeAccumulator accumulator() => Hip3RealtimeAccumulator(
  Hip3RealtimeScope(signer: signer, environment: 'testnet', channels: channels),
);

Map<String, Object?> price([String value = '12.123456789']) => {
  'product_id': 'xyz:TSLA',
  'venue': 'xyz',
  'environment': 'mainnet',
  'settlement_asset': 'USDC',
  'tradable': false,
  'unavailable_reason': 'hip3_mainnet_read_only',
  'symbol': 'TSLA',
  'kind': 'perp',
  'price': value,
  'change_24h_percent': '1',
  'updated_at': at,
  'source': 'hyperliquid_mainnet',
  'fresh_until': '2026-09-11T00:00:30Z',
  'price_label': 'Mark price',
};
Map<String, Object?> position(String quantity) => {
  'position_id': 'position-1',
  'product_id': 'xyz:TSLA',
  'symbol': 'TSLA',
  'kind': 'perp',
  'quantity': quantity,
  'value_usd': '0',
};
Map<String, Object?> candle(int minute, {String close = '12'}) => {
  ...price(),
  'interval': '1m',
  'closed': true,
  'point': {
    't': DateTime.utc(2026, 9, 11, 0, minute).toIso8601String(),
    'o': '12',
    'h': '13',
    'l': '11',
    'c': close,
    'v': '100',
  },
};
Map<String, Object?> member(String kind, Map<String, Object?> data) => {
  'event': kind,
  'data': data,
};
RealtimeEnvelope event(
  String kind,
  Object sequence,
  Map<String, Object?> body, {
  String stream = '11111111111111111111111111111111',
}) {
  final id = 'h3.$stream.$sequence';
  return RealtimeEnvelope(
    eventId: id,
    eventName: kind,
    data: {'event_id': id, 'event': kind, 'emitted_at': at, 'data': body},
  );
}

RealtimeEnvelope snapshot(
  List<Map<String, Object?>> items, {
  int sequence = 1,
  Map<String, Object?> overrides = const {},
}) => event('hip3_snapshot', sequence, {
  'channels': channels.toList().reversed.toList(),
  'signer': signer,
  'environment': 'testnet',
  'completed_at': at,
  'items': items,
  ...overrides,
});

void main() {
  test(
    'rolling snapshots remain bounded and permit unchanged members to return',
    () {
      final state = accumulator();
      for (var sequence = 1; sequence <= 1200; sequence++) {
        final id = 'position-$sequence';
        state.apply(
          snapshot([
            member('hip3_position', {...position('1'), 'position_id': id}),
          ], sequence: sequence),
        );
        expect(state.state!.resources.keys.map((key) => key.entity), [id]);
      }
      state.apply(snapshot([], sequence: 1201));
      expect(state.state!.resources, isEmpty);
      state.apply(event('hip3_position', 1202, position('1')));
      expect(state.state!.resources.keys.single.entity, 'position-1');
      expect(state.state!.resources.values.single.data['quantity'], '1');
    },
  );

  test('higher stream cursor cannot regress a market source observation', () {
    final state = accumulator();
    state.apply(snapshot([member('hip3_price', price())]));
    final before = state.state;
    expect(
      () => state.apply(
        event('hip3_price', 2, {
          ...price(),
          'updated_at': '2026-09-10T23:59:59Z',
        }),
      ),
      throwsA(isA<CompatibilityFailure>()),
    );
    expect(state.state, same(before));
  });
  test('order and wallet balance projections retain public facts and validate scope', () {
    final state = accumulator();
    final order = <String, Object?>{
      'order_id': 'order-1',
      'product_id': 'xyz:TSLA',
      'symbol': 'TSLA',
      'kind': 'perp',
      'side': 'long',
      'type': 'limit',
      'status': 'open',
      'next_action': null,
      'wallet_action_blocker': null,
      'created_at': at,
      'hip3_action_id': 'action-1',
    };
    final balance = <String, Object?>{
      'scope': 'hyperliquid_wallet',
      'signer': signer,
      'environment': 'testnet',
      'summary': {
        'total_value_usd': '100',
        'available_to_trade_usd': '60',
        'margin_in_use_usd': '20',
        'unvalued_asset_count': 0,
        'data_status': 'partial',
        'freshness': 'stale',
        'calculated_at': at,
        'warnings': <Object?>[],
        'sources': <Object?>[],
      },
      'assets': [],
    };
    state.apply(
      snapshot([member('hip3_order', order), member('hip3_balance', balance)]),
    );
    expect(
      (state
              .state!
              .resources[(
                channel: 'hip3:balance',
                entity: 'hyperliquid_wallet',
              )]!
              .data['summary']
          as Map)['freshness'],
      'stale',
    );
    state.apply(event('hip3_order', 2, {...order, 'status': 'cancelled'}));
    expect(
      state
          .state!
          .resources[(channel: 'hip3:orders', entity: 'order-1')]!
          .data['status'],
      'cancelled',
    );
    final before = state.state;
    for (final update in [
      event('hip3_balance', 3, {...balance, 'environment': 'mainnet'}),
      event('hip3_balance', 3, {
        ...balance,
        'signer': '0x2222222222222222222222222222222222222222',
      }),
      event('hip3_order', 3, {...order, 'product_id': 'other:TSLA'}),
    ]) {
      expect(() => state.apply(update), throwsA(isA<CompatibilityFailure>()));
      expect(identical(state.state, before), isTrue);
    }
  });

  test('exact cursors above JavaScript integer range do not collapse', () {
    final state = accumulator();
    state.apply(snapshot([]));
    state.apply(event('hip3_position', '9007199254740992', position('1')));
    state.apply(event('hip3_position', '9007199254740993', position('2')));
    expect(state.state!.resources.values.single.data['quantity'], '2');
    expect(
      state.apply(event('hip3_position', '9007199254740992', position('1'))),
      isFalse,
    );
  });

  test(
    'oversize snapshots, deltas and candle snapshots fail without truncation',
    () {
      final state = accumulator();
      state.apply(snapshot([]));
      final before = state.state;
      for (final update in [
        snapshot([
          for (var i = 0; i < 1001; i++)
            member('hip3_position', {...position('1'), 'position_id': 'p-$i'}),
        ], sequence: 2),
        event('hip3_position', 2, {...position('1'), 'extra': 'x' * 524289}),
        snapshot([
          for (var i = 0; i < 4; i++) member('hip3_candle', candle(i)),
        ], sequence: 2),
      ]) {
        expect(() => state.apply(update), throwsA(isA<CompatibilityFailure>()));
        expect(identical(state.state, before), isTrue);
      }
    },
  );

  test(
    'validates private scope separately from subscribed public environment',
    () {
      final state = accumulator();
      state.apply(
        snapshot([
          member('hip3_price', price()),
          member('hip3_position', position('1')),
        ]),
      );
      expect(state.state!.resources.length, 2);
      final quote =
          state.state!.resources[(channel: marketChannel, entity: 'xyz:TSLA')]!;
      expect(quote.data['price'], '12.123456789');
      expect(quote.data['fresh_until'], '2026-09-11T00:00:30Z');
    },
  );

  test(
    'invalid snapshot is atomic and does not change cursor or resources',
    () {
      final state = accumulator();
      state.apply(snapshot([member('hip3_price', price())]));
      final previous = state.state;
      for (final overrides in <Map<String, Object?>>[
        {'signer': '0x2222222222222222222222222222222222222222'},
        {'environment': 'mainnet'},
        {
          'channels': ['hip3:orders'],
        },
        {'channels': List.filled(channels.length, 'hip3:orders')},
        {
          'items': [
            member('hip3_price', price()),
            member('hip3_price', price('13')),
          ],
        },
        {
          'items': [
            member('hip3_price', {...price(), 'environment': 'testnet'}),
          ],
        },
        {
          'items': [
            member('hip3_price', {...price(), 'venue': 'other'}),
          ],
        },
        {
          'items': [
            member('hip3_price', {...price(), 'price': 12}),
          ],
        },
      ]) {
        expect(
          () => state.apply(snapshot([], sequence: 2, overrides: overrides)),
          throwsA(isA<CompatibilityFailure>()),
        );
        expect(identical(state.state, previous), isTrue);
      }
    },
  );

  test('snapshot replacement is not a fabricated cancellation or closure', () {
    final state = accumulator();
    state.apply(snapshot([member('hip3_position', position('1'))]));
    final previous = state.state!;
    state.apply(snapshot([], sequence: 2));
    expect(state.state!.resources, isEmpty);
    expect(previous.resources.values.single.data['quantity'], '1');
  });

  test('incremental zero-position preserves identity and old snapshots are immutable', () {
    final state = accumulator();
    final original = position('1');
    state.apply(snapshot([member('hip3_position', original)]));
    final previous = state.state!;
    original['quantity'] = '99';
    expect(previous.resources.values.single.data['quantity'], '1');
    state.apply(event('hip3_position', 2, position('0')));
    expect(state.state!.resources.values.single.data['quantity'], '0');
    expect(previous.resources.values.single.data['quantity'], '1');
    expect(() => state.state!.resources.clear(), throwsUnsupportedError);
    expect(
      () => state.state!.resources.values.single.data['quantity'] = '1',
      throwsUnsupportedError,
    );
  });

  test(
    'cursor ordering and resync require a fresh snapshot, not a stale delta',
    () {
      final state = accumulator();
      expect(
        () => state.apply(event('hip3_position', 1, position('1'))),
        throwsA(isA<CompatibilityFailure>()),
      );
      state.apply(snapshot([], sequence: 3));
      expect(state.apply(event('hip3_position', 2, position('1'))), isFalse);
      expect(
        () => state.apply(
          event(
            'hip3_position',
            4,
            position('1'),
            stream: '22222222222222222222222222222222',
          ),
        ),
        throwsA(isA<CompatibilityFailure>()),
      );
      state.apply(
        event('resync_required', 3, {'reason': 'event_retention_expired'}),
      );
      expect(state.state, isNull);
      expect(
        () => state.apply(event('hip3_position', 4, position('1'))),
        throwsA(isA<CompatibilityFailure>()),
      );
      state.apply(snapshot([], sequence: 1));
      expect(state.state, isNotNull);
    },
  );

  test('recent candle window stays bounded and permits corrections', () {
    final state = accumulator();
    state.apply(snapshot([member('hip3_candle', candle(0))]));
    for (var minute = 1; minute < 20; minute++) {
      state.apply(event('hip3_candle', minute + 1, candle(minute)));
    }
    expect(state.state!.resources, hasLength(3));
    state.apply(event('hip3_candle', 21, candle(18, close: '12.5')));
    final key = (
      channel: candleChannel,
      entity: DateTime.utc(2026, 9, 11, 0, 18).toIso8601String(),
    );
    expect((state.state!.resources[key]!.data['point'] as Map)['c'], '12.5');
    expect(
      () => (state.state!.resources[key]!.data['point'] as Map)['c'] = '1',
      throwsUnsupportedError,
    );
    state.apply(event('hip3_candle', 22, candle(0)));
    expect(state.state!.resources, hasLength(3));
    expect(state.state!.resources.containsKey(key), isTrue);
  });

  test(
    'scope rejects whitespace, incomplete identity and excessive markets',
    () {
      for (final invalid in [
        {'hip3:orders\n'},
        {'hip3:price:testnet:TSLA'},
        {'hip3:candle:testnet:2m:xyz:TSLA'},
        {for (var i = 0; i < 9; i++) 'hip3:price:testnet:xyz:P$i'},
      ]) {
        expect(
          () => Hip3RealtimeScope(
            signer: signer,
            environment: 'testnet',
            channels: invalid,
          ),
          throwsArgumentError,
        );
      }
    },
  );
}
