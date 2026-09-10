import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class PositionsService {
  Future<api.PositionPage> listPositions({
    String? symbol,
    api.ProductKind? kind,
    String? cursor,
  });
  Future<api.Position> getPosition(String positionId);
}
