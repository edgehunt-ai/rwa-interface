import '../models/hip3_opening_context.dart';
import '../models/order_intent.dart';

abstract interface class Hip3OpeningRepository {
  Future<Hip3OpeningContext> context(String productOrSymbol);
  Future<Hip3OpeningContext> setLeverage(
    String productId,
    int leverage,
    TradingMarginMode mode, {
    required String idempotencyKey,
  });
}
