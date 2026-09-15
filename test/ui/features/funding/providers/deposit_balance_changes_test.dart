import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/portfolio.dart';
import 'package:rwa_interface/domain/models/realtime_replay_page.dart';
import 'package:rwa_interface/domain/models/trading_account.dart';
import 'package:rwa_interface/domain/repositories/portfolio_repository.dart';
import 'package:rwa_interface/domain/repositories/realtime_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/deposit_providers.dart';

void main() {
  test('emits only the increase over the opening balance snapshot', () async {
    final realtime = _Realtime();
    final container = ProviderContainer(
      overrides: [
        portfolioRepositoryProvider.overrideWithValue(_Portfolio()),
        realtimeRepositoryProvider.overrideWithValue(realtime),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(realtime.dispose);

    const route = (chain: 'Arbitrum', token: 'USDC');
    final subscription = container.listen(
      depositBalanceChangesProvider(route),
      (_, _) {},
    );
    addTearDown(subscription.close);
    final change = container.read(depositBalanceChangesProvider(route).future);
    await pumpEventQueue();

    expect(realtime.channels, {'balances'});
    expect(realtime.usedRecovery, isTrue);
    realtime.add(_balanceEvent(id: 'balance-1', amount: '2'));

    final result = await change;
    expect(result.eventId, 'balance-1');
    expect(result.chain, 'Arbitrum');
    expect(result.token, 'USDC');
    expect(result.amount.value, '1');
  });

  test('polls account balances when SSE does not deliver an event', () async {
    final realtime = _Realtime();
    final portfolio = _PollingPortfolio();
    final container = ProviderContainer(
      overrides: [
        portfolioRepositoryProvider.overrideWithValue(portfolio),
        realtimeRepositoryProvider.overrideWithValue(realtime),
        depositBalancePollIntervalProvider.overrideWithValue(
          const Duration(milliseconds: 10),
        ),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(realtime.dispose);

    const route = (chain: 'Arbitrum', token: 'USDC');
    final subscription = container.listen(
      depositBalanceChangesProvider(route),
      (_, _) {},
    );
    addTearDown(subscription.close);
    final result = await container.read(
      depositBalanceChangesProvider(route).future,
    );

    expect(result.eventId, startsWith('balance-poll-'));
    expect(result.amount.value, '1');
    expect(portfolio.calls, greaterThanOrEqualTo(2));
  });
}

TypedRealtimeEvent _balanceEvent({
  required String id,
  required String amount,
}) => TypedRealtimeEvent(
  id: id,
  kind: 'balance',
  entityId: null,
  sequence: null,
  payload: {
    'data': {
      'account': 'app',
      'chain': 'Arbitrum',
      'address': '0x1111111111111111111111111111111111111111',
      'balances': [
        {'symbol': 'USDC', 'chain': 'Arbitrum', 'balance': amount},
      ],
    },
  },
);

final class _Realtime implements RealtimeRepository {
  final _controller = StreamController<TypedRealtimeEvent>();
  Set<String>? channels;
  var usedRecovery = false;

  void add(TypedRealtimeEvent event) => _controller.add(event);
  void dispose() => _controller.close();

  @override
  Stream<TypedRealtimeEvent> subscribe({required Set<String> channels}) {
    this.channels = channels;
    return _controller.stream;
  }

  @override
  Future<RealtimeReplayPage> replay({
    required Set<String> channels,
    String? cursor,
    int limit = 50,
  }) async => const RealtimeReplayPage(
    items: [],
    nextCursor: '',
    hasMore: false,
    resyncRequired: false,
  );

  @override
  Stream<TypedRealtimeEvent> subscribeWithRecovery({
    required Set<String> channels,
    required Future<void> Function() refreshSnapshot,
  }) {
    usedRecovery = true;
    return subscribe(channels: channels);
  }
}

final class _PollingPortfolio implements PortfolioRepository {
  var calls = 0;

  @override
  Future<List<TradingAccount>> listAccounts() async {
    final amount = calls++ == 0 ? '1' : '2';
    return [
      TradingAccount(
        kind: TradingAccountKind.app,
        chain: 'Arbitrum',
        address: '0x1111111111111111111111111111111111111111',
        balances: [
          TokenBalance(
            symbol: 'USDC',
            chain: 'Arbitrum',
            balance: DecimalValue(amount, asset: 'USDC', unit: 'token'),
          ),
        ],
      ),
    ];
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _Portfolio implements PortfolioRepository {
  @override
  Future<List<TradingAccount>> listAccounts() async => [
    TradingAccount(
      kind: TradingAccountKind.app,
      chain: 'Arbitrum',
      address: '0x1111111111111111111111111111111111111111',
      balances: [
        TokenBalance(
          symbol: 'USDC',
          chain: 'Arbitrum',
          balance: DecimalValue('1', asset: 'USDC', unit: 'token'),
        ),
      ],
    ),
  ];

  @override
  Future<Portfolio> getSummary() => throw UnimplementedError();

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) =>
      throw UnimplementedError();
}
