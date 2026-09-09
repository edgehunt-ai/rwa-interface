import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/api_failure.dart';
import 'package:rwa_interface/domain/models/hip3_action_pending.dart';
import 'package:rwa_interface/domain/models/hip3_action_summary.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/market_product.dart';
import 'package:rwa_interface/domain/models/order.dart';
import 'package:rwa_interface/domain/models/order_intent.dart';
import 'package:rwa_interface/domain/models/position.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';

void main() {
  test(
    'late success cannot refresh a replacement session or reuse its guard',
    () async {
      final repository = _PositionsRepository()
        ..leverageCompletion = Completer<void>();
      final container = ProviderContainer(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final commandsSubscription = container.listen(
        positionCommandProvider,
        (_, _) {},
      );
      final detailSubscription = container.listen(
        positionProvider('position-1'),
        (_, _) {},
      );
      final actionsSubscription = container.listen(
        activeHip3ActionsProvider(null),
        (_, _) {},
      );
      addTearDown(commandsSubscription.close);
      addTearDown(detailSubscription.close);
      addTearDown(actionsSubscription.close);
      await container.read(positionProvider('position-1').future);
      await container.read(activeHip3ActionsProvider(null).future);
      final oldCommands = container.read(positionCommandProvider);
      final stale = oldCommands.updateLeverage(_position(), '2');
      final staleCheck = expectLater(stale, throwsA(isA<CancelledFailure>()));

      container.read(sessionGenerationProvider.notifier).clearUserScope();
      final newCommands = container.read(positionCommandProvider);
      expect(identical(oldCommands, newCommands), isFalse);
      await container.read(positionProvider('position-1').future);
      await container.read(activeHip3ActionsProvider(null).future);
      expect(repository.getCalls['position-1'], 2);
      expect(repository.activeCalls, 2);

      repository.leverageCompletion!.complete();
      await staleCheck;
      await container.pump();
      expect(repository.getCalls['position-1'], 2);
      expect(repository.activeCalls, 2);

      await newCommands.updateLeverage(_position(), '2');
      expect(repository.leverageKeys.toSet(), hasLength(2));
    },
  );

  for (final requiresReview in [false, true]) {
    test(
      'pending action refreshes recovery list (review=$requiresReview)',
      () async {
        final repository = _PositionsRepository()
          ..pending = Hip3ActionPending(
            'action-1',
            requiresReview: requiresReview,
          );
        final container = ProviderContainer(
          overrides: [
            positionsRepositoryProvider.overrideWithValue(repository),
          ],
        );
        addTearDown(container.dispose);
        final actions = container.listen(
          activeHip3ActionsProvider(null),
          (_, _) {},
        );
        final commands = container.listen(positionCommandProvider, (_, _) {});
        addTearDown(actions.close);
        addTearDown(commands.close);
        await container.read(activeHip3ActionsProvider(null).future);
        expect(repository.activeCalls, 1);

        await expectLater(
          container
              .read(positionCommandProvider)
              .updateLeverage(_position(), '2'),
          throwsA(same(repository.pending)),
        );
        await container.read(activeHip3ActionsProvider(null).future);
        expect(repository.activeCalls, 2);
      },
    );
  }

  test('position list forwards filters through repository boundary', () async {
    final repository = _PositionsRepository();
    final container = ProviderContainer(
      overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    const filter = (
      symbol: 'XYZ',
      kind: MarketProductKind.perp,
      cursor: 'next',
    );
    await container.read(positionsProvider(filter).future);
    expect(repository.filter, filter);
  });

  test(
    'same position command merges concurrency and preserves retry key',
    () async {
      final repository = _PositionsRepository();
      final container = ProviderContainer(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(positionCommandProvider, (_, _) {});
      addTearDown(subscription.close);
      final commands = container.read(positionCommandProvider);
      final position = _position();

      final results = await Future.wait([
        commands.updateLeverage(position, '2'),
        commands.updateLeverage(position, '2'),
      ]);
      expect(results, hasLength(2));
      expect(repository.leverageKeys, hasLength(1));

      await commands.updateLeverage(position, '2');
      expect(repository.leverageKeys, hasLength(2));
      expect(repository.leverageKeys.toSet(), hasLength(1));

      await commands.updateLeverage(position, '3');
      expect(repository.leverageKeys.toSet(), hasLength(2));
    },
  );

  test(
    'close retry reuses key while a changed economic intent gets a new key',
    () async {
      final repository = _PositionsRepository();
      final container = ProviderContainer(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(positionCommandProvider, (_, _) {});
      addTearDown(subscription.close);
      final commands = container.read(positionCommandProvider);

      await commands.close('position-1', percent: '50');
      await commands.close('position-1', percent: '50');
      expect(repository.closeKeys.toSet(), hasLength(1));

      await commands.close('position-1', percent: '100');
      expect(repository.closeKeys.toSet(), hasLength(2));
    },
  );

  test(
    'successful command invalidates only its detail and position lists',
    () async {
      final repository = _PositionsRepository();
      final container = ProviderContainer(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final first = container.listen(positionProvider('position-1'), (_, _) {});
      final other = container.listen(positionProvider('position-2'), (_, _) {});
      const filter = (symbol: null, kind: null, cursor: null);
      final list = container.listen(positionsProvider(filter), (_, _) {});
      final commands = container.listen(positionCommandProvider, (_, _) {});
      addTearDown(first.close);
      addTearDown(other.close);
      addTearDown(list.close);
      addTearDown(commands.close);
      await Future.wait([
        container.read(positionProvider('position-1').future),
        container.read(positionProvider('position-2').future),
        container.read(positionsProvider(filter).future),
      ]);

      await container
          .read(positionCommandProvider)
          .updateLeverage(_position(), '2');
      await container.read(positionProvider('position-1').future);
      await container.read(positionsProvider(filter).future);

      expect(repository.getCalls['position-1'], 2);
      expect(repository.getCalls['position-2'], 1);
      expect(repository.listCalls, 2);
    },
  );

  test('failed command preserves the last confirmed detail', () async {
    final repository = _PositionsRepository()..failUpdates = true;
    final container = ProviderContainer(
      overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final detail = container.listen(positionProvider('position-1'), (_, _) {});
    final commands = container.listen(positionCommandProvider, (_, _) {});
    addTearDown(detail.close);
    addTearDown(commands.close);
    await container.read(positionProvider('position-1').future);

    await expectLater(
      container.read(positionCommandProvider).updateLeverage(_position(), '2'),
      throwsA(isA<NetworkFailure>()),
    );
    expect(repository.getCalls['position-1'], 1);
    expect(
      container.read(positionProvider('position-1')).value?.positionId,
      'position-1',
    );
  });
}

Position _position() => Position(
  positionId: 'position-1',
  symbol: 'NVDA',
  kind: MarketProductKind.perp,
  side: PositionSide.long,
  quantity: DecimalValue('1', unit: 'quantity'),
  valueUsd: DecimalValue('100', asset: 'USDC', unit: 'token'),
);

final class _PositionsRepository implements PositionsRepository {
  PositionFilter? filter;
  final List<String> leverageKeys = [];
  final List<String> closeKeys = [];
  final Map<String, int> getCalls = {};
  int listCalls = 0;
  bool failUpdates = false;
  Completer<void>? leverageCompletion;
  Hip3ActionPending? pending;
  int activeCalls = 0;

  @override
  Future<DomainPage<Hip3ActionSummary>> activeHip3Actions({
    String? cursor,
  }) async {
    activeCalls++;
    return const DomainPage(items: []);
  }

  @override
  Future<DomainPage<Position>> list({
    String? symbol,
    MarketProductKind? kind,
    String? cursor,
  }) async {
    listCalls++;
    filter = (symbol: symbol, kind: kind, cursor: cursor);
    return const DomainPage(items: []);
  }

  @override
  Future<Position> get(String positionId) async {
    getCalls.update(positionId, (value) => value + 1, ifAbsent: () => 1);
    return Position(
      positionId: positionId,
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      side: PositionSide.long,
      quantity: DecimalValue('1', unit: 'quantity'),
      valueUsd: DecimalValue('100', asset: 'USDC', unit: 'token'),
    );
  }

  @override
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    required String idempotencyKey,
  }) async {
    leverageKeys.add(idempotencyKey);
    await leverageCompletion?.future;
    await Future<void>.delayed(const Duration(milliseconds: 2));
    if (failUpdates) throw const NetworkFailure();
    if (pending != null) throw pending!;
    return position;
  }

  @override
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    required String idempotencyKey,
  }) async {
    closeKeys.add(idempotencyKey);
    return TradingOrder(
      orderId: 'close-${closeKeys.length}',
      symbol: 'NVDA',
      kind: MarketProductKind.perp,
      side: TradingSide.short,
      type: TradingOrderType.market,
      status: TradingOrderStatus.submitted,
      createdAt: DateTime.utc(2026),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
