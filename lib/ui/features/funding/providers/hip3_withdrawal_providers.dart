import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/hip3_withdrawal.dart';
import '../../../../domain/models/trading_account.dart';

// Portfolio availability is a snapshot, not a withdrawal guarantee. The create
// endpoint performs the authoritative withdrawal balance and margin checks.
final hip3TransferBalanceProvider = FutureProvider.autoDispose<String?>((
  ref,
) async {
  ref.watch(sessionGenerationProvider);
  final accounts = await ref.watch(portfolioRepositoryProvider).listAccounts();
  final hip3 = accounts
      .where((a) => a.kind == TradingAccountKind.hip3)
      .toList();
  if (hip3.length != 1) return null;
  final balances = hip3.single.balances.where((b) => b.symbol == 'USDC');
  return balances.length == 1 ? balances.single.balance.value : null;
}, retry: (_, _) => null);

final hip3WithdrawalCommandsProvider = Provider((ref) {
  final session = ref.watch(sessionGenerationProvider);
  return Hip3WithdrawalCommands(ref, session);
});

final class Hip3WithdrawalCommands {
  Hip3WithdrawalCommands(this._ref, this._session);
  final Ref _ref;
  final Object _session;
  final _guard = IdempotentCommandGuard();
  int _generation = 0;
  Hip3Withdrawal? _prepared;

  void _checkSession() {
    if (!_ref.mounted || _ref.read(sessionGenerationProvider) != _session) {
      throw StateError('Transfer session changed. Please try again.');
    }
  }

  Future<Hip3Withdrawal> prepare(String amount) async {
    _checkSession();
    final decimal = DecimalValue(amount);
    if (decimal.scale > 6 || decimal.compareTo(DecimalValue('0')) <= 0) {
      throw const FormatException('Invalid USDC amount');
    }
    final current = _prepared;
    if (current != null &&
        current.amount == amount &&
        current.status == 'awaiting_signature' &&
        current.expiresAt.isAfter(DateTime.now())) {
      final latest = await _ref
          .read(hip3WithdrawalRepositoryProvider)
          .get(current.id);
      _checkSession();
      if (latest.status == 'awaiting_signature') return current;
      _prepared = null;
      if (latest.isPending || latest.status == 'completed') return latest;
    }
    final generation = _generation;
    final prepared = await _guard.run(
      operation: 'hip3-withdrawal-create',
      fingerprint: '$amount|$generation',
      command: (key) => _ref
          .read(hip3WithdrawalRepositoryProvider)
          .create(amount: amount, idempotencyKey: key),
    );
    _checkSession();
    _prepared = prepared;
    _generation++;
    return prepared;
  }

  Future<Hip3Withdrawal> submit(Hip3Withdrawal prepared) async {
    _checkSession();
    // Reconcile before retrying a submission whose HTTP response may have been
    // lost, so a venue-accepted withdrawal never triggers another signature.
    final repository = _ref.read(hip3WithdrawalRepositoryProvider);
    final current = await repository.get(prepared.id);
    _checkSession();
    if (current.status != 'awaiting_signature') return current;
    final result = await _guard.run(
      operation: 'hip3-withdrawal-submit',
      fingerprint: prepared.id,
      command: (key) => repository.signAndSubmit(prepared, idempotencyKey: key),
    );
    _checkSession();
    _prepared = null;
    return result;
  }

  Future<Hip3Withdrawal> refresh(String id) =>
      _ref.read(hip3WithdrawalRepositoryProvider).get(id);
}
