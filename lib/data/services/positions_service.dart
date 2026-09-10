import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class PositionsService {
  Future<api.PositionPage> listPositions({
    String? symbol,
    api.ProductKind? kind,
    String? cursor,
  });
  Future<api.Position> getPosition(String positionId);
  Future<api.Hip3TradingContext> getHip3TradingContext(String productId);
  Future<api.Position> updateTpSl(
    api.Hip3SetTpSlActionRequest request, {
    required String idempotencyKey,
  });
  Future<api.Position> clearTpSl(
    api.Hip3ClearTpSlActionRequest request, {
    required String idempotencyKey,
  });
  Future<api.Position> updateLeverage(
    String positionId,
    api.Hip3SetLeverageActionRequest request, {
    required String idempotencyKey,
  });
  Future<api.Order> closePosition(
    String positionId,
    api.Hip3ClosePreviewRequest request, {
    required String idempotencyKey,
  });
}
