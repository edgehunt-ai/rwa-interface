import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/data/repositories/hip3_live_repository_impl.dart';
import 'package:rwa_interface/data/services/realtime_service.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/hip3_live.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/portfolio_read_status.dart';
import 'package:rwa_interface/domain/models/realtime_envelope.dart';

const signer = '0x1111111111111111111111111111111111111111';
const at = '2026-09-11T00:00:00Z';
final query = Hip3LiveQuery(
  signer: signer,
  environment: 'testnet',
  channels: {
    'hip3:orders',
    'hip3:positions',
    'hip3:balance',
    'hip3:price:mainnet:xyz:TSLA',
    'hip3:candle:mainnet:1m:xyz:TSLA',
  },
);
Map<String, Object?> quote() => {
  'product_id': 'xyz:TSLA',
  'venue': 'xyz',
  'environment': 'mainnet',
  'settlement_asset': 'USDC',
  'tradable': false,
  'unavailable_reason': 'hip3_mainnet_read_only',
  'symbol': 'TSLA',
  'kind': 'perp',
  'price': '12.123456789',
  'change_24h_percent': '1',
  'updated_at': at,
  'source': 'hyperliquid_mainnet',
  'fresh_until': '2026-09-11T00:00:30Z',
  'price_label': 'Mark price',
};
Map<String, Object?> position(String quantity) => {
  'position_id': 'p1',
  'product_id': 'xyz:TSLA',
  'symbol': 'TSLA',
  'kind': 'perp',
  'quantity': quantity,
  'value_usd': '0',
  'protection_order_ids': ['protection-1'],
  'position_version': '7',
};
RealtimeEnvelope event(String kind, int seq, Map<String, Object?> body) {
  final id = 'h3.11111111111111111111111111111111.$seq';
  return RealtimeEnvelope(
    eventId: id,
    eventName: kind,
    data: {'event_id': id, 'event': kind, 'emitted_at': at, 'data': body},
  );
}

RealtimeEnvelope snapshot() => event('hip3_snapshot', 1, {
  'channels': query.channels.toList(),
  'signer': signer,
  'environment': 'testnet',
  'completed_at': at,
  'items': [
    {
      'event': 'hip3_order',
      'data': {
        'order_id': 'o1',
        'product_id': 'xyz:TSLA',
        'symbol': 'TSLA',
        'kind': 'perp',
        'side': 'long',
        'type': 'limit',
        'status': 'cancelled',
        'next_action': null,
        'wallet_action_blocker': null,
        'created_at': at,
      },
    },
    {'event': 'hip3_position', 'data': position('1')},
    {'event': 'hip3_price', 'data': quote()},
    {
      'event': 'hip3_candle',
      'data': {
        ...quote(),
        'interval': '1m',
        'closed': false,
        'point': {
          't': at,
          'o': '12',
          'h': '13',
          'l': '11',
          'c': '12.123456789',
          'v': '100',
        },
      },
    },
    {
      'event': 'hip3_balance',
      'data': {
        'scope': 'hyperliquid_wallet',
        'signer': signer,
        'environment': 'testnet',
        'summary': {
          'total_value_usd': '100',
          'available_to_trade_usd': '60',
          'margin_in_use_usd': '20',
          'unvalued_asset_count': 1,
          'data_status': 'partial',
          'freshness': 'stale',
          'calculated_at': at,
          'warnings': <Object?>[],
          'sources': <Object?>[],
        },
        'assets': [
          {
            'asset_id': 'asset-1',
            'source': 'hyperliquid_info',
            'network': 'Hyperliquid',
            'native': false,
            'symbol': 'UNKNOWN',
            'decimals': 8,
            'balance_raw': '123',
            'balance': '0.00000123',
            'price_usd': null,
            'value_usd': null,
            'pricing_source': 'unavailable',
            'observed_at': at,
            'freshness': 'stale',
            'warnings': <Object?>[],
          },
        ],
      },
    },
  ],
});

final class FakeRealtime implements RealtimeService {
  FakeRealtime(this.events);
  final Stream<RealtimeEnvelope> events;
  @override
  Stream<RealtimeEnvelope> subscribe({required Set<String> channels}) => events;
}

