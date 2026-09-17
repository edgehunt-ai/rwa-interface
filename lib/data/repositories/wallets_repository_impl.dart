import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/domain_page.dart';
import '../../domain/models/wallet.dart';
import '../../domain/models/withdrawal.dart';
import '../../domain/repositories/wallets_repository.dart';
import '../services/wallets_service.dart';
import '../mappers/chain_name_mapper.dart';

final class WalletsRepositoryImpl implements WalletsRepository {
  WalletsRepositoryImpl(this._service);

  final WalletsService _service;

  @override
  Future<DomainPage<Wallet>> listWallets({String? cursor}) async {
    final page = await _service.listWallets(cursor: cursor);
    return DomainPage(
      items: page.items.map(_mapWallet).toList(),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<Wallet> syncWallet({required String idempotencyKey}) async =>
      _mapWallet(await _service.syncWallet(idempotencyKey: idempotencyKey));

  @override
  Future<WalletAuthorization> authorizeWithdrawal({
    required String walletId,
    required String quoteId,
    required String amount,
    required String idempotencyKey,
  }) async {
    final value = await _service.createAuthorization(
      walletId,
      api.WalletAuthorizationRequest(
        (request) => request
          ..purpose = api.WalletAuthorizationRequestPurposeEnum.withdrawal
          ..asset = 'USDC'
          ..amount = amount
          ..resourceId = quoteId,
      ),
      idempotencyKey: idempotencyKey,
    );
    return WalletAuthorization(
      authorizationId: value.authorizationId,
      walletId: value.walletId,
      status: switch (value.status) {
        api.WalletAuthorizationStatusEnum.pending =>
          WalletAuthorizationState.pending,
        api.WalletAuthorizationStatusEnum.authorized =>
          WalletAuthorizationState.authorized,
        api.WalletAuthorizationStatusEnum.consumed =>
          WalletAuthorizationState.consumed,
        api.WalletAuthorizationStatusEnum.expired =>
          WalletAuthorizationState.expired,
        api.WalletAuthorizationStatusEnum.failed =>
          WalletAuthorizationState.failed,
        _ => WalletAuthorizationState.unknown,
      },
      expiresAt: value.expiresAt.toUtc(),
    );
  }

  @override
  Future<WalletAuthorization> authorizeFundingTransfer({
    required String walletId,
    required String planId,
    required String asset,
    required String maximumAmount,
    required String idempotencyKey,
  }) async => _authorization(
    await _service.createAuthorization(
      walletId,
      api.WalletAuthorizationRequest(
        (request) => request
          ..purpose = api.WalletAuthorizationRequestPurposeEnum.transfer
          ..asset = asset
          ..amount = maximumAmount
          ..resourceId = planId,
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  WalletAuthorization _authorization(api.WalletAuthorization value) =>
      WalletAuthorization(
        authorizationId: value.authorizationId,
        walletId: value.walletId,
        status: switch (value.status) {
          api.WalletAuthorizationStatusEnum.pending =>
            WalletAuthorizationState.pending,
          api.WalletAuthorizationStatusEnum.authorized =>
            WalletAuthorizationState.authorized,
          api.WalletAuthorizationStatusEnum.consumed =>
            WalletAuthorizationState.consumed,
          api.WalletAuthorizationStatusEnum.expired =>
            WalletAuthorizationState.expired,
          api.WalletAuthorizationStatusEnum.failed =>
            WalletAuthorizationState.failed,
          _ => WalletAuthorizationState.unknown,
        },
        expiresAt: value.expiresAt.toUtc(),
      );

  Wallet _mapWallet(api.Wallet value) => Wallet(
    walletId: value.walletId,
    address: value.address,
    chain: canonicalChainName(value.chain.name),
    status: switch (value.status) {
      api.WalletStatus.active => WalletState.active,
      api.WalletStatus.verificationRequired => WalletState.verificationRequired,
      api.WalletStatus.disabled => WalletState.disabled,
      _ => WalletState.unknown,
    },
    createdAt: value.createdAt.toUtc(),
  );
}
