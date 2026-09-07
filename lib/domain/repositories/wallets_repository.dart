import '../models/domain_page.dart';
import '../models/wallet.dart';
import '../models/withdrawal.dart';

abstract interface class WalletsRepository {
  Future<DomainPage<Wallet>> listWallets({String? cursor});
  Future<Wallet> syncWallet({required String idempotencyKey});
  Future<WalletAuthorization> authorizeWithdrawal({
    required String walletId,
    required String quoteId,
    required String amount,
    required String idempotencyKey,
  });
}
