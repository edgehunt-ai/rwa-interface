import '../models/hip3_withdrawal.dart';
import '../models/hip3_withdrawal_preview.dart';

abstract interface class Hip3WithdrawalRepository {
  Future<Hip3WithdrawalPreview> preview({required String amount});

  Future<Hip3Withdrawal> create({
    required String amount,
    required String rail,
    required String idempotencyKey,
  });

  Future<Hip3Withdrawal> signAndSubmit(
    Hip3Withdrawal prepared, {
    required String idempotencyKey,
  });

  Future<Hip3Withdrawal> get(String id);
}
