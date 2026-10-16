import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/domain/models/decimal_value.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/portfolio.dart';
import 'package:nobell/domain/models/portfolio_asset.dart';
import 'package:nobell/domain/models/self_custodial_withdrawal.dart';
import 'package:nobell/domain/models/wallet.dart';
import 'package:nobell/domain/models/trading_account.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/domain/repositories/funding_repository.dart';
import 'package:nobell/domain/repositories/portfolio_repository.dart';
import 'package:nobell/domain/repositories/wallets_repository.dart';
import 'package:nobell/ui/features/funding/providers/withdrawal_providers.dart';
import 'package:nobell/ui/features/funding/providers/self_custodial_withdrawal_providers.dart';

void main() {
  test(
    'withdrawal assets merge Spot display data with withdrawal eligibility',
    () async {
      final portfolio = _PortfolioAssetsRepository();
      final container = ProviderContainer(
        overrides: [portfolioRepositoryProvider.overrideWithValue(portfolio)],
      );
      addTearDown(container.dispose);

      final assets = await container.read(withdrawalAssetsProvider.future);

      expect(portfolio.accounts, containsAll(<String?>['spot', null]));
      expect(assets.single.holdingReturnAmountUsd?.value, '16');
      expect(assets.single.holdingReturnPercent?.value, '3');
      expect(assets.single.withdrawable, isTrue);
      expect(assets.single.availableBalance?.value, '1.25');
      expect(assets.single.balance.value, '3.0154');
      expect(assets.single.valueUsd?.value, '550');
    },
  );

  test(
    'picker uses authoritative same-wallet availability, not spot totals',
    () async {
      final portfolio = _PortfolioAssetsRepository(
        spotAssets: [_asset(available: '100')],
        eligibilityAssets: [
          _asset(available: '20'),
          _asset(available: '90', walletId: 'wallet-other'),
          _asset(available: '95', contract: '0x${'44' * 20}'),
        ],
      );
      final container = ProviderContainer(
        overrides: [portfolioRepositoryProvider.overrideWithValue(portfolio)],
      );
      addTearDown(container.dispose);
      final asset = (await container.read(withdrawalAssetsProvider.future))
          .single;
      expect(asset.availableBalance?.value, '20');
      expect(asset.balance.value, '100');
      expect(asset.valueUsd?.value, '100');
      expect(asset.walletId, 'wallet-1');
    },
  );

  test('picker does not borrow another wallet or token eligibility', () async {
    for (final eligibility in [
      _asset(walletId: 'wallet-other'),
      _asset(contract: '0x${'44' * 20}'),
      _asset(network: 'arbitrum'),
    ]) {
      final container = ProviderContainer(
        overrides: [
          portfolioRepositoryProvider.overrideWithValue(
            _PortfolioAssetsRepository(
              spotAssets: [_asset()],
              eligibilityAssets: [eligibility],
            ),
          ),
        ],
      );
      addTearDown(container.dispose);
      expect(await container.read(withdrawalAssetsProvider.future), isEmpty);
    }
  });

  test(
    'picker preserves zero and unknown, and caps availability by spot',
    () async {
      for (final scenario in [
        (asset: _asset(available: '0'), expected: '0'),
        (asset: _asset(available: null), expected: null),
        (asset: _asset(freshness: 'stale'), expected: null),
        (asset: _asset(available: '120', balance: '200'), expected: '100'),
        (
          asset: _asset(available: '20.000000000000000001'),
          expected: '20.000000000000000001',
        ),
      ]) {
        final container = ProviderContainer(
          overrides: [
            portfolioRepositoryProvider.overrideWithValue(
              _PortfolioAssetsRepository(
                spotAssets: [_asset()],
                eligibilityAssets: [scenario.asset],
              ),
            ),
          ],
        );
        addTearDown(container.dispose);
        final asset = (await container.read(withdrawalAssetsProvider.future))
            .single;
        expect(asset.availableBalance?.value, scenario.expected);
        expect(asset.balance.value, '100');
      }
    },
  );

  test(
    'fresh preparation rejects unavailable funds before creating an intent',
    () async {
      for (final asset in [
        _asset(available: '20'),
        _asset(available: '0'),
        _asset(available: null),
        _asset(freshness: 'stale'),
        _asset(status: 'unavailable'),
        _asset(walletId: 'wallet-other', available: '100'),
      ]) {
        final funding = _FundingRepository();
        final container = ProviderContainer(
          overrides: [
            fundingRepositoryProvider.overrideWithValue(funding),
            walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
            portfolioRepositoryProvider.overrideWithValue(
              _PortfolioAssetsRepository(eligibilityAssets: [asset]),
            ),
          ],
        );
        addTearDown(container.dispose);
        await expectLater(
          container
              .read(selfCustodialWithdrawalCommandsProvider)
              .prepare(quote: _selfCustodialQuote('20.000000000000000001')),
          throwsStateError,
        );
        expect(funding.preparedAmounts, isEmpty);
      }
    },
  );

  test(
    'prepare accepts exact availability and refreshes on a new attempt',
    () async {
      final portfolio = _PortfolioAssetsRepository(
        eligibilityAssets: [_asset(available: '20.000000000000000001')],
      );
      final funding = _FundingRepository();
      final container = ProviderContainer(
        overrides: [
          fundingRepositoryProvider.overrideWithValue(funding),
          walletsRepositoryProvider.overrideWithValue(_WalletsRepository()),
          portfolioRepositoryProvider.overrideWithValue(portfolio),
        ],
      );
      addTearDown(container.dispose);
      final commands = container.read(selfCustodialWithdrawalCommandsProvider);
      final quote = _selfCustodialQuote('20.000000000000000001');
      final prepared = await commands.prepare(quote: quote);
      expect(prepared.amount.value, '20.000000000000000001');
      expect(funding.preparedAmounts, ['20.000000000000000001']);
      portfolio.eligibilityAssets = [_asset(available: '0')];
      await expectLater(
        commands.prepare(quote: quote, attempt: 1),
        throwsStateError,
      );
      expect(funding.preparedAmounts, hasLength(1));
    },
  );

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

PortfolioAsset _asset({
  String? available = '20',
  String balance = '100',
  String status = 'complete',
  String freshness = 'live',
  String walletId = 'wallet-1',
  String network = 'BSC',
  String contract = '0x3333333333333333333333333333333333333333',
}) => PortfolioAsset(
  assetId: 'asset-1',
  network: network,
  symbol: 'USDC',
  decimals: 18,
  balance: DecimalValue(balance, asset: 'USDC', unit: 'token'),
  valueUsd: DecimalValue('100', asset: 'USD', unit: 'fiat'),
  availableQuantity: available == null
      ? null
      : DecimalValue(available, asset: 'USDC', unit: 'token'),
  availabilityStatus: status,
  freshness: freshness,
  withdrawable: true,
  walletId: walletId,
  contractAddress: contract,
);

WithdrawalQuote _selfCustodialQuote(String amount) => WithdrawalQuote(
  quoteId: 'self-custodial-local',
  intent: WithdrawalIntent(
    chain: 'BSC',
    amount: DecimalValue(amount, asset: 'USDC', unit: 'token'),
    address: '0x1111111111111111111111111111111111111111',
  ),
  totalFee: DecimalValue('0', asset: 'USDC', unit: 'token'),
  estimatedReceive: DecimalValue(amount, asset: 'USDC', unit: 'token'),
  sufficient: true,
);

final class _FundingRepository implements FundingRepository {
  final List<String> quoteKeys = [];
  final List<String> withdrawalKeys = [];
  final preparedAmounts = <String>[];

  @override
  Future<PreparedSelfCustodialWithdrawal> createSelfCustodialWithdrawal({
    required String walletId,
    required String assetId,
    required String chain,
    required String amount,
    required String destinationAddress,
    required String idempotencyKey,
  }) async {
    preparedAmounts.add(amount);
    return PreparedSelfCustodialWithdrawal(
      withdrawalId: 'withdrawal-1',
      sourceWalletId: walletId,
      assetId: assetId,
      assetSymbol: 'USDC',
      chain: chain,
      amount: DecimalValue(amount, asset: 'USDC', unit: 'token'),
      destinationAddress: destinationAddress,
      transaction: SelfCustodialWithdrawalTransaction(
        chainId: 56,
        from: '0x2222222222222222222222222222222222222222',
        to: '0x3333333333333333333333333333333333333333',
        data: '0xa9059cbb',
        value: '0x0',
        payloadHash: '0xpayload',
        validUntil: DateTime.now().toUtc().add(const Duration(minutes: 5)),
      ),
      status: SelfCustodialWithdrawalState.awaitingSubmission,
    );
  }

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
  Future<DomainPage<Wallet>> listWallets({String? cursor}) async => DomainPage(
    items: [
      Wallet(
        walletId: 'wallet-1',
        address: '0x2222222222222222222222222222222222222222',
        chain: 'BSC',
        status: WalletState.active,
        createdAt: DateTime.utc(2026),
      ),
    ],
  );

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

final class _PortfolioAssetsRepository
    implements PortfolioRepository, PortfolioAssetsRepository {
  _PortfolioAssetsRepository({this.spotAssets, this.eligibilityAssets});

  final List<PortfolioAsset>? spotAssets;
  List<PortfolioAsset>? eligibilityAssets;
  final accounts = <String?>[];

  @override
  Future<List<PortfolioAsset>> listAssets({
    String? cursor,
    String? productId,
    String? account,
  }) async {
    accounts.add(account);
    final configured = account == 'spot' ? spotAssets : eligibilityAssets;
    if (configured != null) return configured;
    return [
      PortfolioAsset(
        assetId: 'asset-1',
        network: 'BSC',
        symbol: 'NVDAB',
        decimals: 18,
        balance: DecimalValue('3.0154', asset: 'NVDAB', unit: 'token'),
        walletId: 'wallet-1',
        contractAddress: '0x3333333333333333333333333333333333333333',
        availableQuantity: account == null
            ? DecimalValue('1.25', asset: 'NVDAB', unit: 'token')
            : null,
        availabilityStatus: account == null ? 'complete' : null,
        valueUsd: account == 'spot'
            ? DecimalValue('550', asset: 'USD', unit: 'fiat')
            : null,
        withdrawable: account == null,
        productId: account == 'spot' ? 'bstocks:nvdab' : null,
        holdingReturnAmountUsd: account == 'spot'
            ? DecimalValue('16', asset: 'USD', unit: 'fiat')
            : null,
        holdingReturnPercent: account == 'spot'
            ? DecimalValue('3', unit: 'percent')
            : null,
      ),
    ];
  }

  @override
  Future<Portfolio> getSummary() => throw UnimplementedError();

  @override
  Future<List<TradingAccount>> listAccounts() => throw UnimplementedError();

  @override
  Future<DomainPage<HoldingGroup>> listHoldings({String? cursor}) =>
      throw UnimplementedError();
}
