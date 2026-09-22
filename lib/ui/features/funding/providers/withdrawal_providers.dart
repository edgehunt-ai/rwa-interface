import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/observability_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/api_failure.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/decimal_value.dart';
import '../../../../domain/models/withdrawal.dart';
import '../../../../domain/repositories/portfolio_repository.dart';

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
          idempotencyKey: 'quote-${intent.fingerprint.hashCode}',
        ),
  );
  Future<WalletAuthorization> authorize({
    required String walletId,
    required WithdrawalQuote quote,
  }) => _run(
    operation: 'withdrawal_authorization',
    command: () => _ref
        .read(walletsRepositoryProvider)
        .authorizeWithdrawal(
          walletId: walletId,
          quoteId: quote.quoteId,
          amount: quote.intent.amount.value,
          idempotencyKey: 'authorization-${quote.quoteId}',
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
      command: () => _ref
          .read(fundingRepositoryProvider)
          .createWithdrawal(
            quote.intent,
            quoteId: quote.quoteId,
            authorizationId: authorization.authorizationId,
            idempotencyKey:
                'withdrawal-${quote.quoteId}-${authorization.authorizationId}',
          ),
    );
    _ref.invalidate(withdrawalsProvider);
    _ref.invalidate(withdrawalProvider(result.withdrawalId));
    return result;
  }

  Future<T> _run<T>({
    required String operation,
    required Future<T> Function() command,
  }) {
    _recordOperation(operation, outcome: 'started');
    try {
      final request = command();
      unawaited(
        request.then<void>(
          (_) => _recordOperation(operation, outcome: 'succeeded'),
          onError: (Object error, StackTrace stackTrace) {
            _recordFailure(operation, error, stackTrace);
          },
        ),
      );
      return request;
    } on ApiFailure catch (failure, stackTrace) {
      _recordFailure(operation, failure, stackTrace);
      rethrow;
    }
  }

  void _recordOperation(String operation, {required String outcome}) {
    if (!_ref.mounted) return;
    _ref
        .read(observabilityReporterProvider)
        .recordOperation(operation, outcome: outcome);
  }

  void _recordFailure(String operation, Object error, StackTrace stackTrace) {
    if (!_ref.mounted || error is! ApiFailure) return;
    _ref
        .read(observabilityReporterProvider)
        .recordApiFailure(
          operation: operation,
          failure: error,
          stackTrace: stackTrace,
        );
  }
}
