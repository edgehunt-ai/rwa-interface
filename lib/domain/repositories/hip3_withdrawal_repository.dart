import '../models/hip3_withdrawal.dart';

abstract interface class Hip3WithdrawalRepository {
  Future<Hip3Withdrawal> create({
    required String amount,
    required String idempotencyKey,
  });

  Future<Hip3Withdrawal> signAndSubmit(
    Hip3Withdrawal prepared, {
    required String idempotencyKey,
  });

  Future<Hip3Withdrawal> get(String id);
}
