import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app_review/app_review.dart';
import 'package:nobell/domain/models/api_failure.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/wallet.dart';
import 'package:nobell/domain/models/withdrawal.dart';
import 'package:nobell/domain/repositories/wallets_repository.dart';
import 'package:nobell/ui/features/funding/providers/deposit_providers.dart';

import '../helpers/controlled_api_adapter.dart';
import '../helpers/trading_provider_harness.dart';

void main() {
  test(
    'review wallet registration failure is preserved for login recovery',
    () async {
      const failure = ServerFailure(
        statusCode: 422,
        code: 'wallet_not_verified',
        message: 'Embedded wallet verification is pending',
      );
      final live = _Wallets()..failure = failure;
      final repository = AppReviewWalletsRepository(
        AppReviewStore(),
        readDelegate: live,
      );
      await expectLater(
        repository.syncWallet(idempotencyKey: 'login-sync'),
        throwsA(same(failure)),
      );
      live.failure = null;
      expect(
        (await repository.syncWallet(idempotencyKey: 'login-sync')).walletId,
        'real-wallet',
      );
      expect(live.syncKeys, ['login-sync', 'login-sync']);
      final page = await repository.listWallets();
      expect(page.items.single.walletId, 'review-wallet');
    },
  );

  test(
    'review financial authorizations stay local with a live wallet delegate',
    () async {
      final live = _Wallets();
      final repository = AppReviewWalletsRepository(
        AppReviewStore(),
        readDelegate: live,
      );
      final withdrawal = await repository.authorizeWithdrawal(
        walletId: 'real-wallet',
        quoteId: 'quote',
        amount: '25',
        idempotencyKey: 'withdraw',
      );
      final transfer = await repository.authorizeFundingTransfer(
        walletId: 'real-wallet',
        planId: 'plan',
        asset: 'USDC',
        maximumAmount: '50',
        idempotencyKey: 'transfer',
      );
      expect(withdrawal.status, WalletAuthorizationState.authorized);
      expect(transfer.status, WalletAuthorizationState.authorized);
      expect(withdrawal.walletId, 'real-wallet');
      expect(transfer.walletId, 'real-wallet');
      expect(live.authorizationCalls, 0);
    },
  );

  test('review providers register the real wallet before reading live deposit routes', () async {
    final container = createTradingProviderContainer();
    container.read(appReviewModeProvider.notifier).setEnabled(true);
    final source = container.read(apiDataSourceProvider);
    final adapter = ControlledApiAdapter([
      ControlledResponse.json(
        method: 'POST',
        path: '/v1/me/wallets/sync',
        statusCode: 200,
        body: _walletJson,
      ),
      ControlledResponse.json(
        method: 'GET',
        path: '/v1/deposit-instructions',
        statusCode: 200,
        body: {
          'catalog_version': '2026-09-01.v1',
          'updated_at': '2026-10-21T03:00:00Z',
          'wallet': {
            'wallet_id': 'real-wallet',
            'address': _address,
            'custody': 'embedded_wallet',
          },
          'items': [
            {
              'availability': {'status': 'available', 'blockers': <String>[]},
              'confirmations_required': 20,
              'credited_to': 'wallet',
              'estimated_arrival_seconds': 30,
              'identity': {
                'asset_id': 'eip155:42161/erc20:$_usdc',
                'chain_id': 42161,
                'namespace': 'eip155',
                'network': 'Arbitrum',
                'provenance': 'circle_native',
                'token': 'USDC',
                'token_contract': _usdc,
                'token_decimals': 6,
              },
              'min_deposit': '1',
              'qr_payload': _address,
              'warning': 'Only send USDC on Arbitrum.',
            },
          ],
        },
      ),
    ]);
    source.dio.httpClientAdapter = adapter;
    final wallets = container.read(walletsRepositoryProvider);
    expect(wallets, isA<AppReviewWalletsRepository>());
    expect(
      (await wallets.syncWallet(idempotencyKey: 'login-wallet-sync')).walletId,
      'real-wallet',
    );
    expect(
      (await wallets.listWallets()).items.single.walletId,
      'review-wallet',
    );
    final routesSubscription = container.listen(
      depositRoutesProvider,
      (_, _) {},
    );
    addTearDown(routesSubscription.close);
    final routes = await container.read(depositRoutesProvider.future);
    expect(routes.single.chain, 'Arbitrum');
    expect(routes.single.token, 'USDC');
    final instruction = await container.read(
      depositInstructionProvider((chain: 'Arbitrum', token: 'USDC')).future,
    );
    expect(instruction.address, _address);
    final directorySnapshot = container.read(depositDirectoryProvider);
    container.read(appReviewDepositCommandsProvider).addDemoFunds();
    await container.pump();
    expect(container.read(depositDirectoryProvider), same(directorySnapshot));
    expect(
      (await container.read(depositRoutesProvider.future)).single.token,
      'USDC',
    );
    expect(adapter.requests.map((r) => '${r.method} ${r.path}'), [
      'POST /v1/me/wallets/sync',
      'GET /v1/deposit-instructions',
    ]);
    expect(
      adapter.requests.first.headers['idempotency-key'],
      'login-wallet-sync',
    );
  }, skip: !AppReviewConfiguration.buildEnabled);
}

const _address = '0x09920a496942e7aa8c9adabf97cdf035524248c1';
const _usdc = '0xaf88d065e77c8cc2239327c5edb3a432268e5831';
const _walletJson = {
  'wallet_id': 'real-wallet',
  'address': _address,
  'chain': 'Arbitrum',
  'status': 'active',
  'created_at': '2026-10-21T03:00:00Z',
};

final class _Wallets implements WalletsRepository {
  ApiFailure? failure;
  final syncKeys = <String>[];
  String? cursor;
  int authorizationCalls = 0;
  Wallet get wallet => Wallet(
    walletId: 'real-wallet',
    address: _address,
    chain: 'arbitrum',
    status: WalletState.active,
    createdAt: DateTime.utc(2026, 10, 21),
  );

  @override
  Future<Wallet> syncWallet({required String idempotencyKey}) async {
    syncKeys.add(idempotencyKey);
    if (failure case final failure?) throw failure;
    return wallet;
  }

  @override
  Future<DomainPage<Wallet>> listWallets({String? cursor}) async {
    this.cursor = cursor;
    return DomainPage(items: [wallet]);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    authorizationCalls++;
    throw StateError('Financial authorization must not reach the backend');
  }
}
