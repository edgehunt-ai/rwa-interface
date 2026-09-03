import 'package:test/test.dart';
import 'package:rwa_api_client/rwa_api_client.dart';


/// tests for WalletsApi
void main() {
  final instance = RwaApiClient().getWalletsApi();

  group(WalletsApi, () {
    // 创建一次性钱包授权
    //
    //Future<WalletAuthorization> createWalletAuthorization(String walletId, String idempotencyKey, WalletAuthorizationRequest walletAuthorizationRequest) async
    test('test createWalletAuthorization', () async {
      // TODO
    });

    // 列出当前用户钱包
    //
    //Future<ListWallets200Response> listWallets({ String cursor, int limit }) async
    test('test listWallets', () async {
      // TODO
    });

    // 从 Privy 权威账户同步主钱包
    //
    //Future<Wallet> syncWallet(String idempotencyKey) async
    test('test syncWallet', () async {
      // TODO
    });

  });
}
