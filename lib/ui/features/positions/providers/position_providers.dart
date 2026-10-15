import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/position_leverage_context.dart';
import '../../../../domain/models/position_close_preview.dart';
import '../../../../data/api/idempotency_key.dart';
import '../../../../domain/models/position_operation.dart';
import '../../../../domain/models/order_intent.dart';
import '../../orders/providers/order_providers.dart';
import '../../../../domain/models/hip3_action_summary.dart';
import '../../../../domain/models/hip3_protection.dart';

final activeHip3ActionsProvider = FutureProvider.autoDispose
    .family<DomainPage<Hip3ActionSummary>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(positionsRepositoryProvider)
          .activeHip3Actions(cursor: cursor);
    });

final hip3ProtectionActionProvider = FutureProvider.autoDispose
    .family<Hip3ActionSummary, String>((ref, actionId) async {
      ref.watch(sessionGenerationProvider);
      final result = await ref
          .watch(positionsRepositoryProvider)
          .hip3Action(actionId);
      final pendingOrders = result.protectionOrders.any(
        (order) => !order.isConfirmed && !order.isFailed,
      );
      if (pendingOrders ||
          (result.status == 'succeeded' && !result.protectionResultsComplete) ||
          const {
            'awaitingSignature',
            'submitting',
            'reconciling',
            'ambiguous',
          }.contains(result.status)) {
        final refresh = Timer(const Duration(seconds: 2), ref.invalidateSelf);
        ref.onDispose(refresh.cancel);
      }
      return result;
    });

typedef PositionFilter = ({
  String? symbol,
  MarketProductKind? kind,
  String? cursor,
});

final positionsProvider = FutureProvider.autoDispose
    .family<DomainPage<Position>, PositionFilter>((ref, filter) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(positionsRepositoryProvider)
          .list(
            symbol: filter.symbol,
            kind: filter.kind,
            cursor: filter.cursor,
          );
    });

final positionProvider = FutureProvider.autoDispose.family<Position, String>((
  ref,
  positionId,
) {
  ref.watch(sessionGenerationProvider);
  return ref.watch(positionsRepositoryProvider).get(positionId);
});

final positionCommandProvider = Provider.autoDispose((ref) {
  ref.watch(sessionGenerationProvider);
  return PositionCommands(ref);
});

typedef PositionClosePreviewRequest = ({
  Position position,
  String quantity,
  TradingOrderType type,
  String? limitPrice,
});

const _closePreviewRefreshInterval = Duration(seconds: 5);

/// Separate provider instances prevent older responses replacing edited inputs.
final positionClosePreviewProvider = FutureProvider.autoDispose
    .family<PositionClosePreview, PositionClosePreviewRequest>((
      ref,
      request,
    ) async {
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(positionsRepositoryProvider);
      final debounce = Completer<void>();
      final delay = Timer(const Duration(milliseconds: 300), debounce.complete);
      ref.onDispose(delay.cancel);
      await debounce.future;
      if (!ref.mounted) throw const CancelledFailure();
      final timeout = Completer<PositionClosePreview>();
      final timeoutTimer = Timer(
        const Duration(seconds: 10),
        () => timeout.completeError(const TimeoutFailure()),
      );
      ref.onDispose(timeoutTimer.cancel);
      final PositionClosePreview preview;
      try {
        preview = await Future.any([
          repository.previewClose(
            request.position,
            quantity: request.quantity,
            type: request.type,
            limitPrice: request.limitPrice,
            idempotencyKey: newIdempotencyKey(),
          ),
          timeout.future,
        ]);
      } finally {
        timeoutTimer.cancel();
      }
      if (!ref.mounted) throw const CancelledFailure();
      if (preview.isExpired) {
        throw const FormatException(
          'Close preview expired; request a new quote',
        );
      }
      final expiry = Timer(
        preview.expiresAt.difference(DateTime.now().toUtc()),
        ref.invalidateSelf,
      );
      final refresh = Timer(_closePreviewRefreshInterval, ref.invalidateSelf);
      ref.onDispose(expiry.cancel);
      ref.onDispose(refresh.cancel);
      return preview;
    }, retry: (_, _) => null);

final positionLeverageContextProvider = FutureProvider.autoDispose
    .family<PositionLeverageContext, String>((ref, productId) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(positionsRepositoryProvider).leverageContext(productId);
    }, retry: (_, _) => null);

final positionSizeDecimalsProvider = FutureProvider.autoDispose
    .family<int, String>((ref, productId) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(positionsRepositoryProvider).sizeDecimals(productId);
    }, retry: (_, _) => null);

final positionProtectionOrdersProvider = FutureProvider.autoDispose
    .family<List<TradingOrder>, Position>((ref, position) async {
      ref.watch(sessionGenerationProvider);
      final repository = ref.watch(ordersRepositoryProvider);
      final orders = await Future.wait(
        position.protectionOrderIds.map(repository.get),
      );
      return orders
          .map((result) {
            final order = result.resource;
            if (order.positionId != position.positionId ||
                order.productId != position.productId ||
                order.conditional == null) {
              throw const FormatException('Protection order binding mismatch');
            }
            return order;
          })
          .where((order) => !order.isTerminal)
          .toList(growable: false);
    });

final class PositionCommands {
  PositionCommands(this._ref);
  final Ref _ref;
  final IdempotentCommandGuard _commands = IdempotentCommandGuard();

