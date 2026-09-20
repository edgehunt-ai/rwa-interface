import '../models/hip3_account_abstraction.dart';

abstract interface class Hip3AccountAbstractionRepository {
  Future<Hip3AccountAbstractionStatus> getStatus();

  Future<Hip3AccountAbstractionStatus> switchToUnifiedAccount({
    required String prepareIdempotencyKey,
    required String executeIdempotencyKey,
  });
}