void main() {
  test('maps five public resource kinds to domain objects without losing provenance', () async {
    final repo = Hip3LiveRepositoryImpl(FakeRealtime(Stream.value(snapshot())));
    final result = await repo.subscribe(query).first as Hip3LiveSnapshot;
    expect(result.orders['o1']!.status, TradingOrderStatus.cancelled);
    expect(result.positions['p1']!.positionVersion, '7');
    expect(result.positions['p1']!.protectionOrderIds, ['protection-1']);
    expect(result.prices.values.single.quote.price.value, '12.123456789');
    expect(result.prices.values.single.source, 'hyperliquid_mainnet');
    expect(result.prices.values.single.quote.price.asset, 'USDC');
    expect(result.prices.keys.single.environment, 'mainnet');
    expect(
      result.prices.values.single.quote.isStaleAt(
        DateTime.utc(2026, 9, 11, 0, 1),
      ),
      isTrue,
    );
    expect(result.candles.keys.single.interval, '1m');
    expect(result.candles.values.single.point.close.value, '12.123456789');
    expect(result.candles.values.single.closed, isFalse);
    expect(result.candles.values.single.point.close.asset, 'USDC');
    expect(result.candles.values.single.point.volume!.unit, 'volume');
    final balance = result.balance!;
    expect(balance.environment, 'testnet');
    expect(balance.summary.totalValueUsd.value, '100');
    expect(balance.summary.availableToTradeUsd.value, '60');
    expect(balance.summary.todayPnl, isNull);
    expect(
      balance.summary.readStatus.completeness,
      PortfolioCompleteness.partial,
    );
    expect(balance.summary.readStatus.freshness, PortfolioFreshness.stale);
    expect(balance.assets.single.balance.value, '0.00000123');
    expect(balance.assets.single.balanceRaw, '123');
    expect(balance.assets.single.valueUsd, isNull);
    expect(balance.assets.single.pricingSource, 'unavailable');
    expect(() => result.positions.clear(), throwsUnsupportedError);
    expect(() => balance.assets.clear(), throwsUnsupportedError);
  });

  test('increments preserve zero positions; resync clears rather than replaying a command', () async {
    final repo = Hip3LiveRepositoryImpl(
      FakeRealtime(
        Stream.fromIterable([
          snapshot(),
          event('hip3_position', 2, position('0')),
          event('resync_required', 2, {'reason': 'event_retention_expired'}),
        ]),
      ),
    );
    final updates = await repo.subscribe(query).toList();
    expect(updates, hasLength(3));
    expect(
      (updates[0] as Hip3LiveSnapshot).positions['p1']!.quantity.value,
      '1',
    );
    expect(
      (updates[1] as Hip3LiveSnapshot).positions['p1']!.quantity.value,
      '0',
    );
    expect(updates[2], isA<Hip3LiveResync>());
  });

  test('invalid decimal never publishes a partially mapped snapshot', () async {
    final repo = Hip3LiveRepositoryImpl(
      FakeRealtime(
        Stream.fromIterable([
          snapshot(),
          event('hip3_price', 2, {...quote(), 'price': 'not-a-decimal'}),
        ]),
      ),
    );
    await expectLater(
      repo.subscribe(query),
      emitsInOrder([
        isA<Hip3LiveSnapshot>(),
        emitsError(isA<CompatibilityFailure>()),
        emitsDone,
      ]),
    );
  });

  test(
    'unexpected clean EOF is unavailable, not a permanently live snapshot',
    () async {
      final repo = Hip3LiveRepositoryImpl(
        FakeRealtime(Stream.value(snapshot())),
      );
      await expectLater(
        repo.subscribe(query),
        emitsInOrder([
          isA<Hip3LiveSnapshot>(),
          emitsError(isA<NetworkFailure>()),
          emitsDone,
        ]),
      );
    },
  );

  test(
    'cancelling repository consumer releases the upstream subscription',
    () async {
      var cancelled = false;
      late final StreamController<RealtimeEnvelope> controller;
      controller = StreamController(
        onListen: () => controller.add(snapshot()),
        onCancel: () {
          cancelled = true;
        },
      );
      final repo = Hip3LiveRepositoryImpl(FakeRealtime(controller.stream));
      await repo.subscribe(query).first;
      await pumpEventQueue();
      expect(cancelled, isTrue);
      await controller.close();
    },
  );
}
