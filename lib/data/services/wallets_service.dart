import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class WalletsService {
  Future<api.WalletPage> listWallets({String? cursor});
  Future<api.Wallet> syncWallet({required String idempotencyKey});
  Future<api.WalletAuthorization> createAuthorization(
    String walletId,
    api.WalletAuthorizationRequest request, {
    required String idempotencyKey,
  });
}
