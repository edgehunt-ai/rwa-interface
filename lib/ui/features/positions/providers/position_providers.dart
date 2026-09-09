import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/market_product.dart';
import '../../../../domain/models/order.dart';
import '../../../../domain/models/position.dart';
import '../../../../domain/models/hip3_action_summary.dart';

final activeHip3ActionsProvider = FutureProvider.autoDispose
    .family<DomainPage<Hip3ActionSummary>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(positionsRepositoryProvider)
          .activeHip3Actions(cursor: cursor);
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

final positionCommandProvider = Provider.autoDispose(
  (ref) => PositionCommands(ref),
);

final class PositionCommands {
  PositionCommands(this._ref);
  final Ref _ref;
  final IdempotentCommandGuard _commands = IdempotentCommandGuard();

  Future<void> resumeHip3Action(String actionId) async {
    await _commands.run(
      operation: 'resume-hip3',
      fingerprint: actionId,
      command: (_) =>
          _ref.read(positionsRepositoryProvider).resumeHip3Action(actionId),
    );
    _ref.invalidate(positionProvider);
    _ref.invalidate(positionsProvider);
    _ref.invalidate(activeHip3ActionsProvider);
  }

  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? stopLoss,
    String? stopLimit,
  }) async {
    final result = await _commands.run(
      operation: 'tp-sl',
      fingerprint: '${position.positionId}|$takeProfit|$stopLoss|$stopLimit',
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .updateTpSl(
            position,
            takeProfit: takeProfit,
            stopLoss: stopLoss,
            stopLimit: stopLimit,
            idempotencyKey: key,
          ),
    );
    _ref.invalidate(positionProvider(position.positionId));
    _ref.invalidate(positionsProvider);
    return result;
  }

  Future<Position> clearTpSl(String positionId) async {
    final result = await _commands.run(
      operation: 'clear-tp-sl',
      fingerprint: positionId,
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .clearTpSl(positionId, idempotencyKey: key),
    );
    _ref.invalidate(positionProvider(positionId));
    _ref.invalidate(positionsProvider);
    return result;
  }

  Future<Position> updateLeverage(Position position, String leverage) async {
    final result = await _commands.run(
      operation: 'leverage',
      fingerprint: '${position.positionId}|$leverage',
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .updateLeverage(position, leverage: leverage, idempotencyKey: key),
    );
    _ref.invalidate(positionProvider(position.positionId));
    _ref.invalidate(positionsProvider);
    return result;
  }

  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
  }) async {
    final result = await _commands.run(
      operation: 'close-position',
      fingerprint: '$positionId|$quantity|$percent',
      command: (key) => _ref
          .read(positionsRepositoryProvider)
          .close(
            positionId,
            quantity: quantity,
            percent: percent,
            idempotencyKey: key,
          ),
    );
    _ref.invalidate(positionProvider(positionId));
    _ref.invalidate(positionsProvider);
    return result;
  }
}