  Future<T> _run<T>({
    required String operation,
    required String fingerprint,
    Map<String, String> context = const {},
    required Future<T> Function(String) command,
  }) async {
    if (!_ref.mounted) throw const CancelledFailure();
    final generation = _ref.read(sessionGenerationProvider);
    final stopwatch = Stopwatch()..start();
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started', context: context);
    try {
      final result = await _commands.run(
        operation: operation,
        fingerprint: fingerprint,
        command: command,
      );
      if (!_ref.mounted || _ref.read(sessionGenerationProvider) != generation) {
        throw const CancelledFailure();
      }
      _ref
          .read(observabilityReporterProvider)
          .recordOperation(
            operation,
            outcome: 'succeeded',
            context: context,
            duration: stopwatch.elapsed,
          );
      return result;
    } on ApiFailure catch (failure, stackTrace) {
      if (_ref.mounted) {
        _ref
            .read(observabilityReporterProvider)
            .recordApiFailure(
              operation: operation,
              failure: failure,
              stackTrace: stackTrace,
              context: context,
              duration: stopwatch.elapsed,
            );
      }
      rethrow;
    } on Object catch (error, stackTrace) {
      if (_ref.mounted) {
        _ref
            .read(observabilityReporterProvider)
            .recordError(
              operation: operation,
              error: error,
              stackTrace: stackTrace,
              context: context,
              duration: stopwatch.elapsed,
            );
      }
      rethrow;
    } finally {
      // A failed/paused call can still have created a recoverable server action.
      // Never refresh a different user's session after an in-flight command.
      if (_ref.mounted && _ref.read(sessionGenerationProvider) == generation) {
        _ref.invalidate(activeHip3ActionsProvider);
        _ref.invalidate(hip3OpenOrdersProvider);
        _ref.invalidate(hip3OrdersProvider);
        _ref.invalidate(positionsProvider);
      }
    }
  }

  Future<void> resumeHip3Action(String actionId) async {
    await _run(
      operation: 'resume-hip3',
      fingerprint: actionId,
      context: {'action_id': actionId},
      command: (_) =>
          _ref.read(positionsRepositoryProvider).resumeHip3Action(actionId),
    );
    _ref.invalidate(positionProvider);
    _ref.invalidate(positionsProvider);
    _ref.invalidate(positionLeverageContextProvider);
  }

  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
    ProtectionClearScope? clearScope,
    bool confirmBeforeSigning = true,
  }) async {
    final result = await _run(
      operation: 'tp-sl',
      context: {'position_id': position.positionId},
      fingerprint:
          '${position.positionId}|${position.productId}|${position.positionVersion}|$takeProfit|$takeLimit|$stopLoss|$stopLimit|$quantity|$clearScope',
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .updateTpSl(
            position,
            takeProfit: takeProfit,
            takeLimit: takeLimit,
            stopLoss: stopLoss,
            stopLimit: stopLimit,
            quantity: quantity,
            clearScope: clearScope,
            confirmBeforeSigning: confirmBeforeSigning,
            idempotencyKey: key,
          ),
    );
    _ref.invalidate(positionProvider(position.positionId));
    _ref.invalidate(positionsProvider);
    return result;
  }

  Future<Hip3ActionSummary> manageTpSl(
    Position position,
    List<Hip3ProtectionChange> changes, {
    bool confirmBeforeSigning = true,
  }) async {
    final result = await _run(
      operation: 'manage-tp-sl',
      context: {'position_id': position.positionId},
      fingerprint: [
        position.positionId,
        position.productId,
        position.positionVersion,
        for (final change in changes)
          '${change.operation.name}|${change.orderId}|${change.protection?.role}|${change.protection?.triggerPrice}|${change.protection?.quantity}|${change.protection?.percent}|${change.protection?.limitPrice}',
      ].join('|'),
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .manageTpSl(
            position,
            changes: changes,
            idempotencyKey: key,
            confirmBeforeSigning: confirmBeforeSigning,
          ),
    );
    _ref.invalidate(positionProvider(position.positionId));
    _ref.invalidate(positionProtectionOrdersProvider);
    return result;
  }

  Future<Position> clearTpSl(
    String positionId, {
    ProtectionClearScope scope = ProtectionClearScope.both,
  }) async {
    final result = await _run(
      operation: 'clear-tp-sl',
      fingerprint: '$positionId|$scope',
      context: {'position_id': positionId},
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .clearTpSl(positionId, scope: scope, idempotencyKey: key),
    );
    _ref.invalidate(positionProvider(positionId));
    _ref.invalidate(positionsProvider);
    return result;
  }

  Future<Position> updateLeverage(
    Position position,
    String leverage, {
    PositionMarginMode? marginMode,
    bool confirmBeforeSigning = true,
  }) async {
    final result = await _run(
      operation: 'leverage',
      fingerprint: '${position.positionId}|$leverage|$marginMode',
      context: {'position_id': position.positionId},
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .updateLeverage(
            position,
            leverage: leverage,
            marginMode: marginMode,
            confirmBeforeSigning: confirmBeforeSigning,
            idempotencyKey: key,
          ),
    );
    _ref.invalidate(positionProvider(position.positionId));
    _ref.invalidate(positionsProvider);
    if (position.productId case final productId?) {
      _ref.invalidate(positionLeverageContextProvider(productId));
    }
    return result;
  }

  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    PositionClosePreview? preview,
    bool confirmBeforeSigning = true,
  }) async {
    final result = await _run(
      operation: 'close-position',
      context: {'position_id': positionId},
      fingerprint:
          '$positionId|$quantity|$percent|$type|$limitPrice|${expectedPosition?.productId}|${expectedPosition?.positionVersion}|${preview?.previewId}',
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .close(
            positionId,
            quantity: quantity,
            percent: percent,
            type: type,
            limitPrice: limitPrice,
            expectedPosition: expectedPosition,
            preview: preview,
            confirmBeforeSigning: confirmBeforeSigning,
            idempotencyKey: key,
          ),
    );
    _ref.invalidate(positionProvider(positionId));
    _ref.invalidate(positionsProvider);
    return result;
  }
}
