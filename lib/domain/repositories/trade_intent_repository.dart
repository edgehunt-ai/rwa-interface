import '../models/trade_intent.dart';

abstract interface class TradeIntentRepository {
  Future<TradeIntent> create(
    TradeIntentCreateInput input, {
    required String idempotencyKey,
  });
  Future<TradeIntent?> getCurrent();
  Future<TradeIntent> get(String tradeIntentId);
  Future<TradeIntent> cancel(
    String tradeIntentId, {
    required String idempotencyKey,
  });
}
