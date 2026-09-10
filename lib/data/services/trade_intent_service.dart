import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class TradeIntentService {
  Future<api.TradeIntent> create(
    api.TradeIntentCreateRequest request, {
    required String idempotencyKey,
  });
  Future<api.TradeIntent?> getCurrent();
  Future<api.TradeIntent> get(String tradeIntentId);
  Future<api.TradeIntent> cancel(
    String tradeIntentId, {
    required String idempotencyKey,
  });
}
