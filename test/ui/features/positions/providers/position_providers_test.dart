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
import 'package:rwa_interface/domain/models/position_close_preview.dart';
import 'package:rwa_interface/domain/models/position_leverage_context.dart';
import 'package:rwa_interface/domain/repositories/positions_repository.dart';
import 'package:rwa_interface/ui/features/positions/providers/position_providers.dart';

void main() {
  test(
    'closing the preview subscription during debounce makes no request',
    () async {
      final repository = _PositionsRepository();
      final container = ProviderContainer(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final request = (
        position: _position(),
        quantity: '0.25',
        type: TradingOrderType.market,
        limitPrice: null as String?,
      );
      final subscription = container.listen(
        positionClosePreviewProvider(request),
        (_, _) {},
      );
      subscription.close();
      await container.pump();
      await Future<void>.delayed(const Duration(milliseconds: 320));
      expect(repository.previewKeys, isEmpty);
    },
  );

  test('preview refresh and session replacement use new keys and ignore late results', () async {
    final repository = _PositionsRepository();
    final old = Completer<PositionClosePreview>();
    repository.previewCompletions[1] = old;
    final container = ProviderContainer(
      overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final request = (
      position: _position(),
      quantity: '0.25',
      type: TradingOrderType.limit,
      limitPrice: '110',
    );
    final provider = positionClosePreviewProvider(request);
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);
    await Future<void>.delayed(const Duration(milliseconds: 320));
    expect(repository.previewKeys, hasLength(1));
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await container.pump();
    old.complete(_preview('old'));
    await container.pump();
    expect(container.read(provider).isLoading, isTrue);
    final replacement = await container.read(provider.future);
    expect(replacement.previewId, repository.previewKeys.last);
    expect(replacement.previewId, isNot('old'));
    expect(repository.previewRequests.last, request);
    container.invalidate(provider);
    await container.read(provider.future);
    expect(repository.previewKeys.toSet(), hasLength(3));
  });

  test('expired previews are rejected without automatic retry', () async {
    final repository = _PositionsRepository();
    repository.previewCompletions[1] = Completer<PositionClosePreview>()
      ..complete(_preview('expired', expiresAt: DateTime.utc(2020)));
    final container = ProviderContainer(
      overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final provider = positionClosePreviewProvider((
      position: _position(),
      quantity: '0.25',
      type: TradingOrderType.market,
      limitPrice: null,
    ));
    final subscription = container.listen(provider, (_, _) {});
    addTearDown(subscription.close);
    await expectLater(container.read(provider.future), throwsFormatException);
    await container.pump();
    expect(repository.previewKeys, hasLength(1));
  });

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
    'leverage command forwards the signing confirmation preference',
    () async {
      final repository = _PositionsRepository();
      final container = ProviderContainer(
        overrides: [positionsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);
      final commands = container.listen(positionCommandProvider, (_, _) {});
      addTearDown(commands.close);

      await container
          .read(positionCommandProvider)
          .updateLeverage(_position(), '2', confirmBeforeSigning: false);

      expect(repository.leverageConfirmBeforeSigning, isFalse);
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
      final context = container.listen(
        positionLeverageContextProvider('xyz:NVDA'),
        (_, _) {},
      );
      addTearDown(context.close);
      addTearDown(first.close);
      addTearDown(other.close);
      addTearDown(list.close);
      addTearDown(commands.close);
      await Future.wait([
        container.read(positionLeverageContextProvider('xyz:NVDA').future),
        container.read(positionProvider('position-1').future),
        container.read(positionProvider('position-2').future),
        container.read(positionsProvider(filter).future),
      ]);

      await container
          .read(positionCommandProvider)
          .updateLeverage(_position(), '2');
      await container.read(positionProvider('position-1').future);
      await container.read(positionsProvider(filter).future);
      await container.read(positionLeverageContextProvider('xyz:NVDA').future);

      expect(repository.getCalls['position-1'], 2);
      expect(repository.getCalls['position-2'], 1);
      expect(repository.listCalls, 2);
      expect(repository.contextCalls, 2);
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
  productId: 'xyz:NVDA',
  symbol: 'NVDA',
  kind: MarketProductKind.perp,
  side: PositionSide.long,
  quantity: DecimalValue('1', unit: 'quantity'),
  valueUsd: DecimalValue('100', asset: 'USDC', unit: 'token'),
);

final class _PositionsRepository implements PositionsRepository {
  final previewKeys = <String>[];
  final previewRequests = <PositionClosePreviewRequest>[];
  final previewCompletions = <int, Completer<PositionClosePreview>>{};
  @override
  Future<PositionClosePreview> previewClose(
    Position position, {
    required String quantity,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    required String idempotencyKey,
  }) async {
    previewKeys.add(idempotencyKey);
    previewRequests.add((
      position: position,
      quantity: quantity,
      type: type,
      limitPrice: limitPrice,
    ));
    return previewCompletions[previewKeys.length]?.future ??
        _preview(idempotencyKey);
  }

  PositionFilter? filter;
  final List<String> leverageKeys = [];
  final List<String> closeKeys = [];
  final Map<String, int> getCalls = {};
  int listCalls = 0;
  bool failUpdates = false;
  Completer<void>? leverageCompletion;
  Hip3ActionPending? pending;
  int activeCalls = 0;
  int contextCalls = 0;
  bool? leverageConfirmBeforeSigning;
  @override
  Future<PositionLeverageContext> leverageContext(String productId) async {
    contextCalls++;
    return PositionLeverageContext(
      productId: productId,
      maximum: DecimalValue('10'),
      validUntil: DateTime.utc(2099),
      canChange: true,
    );
  }

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
    PositionMarginMode? marginMode,
    bool confirmBeforeSigning = true,
    required String idempotencyKey,
  }) async {
    leverageKeys.add(idempotencyKey);
    leverageConfirmBeforeSigning = confirmBeforeSigning;
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
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    PositionClosePreview? preview,
    bool confirmBeforeSigning = true,
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

PositionClosePreview _preview(String id, {DateTime? expiresAt}) =>
    PositionClosePreview(
      previewId: id,
      positionId: 'position-1',
      productId: 'xyz:NVDA',
      positionVersion: '',
      environment: 'testnet',
      side: PositionSide.short,
      type: TradingOrderType.market,
      quantity: DecimalValue('0.25'),
      notional: DecimalValue('25'),
      entryPrice: DecimalValue('99'),
      markPrice: DecimalValue('100'),
      estimatedPrice: DecimalValue('100'),
      estimatedFee: DecimalValue('0.01'),
      estimatedRealizedPnl: DecimalValue('0.24'),
      expiresAt:
          expiresAt ?? DateTime.now().toUtc().add(const Duration(minutes: 1)),
      observedAt: DateTime.now().toUtc(),
    );
