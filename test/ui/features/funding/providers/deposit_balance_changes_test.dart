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
    realtime.add(_balanceEvent(id: 'balance-1', amount: '2'));

    final result = await change;
    expect(result.eventId, 'balance-1');
    expect(result.chain, 'Arbitrum');
    expect(result.token, 'USDC');
    expect(result.amount.value, '1');
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
  }) => subscribe(channels: channels);
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
