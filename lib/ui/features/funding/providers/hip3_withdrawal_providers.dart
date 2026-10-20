import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/idempotent_command_guard.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/hip3_withdrawal.dart';
import '../../../../domain/models/hip3_withdrawal_preview.dart';
import '../../../../domain/models/trading_account.dart';
import '../../../../domain/services/hip3_typed_data_signer.dart';

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
  return hip3.single.availableUsd?.value;
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
  Hip3WithdrawalPreview? _preview;
  Hip3Withdrawal? _prepared;

  void _checkSession() {
    if (!_ref.mounted || _ref.read(sessionGenerationProvider) != _session) {
      throw StateError('Transfer session changed. Please try again.');
    }
  }

  Future<int> _payoutChainId() async {
    final environment = await _ref.read(deploymentEnvironmentProvider.future);
    _checkSession();
    return switch (environment.hip3Environment) {
      'mainnet' => 42161,
      'testnet' => 421614,
      _ => throw StateError('Unsupported Perps network.'),
    };
  }

  bool _sameAmount(String left, String right) =>
      DecimalValue(left).compareTo(DecimalValue(right)) == 0;

  Future<Hip3WithdrawalPreview> preview(
    String amount, {
    bool forceRefresh = false,
  }) async {
    _checkSession();
    _validateAmount(amount);
    final payoutChainId = await _payoutChainId();
    final current = _preview;
    if (!forceRefresh &&
        current != null &&
        _sameAmount(current.amount, amount) &&
        current.chainId == payoutChainId.toString() &&
        current.isRiskExpired == false) {
      return current;
    }
    final result = await _ref
        .read(hip3WithdrawalRepositoryProvider)
        .preview(amount: amount, payoutChainId: payoutChainId);
    _checkSession();
    if (result.chainId != payoutChainId.toString() ||
        (result.payoutAsset != null && result.payoutAsset != 'USDC') ||
        !_sameAmount(result.amount, amount)) {
      throw StateError(
        'Withdrawal quote target or amount changed. Please refresh.',
      );
    }
    _preview = result;
    return result;
  }

  Future<Hip3Withdrawal> prepare(
    String amount, {
    required String rail,
    int? payoutChainId,
  }) async {
    _checkSession();
    _validateAmount(amount);
    return _runObserved(
      operation: 'hip3_withdrawal_prepare',
      context: {'rail': rail, 'stage': 'prepare'},
      successContext: (withdrawal) => {'withdrawal_id': withdrawal.id},
      command: () => _prepare(amount, rail: rail, payoutChainId: payoutChainId),
    );
  }

  Future<Hip3Withdrawal> _prepare(
    String amount, {
    required String rail,
    int? payoutChainId,
  }) async {
    final expectedChainId = await _payoutChainId();
    final quote = _preview;
    if (payoutChainId != null && payoutChainId != expectedChainId) {
      throw StateError('Withdrawal destination changed. Please refresh.');
    }
    final current = _prepared;
    Hip3Withdrawal? latest;
    if (current != null) {
      latest = await _ref
          .read(hip3WithdrawalRepositoryProvider)
          .get(current.id);
      _checkSession();
      // The venue may have accepted an earlier submission whose response was
      // lost. Reconcile it even after its signature TTL or quote has changed.
      if (latest.status != 'awaiting_signature') {
        if (!latest.isPending && !latest.requiresManualReview) _prepared = null;
        return latest;
      }
    }
    if (quote == null ||
        quote.chainId != expectedChainId.toString() ||
        quote.rail != rail ||
        !_sameAmount(quote.amount, amount) ||
        !quote.canProceed ||
        quote.isRiskExpired) {
      throw StateError(
        'Please refresh the withdrawal quote before continuing.',
      );
    }
    if (current != null &&
        latest?.status == 'awaiting_signature' &&
        current.expiresAt.isAfter(DateTime.now()) &&
        _matchesQuote(current, quote, expectedChainId)) {
      return current;
    }
    _prepared = null;
    final generation = _generation;
    final prepared = await _guard.run(
      operation: 'hip3-withdrawal-create',
      fingerprint: '$amount|$rail|$expectedChainId|$generation',
      command: (key) => _ref
          .read(hip3WithdrawalRepositoryProvider)
          .create(
            amount: amount,
            rail: rail,
            payoutChainId: expectedChainId,
            idempotencyKey: key,
          ),
    );
    _checkSession();
    _generation++;
    if (!_matchesQuote(prepared, quote, expectedChainId)) {
      _preview = null;
      throw const Hip3WithdrawalQuoteChanged();
    }
    _prepared = prepared;
    return prepared;
  }

  bool _matchesQuote(
    Hip3Withdrawal prepared,
    Hip3WithdrawalPreview quote,
    int chainId,
  ) =>
      prepared.payoutChainId == chainId &&
      prepared.payoutAsset == (quote.payoutAsset ?? 'USDC') &&
      prepared.rail == quote.rail &&
      prepared.destinationAddress.toLowerCase() ==
          quote.destinationAddress.toLowerCase() &&
      _sameAmount(prepared.amount, quote.amount) &&
      _sameAmount(prepared.fee, quote.fee) &&
      _sameAmount(prepared.minimumReceived, quote.minimumReceived);

  Future<Hip3Withdrawal> submit(Hip3Withdrawal prepared) async {
    _checkSession();
    return _runObserved(
      operation: 'hip3_withdrawal_submit',
      context: {
        'withdrawal_id': prepared.id,
        'rail': prepared.rail,
        'stage': 'submit',
      },
      command: () => _submit(prepared),
    );
  }

  Future<Hip3Withdrawal> _submit(Hip3Withdrawal prepared) async {
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
    _prepared = result;
    return result;
  }

  Future<Hip3Withdrawal> refresh(String id) =>
      _ref.read(hip3WithdrawalRepositoryProvider).get(id);

  Future<T> _runObserved<T>({
    required String operation,
    Map<String, String> context = const {},
    Map<String, String> Function(T result)? successContext,
    required Future<T> Function() command,
  }) async {
    final reporter = _ref.read(observabilityReporterProvider);
    final stopwatch = Stopwatch()..start();
    reporter.recordOperation(operation, outcome: 'started', context: context);
    try {
      final result = await command();
      reporter.recordOperation(
        operation,
        outcome: 'succeeded',
        context: {...context, ...?successContext?.call(result)},
        duration: stopwatch.elapsed,
      );
      return result;
    } on ApiFailure catch (failure, stackTrace) {
      reporter.recordApiFailure(
        operation: operation,
        failure: failure,
        stackTrace: stackTrace,
        context: context,
        duration: stopwatch.elapsed,
      );
      rethrow;
    } on Hip3SigningFailure catch (failure, stackTrace) {
      if (failure.code == Hip3SigningFailureCode.rejected) {
        reporter.recordOperation(
          operation,
          outcome: 'cancelled',
          context: context,
          duration: stopwatch.elapsed,
        );
      } else {
        reporter.recordError(
          operation: operation,
          error: failure,
          stackTrace: stackTrace,
          context: context,
          duration: stopwatch.elapsed,
        );
      }
      rethrow;
    } on Object catch (error, stackTrace) {
      reporter.recordError(
        operation: operation,
        error: error,
        stackTrace: stackTrace,
        context: context,
        duration: stopwatch.elapsed,
      );
      rethrow;
    }
  }

  void _validateAmount(String amount) {
    final decimal = DecimalValue(amount);
    if (decimal.scale > 6 || decimal.compareTo(DecimalValue('0')) <= 0) {
      throw const FormatException('Invalid USDC amount');
    }
  }
}
