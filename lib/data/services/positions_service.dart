import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class PositionsService {
  Future<api.PositionPage> listPositions({
    String? symbol,
    api.ProductKind? kind,
    String? cursor,
  });
  Future<api.Position> getPosition(String positionId);
  Future<api.Position> updateTpSl(
    String positionId,
    api.TpSlUpdateRequest request, {
    required String idempotencyKey,
  });
  Future<api.Position> clearTpSl(
    String positionId, {
    required String idempotencyKey,
  });
  Future<api.Position> updateLeverage(
    String positionId,
    api.UpdatePositionLeverageRequest request, {
    required String idempotencyKey,
  });
  Future<api.Order> closePosition(
    String positionId,
    api.ClosePositionRequest request, {
    required String idempotencyKey,
  });
}
