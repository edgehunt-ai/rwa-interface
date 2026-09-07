import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/providers/api_providers.dart';
import '../../../../app/providers/session_scope.dart';
import '../../../../domain/models/domain_page.dart';
import '../../../../domain/models/withdrawal.dart';

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
  Future<WithdrawalQuote> quote(WithdrawalIntent intent) => _ref
      .read(fundingRepositoryProvider)
      .quoteWithdrawal(
        intent,
        idempotencyKey: 'quote-${intent.fingerprint.hashCode}',
      );
  Future<WalletAuthorization> authorize({
    required String walletId,
    required WithdrawalQuote quote,
  }) => _ref
      .read(walletsRepositoryProvider)
      .authorizeWithdrawal(
        walletId: walletId,
        quoteId: quote.quoteId,
        amount: quote.intent.amount.value,
        idempotencyKey: 'authorization-${quote.quoteId}',
      );
  Future<Withdrawal> create({
    required WithdrawalQuote quote,
    required WalletAuthorization authorization,
  }) async {
    if (!authorization.isUsable) {
      throw StateError('Withdrawal authorization is not usable');
    }
    final result = await _ref
        .read(fundingRepositoryProvider)
        .createWithdrawal(
          quote.intent,
          quoteId: quote.quoteId,
          authorizationId: authorization.authorizationId,
          idempotencyKey:
              'withdrawal-${quote.quoteId}-${authorization.authorizationId}',
        );
    _ref.invalidate(withdrawalsProvider);
    _ref.invalidate(withdrawalProvider(result.withdrawalId));
    return result;
  }
}
