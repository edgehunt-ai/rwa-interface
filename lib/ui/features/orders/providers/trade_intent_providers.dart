import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/trade_intent.dart';

/// Restores the one non-terminal server-owned trade intent after a reload.
final currentTradeIntentProvider = FutureProvider.autoDispose<TradeIntent?>((
  ref,
) {
  ref.watch(sessionGenerationProvider);
  return ref.watch(tradeIntentRepositoryProvider).getCurrent();
});

final tradeIntentProvider = FutureProvider.autoDispose
    .family<TradeIntent, String>((ref, tradeIntentId) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(tradeIntentRepositoryProvider).get(tradeIntentId);
    });

final tradeIntentCommandsProvider = Provider.autoDispose(
  (ref) => TradeIntentCommands(ref),
);

final class TradeIntentCommands {
  TradeIntentCommands(this._ref);

  final Ref _ref;
  final IdempotentCommandGuard _commands = IdempotentCommandGuard();

  Future<TradeIntent> create(TradeIntentCreateInput input) async {
    final result = await _run(
      operation: 'create_trade_intent',
      command: () => _commands.run(
        operation: 'create-trade-intent',
        fingerprint: input.fingerprint,
        command: (key) => _ref
            .read(tradeIntentRepositoryProvider)
            .create(input, idempotencyKey: key),
      ),
    );
    _ref.invalidate(currentTradeIntentProvider);
    _ref.invalidate(tradeIntentProvider(result.tradeIntentId));
    return result;
  }

  Future<TradeIntent> cancel(String tradeIntentId) async {
    final result = await _run(
      operation: 'cancel_trade_intent',
      command: () => _commands.run(
        operation: 'cancel-trade-intent',
        fingerprint: tradeIntentId,
        command: (key) => _ref
            .read(tradeIntentRepositoryProvider)
            .cancel(tradeIntentId, idempotencyKey: key),
      ),
    );
    _ref.invalidate(currentTradeIntentProvider);
    _ref.invalidate(tradeIntentProvider(tradeIntentId));
    return result;
  }

  Future<T> _run<T>({
    required String operation,
    required Future<T> Function() command,
  }) async {
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: 'started');
    try {
      final result = await command();
      _ref
          .read(observabilityReporterProvider)
          .recordOperation(operation, outcome: 'succeeded');
      return result;
    } on ApiFailure catch (failure, stackTrace) {
      _ref
          .read(observabilityReporterProvider)
          .recordApiFailure(
            operation: operation,
            failure: failure,
            stackTrace: stackTrace,
          );
      rethrow;
    }
  }
}
