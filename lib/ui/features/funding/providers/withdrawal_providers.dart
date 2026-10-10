import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../data/api/idempotency_key.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/withdrawal.dart';
import '../../../../domain/repositories/portfolio_repository.dart';
import '../../portfolio/providers/portfolio_providers.dart';

final withdrawalAssetsProvider =
    FutureProvider.autoDispose<List<WithdrawableAsset>>((ref) async {
      final repository = ref.watch(portfolioRepositoryProvider);
      if (repository is! PortfolioAssetsRepository) return const [];
      final assets = await (repository as PortfolioAssetsRepository)
          .listAssets();
      return assets
          .where(
            (asset) =>
                asset.withdrawable &&
                asset.balance.compareTo(
                      DecimalValue(
                        '0',
                        asset: asset.balance.asset,
                        unit: asset.balance.unit,
                      ),
                    ) >
                    0,
          )
          .map(
            (asset) => WithdrawableAsset(
              symbol: asset.symbol,
              chain: asset.network,
              balance: asset.balance,
              decimals: asset.decimals,
              assetId: asset.assetId,
              walletId: asset.walletId,
              contractAddress: asset.contractAddress,
              native: asset.native,
              withdrawable: asset.withdrawable,
            ),
          )
          .toList(growable: false);
    });

final withdrawalsProvider = FutureProvider.autoDispose
    .family<DomainPage<Withdrawal>, String?>((ref, cursor) {
      ref.watch(sessionGenerationProvider);
      return ref
          .watch(fundingRepositoryProvider)
          .listWithdrawals(cursor: cursor);
    });
final withdrawalProvider = FutureProvider.autoDispose
    .family<Withdrawal, String>((ref, id) {
      ref.watch(sessionGenerationProvider);
      return ref.watch(fundingRepositoryProvider).getWithdrawal(id);
    });
final withdrawalCommandsProvider = Provider.autoDispose(
  (ref) => WithdrawalCommands(ref),
);

final class WithdrawalCommands {
  WithdrawalCommands(this._ref);
  final Ref _ref;
  Future<WithdrawalQuote> quote(WithdrawalIntent intent) => _run(
    operation: 'withdrawal_quote',
    command: () => _ref
        .read(fundingRepositoryProvider)
        .quoteWithdrawal(
          intent,
          idempotencyKey: scopedIdempotencyKey(
            'withdrawal-quote-${intent.fingerprint}',
          ),
        ),
  );
  Future<WalletAuthorization> authorize({
    required String walletId,
    required WithdrawalQuote quote,
  }) => _run(
    operation: 'withdrawal_authorization',
    context: {'stage': 'authorize'},
    command: () => _ref
        .read(walletsRepositoryProvider)
        .authorizeWithdrawal(
          walletId: walletId,
          quoteId: quote.quoteId,
          amount: quote.intent.amount.value,
          idempotencyKey: scopedIdempotencyKey(
            'withdrawal-authorization-${quote.quoteId}',
          ),
        ),
  );
  Future<Withdrawal> create({
    required WithdrawalQuote quote,
    required WalletAuthorization authorization,
  }) async {
    if (!authorization.isUsable) {
      throw StateError('Withdrawal authorization is not usable');
    }
    final result = await _run(
      operation: 'create_withdrawal',
      context: {'stage': 'create'},
      successContext: (withdrawal) => {
        'withdrawal_id': withdrawal.withdrawalId,
      },
      command: () => _ref
          .read(fundingRepositoryProvider)
          .createWithdrawal(
            quote.intent,
            quoteId: quote.quoteId,
            authorizationId: authorization.authorizationId,
            idempotencyKey: scopedIdempotencyKey(
              'withdrawal-${quote.quoteId}-${authorization.authorizationId}',
            ),
          ),
    );
    _ref.invalidate(withdrawalsProvider);
    _ref.invalidate(withdrawalProvider(result.withdrawalId));
    _ref.invalidate(bstocksSellAvailabilityProvider);
    return result;
  }

  Future<T> _run<T>({
    required String operation,
    Map<String, String> context = const {},
    Map<String, String> Function(T result)? successContext,
    required Future<T> Function() command,
  }) async {
    final stopwatch = Stopwatch()..start();
    _recordOperation(operation, outcome: 'started', context: context);
    try {
      final result = await command();
      _recordOperation(
        operation,
        outcome: 'succeeded',
        context: {...context, ...?successContext?.call(result)},
        duration: stopwatch.elapsed,
      );
      return result;
    } on Object catch (error, stackTrace) {
      _recordFailure(
        operation,
        error,
        stackTrace,
        context: context,
        duration: stopwatch.elapsed,
      );
      rethrow;
    }
  }

  void _recordOperation(
    String operation, {
    required String outcome,
    Map<String, String> context = const {},
    Duration? duration,
  }) {
    if (!_ref.mounted) return;
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(
          operation,
          outcome: outcome,
          context: context,
          duration: duration,
        );
  }

  void _recordFailure(
    String operation,
    Object error,
    StackTrace stackTrace, {
    Map<String, String> context = const {},
    Duration? duration,
  }) {
    if (!_ref.mounted) return;
    final reporter = _ref.read(observabilityReporterProvider);
    if (error is ApiFailure) {
      reporter.recordApiFailure(
        operation: operation,
        failure: error,
        stackTrace: stackTrace,
        context: context,
        duration: duration,
      );
    } else {
      reporter.recordError(
        operation: operation,
        error: error,
        stackTrace: stackTrace,
        context: context,
        duration: duration,
      );
    }
  }
}
