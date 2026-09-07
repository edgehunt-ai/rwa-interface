import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/api_providers.dart';
import 'package:rwa_interface/app/providers/session_scope.dart';
import 'package:rwa_interface/domain/models/decimal_value.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/withdrawal.dart';
import 'package:rwa_interface/domain/repositories/funding_repository.dart';
import 'package:rwa_interface/domain/repositories/wallets_repository.dart';
import 'package:rwa_interface/ui/features/funding/providers/withdrawal_providers.dart';

void main() {
  test(
    'withdrawal command lifecycle uses stable keys and validates authorization',
    () async {
      final funding = _FundingRepository();
      final wallets = _WalletsRepository();
      final container = _container(funding, wallets);
      final subscription = container.listen(
        withdrawalCommandsProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);
      final commands = container.read(withdrawalCommandsProvider);
      final intent = _intent();

      final quote = await commands.quote(intent);
      await commands.quote(intent);
      expect(funding.quoteKeys.toSet(), hasLength(1));

      final authorization = await commands.authorize(
        walletId: 'wallet-1',
        quote: quote,
      );
      await commands.authorize(walletId: 'wallet-1', quote: quote);
      expect(wallets.keys.toSet(), hasLength(1));

      await commands.create(quote: quote, authorization: authorization);
      await commands.create(quote: quote, authorization: authorization);
      expect(funding.withdrawalKeys.toSet(), hasLength(1));

      await expectLater(
        commands.create(
          quote: quote,
          authorization: WalletAuthorization(
            authorizationId: 'expired',
            walletId: 'wallet-1',
            status: WalletAuthorizationState.expired,
            expiresAt: DateTime.utc(2020),
          ),
        ),
        throwsStateError,
      );
      expect(funding.withdrawalKeys, hasLength(2));
    },
  );

  test('withdrawal list and detail refresh on session generation', () async {
    final funding = _FundingRepository();
    final container = _container(funding, _WalletsRepository());
    final list = container.listen(withdrawalsProvider(null), (_, _) {});
    final detail = container.listen(
      withdrawalProvider('withdrawal-1'),
      (_, _) {},
    );
    addTearDown(list.close);
    addTearDown(detail.close);

    await _readQueries(container);
    expect(
      container.read(withdrawalsProvider(null)).value?.items.single.status,
      WithdrawalState.ambiguous,
    );
    expect(
      container.read(withdrawalProvider('withdrawal-1')).value?.status,
      WithdrawalState.manualReview,
    );

    container.read(sessionGenerationProvider.notifier).clearUserScope();
    await _readQueries(container);
    expect(funding.listCalls, 2);
    expect(funding.getCalls, 2);
  });
}

ProviderContainer _container(
  _FundingRepository funding,
  _WalletsRepository wallets,
) {
  final container = ProviderContainer(
    overrides: [
      fundingRepositoryProvider.overrideWithValue(funding),
      walletsRepositoryProvider.overrideWithValue(wallets),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

Future<void> _readQueries(ProviderContainer container) => Future.wait([
  container.read(withdrawalsProvider(null).future),
  container.read(withdrawalProvider('withdrawal-1').future),
]);

WithdrawalIntent _intent() => WithdrawalIntent(
  chain: 'BSC',
  amount: DecimalValue('0.000000000000000001', asset: 'USDC', unit: 'token'),
  address: '0x123',
);

final class _FundingRepository implements FundingRepository {
  final List<String> quoteKeys = [];
  final List<String> withdrawalKeys = [];
  int listCalls = 0;
  int getCalls = 0;

  @override
  Future<WithdrawalQuote> quoteWithdrawal(
    WithdrawalIntent intent, {
    required String idempotencyKey,
  }) async {
    quoteKeys.add(idempotencyKey);
    return WithdrawalQuote(
      quoteId: 'quote-1',
      intent: intent,
      totalFee: DecimalValue('0.1', asset: 'USDC', unit: 'token'),
      estimatedReceive: DecimalValue('0.9', asset: 'USDC', unit: 'token'),
      sufficient: true,
    );
  }

  @override
  Future<Withdrawal> createWithdrawal(
    WithdrawalIntent intent, {
    required String quoteId,
    required String authorizationId,
    required String idempotencyKey,
  }) async {
    withdrawalKeys.add(idempotencyKey);
    return _withdrawal(WithdrawalState.processing);
  }

  @override
  Future<Withdrawal> getWithdrawal(String id) async {
    getCalls++;
    return _withdrawal(WithdrawalState.manualReview);
  }

  @override
  Future<DomainPage<Withdrawal>> listWithdrawals({String? cursor}) async {
    listCalls++;
    return DomainPage(items: [_withdrawal(WithdrawalState.ambiguous)]);
  }

  Withdrawal _withdrawal(WithdrawalState status) => Withdrawal(
    withdrawalId: 'withdrawal-1',
    chain: 'BSC',
    amount: DecimalValue('1', asset: 'USDC', unit: 'token'),
    status: status,
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final class _WalletsRepository implements WalletsRepository {
  final List<String> keys = [];

  @override
  Future<WalletAuthorization> authorizeWithdrawal({
    required String walletId,
    required String quoteId,
    required String amount,
    required String idempotencyKey,
  }) async {
    keys.add(idempotencyKey);
    return WalletAuthorization(
      authorizationId: 'authorization-1',
      walletId: walletId,
      status: WalletAuthorizationState.authorized,
      expiresAt: DateTime.utc(2030),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
