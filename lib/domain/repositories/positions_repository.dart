import '../models/domain_page.dart';
import '../models/market_product.dart';
import '../models/order.dart';
import '../models/position.dart';
import '../models/position_operation.dart';
import '../models/order_intent.dart';
import '../models/hip3_action_summary.dart';
import '../models/position_leverage_context.dart';

abstract interface class PositionsRepository {
  Future<PositionLeverageContext> leverageContext(String productId);
  Future<DomainPage<Hip3ActionSummary>> activeHip3Actions({String? cursor});

  /// Recover a server-persisted HIP3 workflow without creating another action.
  Future<void> resumeHip3Action(String actionId);
  Future<DomainPage<Position>> list({
    String? symbol,
    MarketProductKind? kind,
    String? cursor,
  });
  Future<Position> get(String positionId);
  Future<Position> updateTpSl(
    Position position, {
    String? takeProfit,
    String? takeLimit,
    String? stopLoss,
    String? stopLimit,
    String? quantity,
    ProtectionClearScope? clearScope,
    required String idempotencyKey,
  });
  Future<Position> clearTpSl(
    String positionId, {
    ProtectionClearScope scope = ProtectionClearScope.both,
    required String idempotencyKey,
  });
  Future<Position> updateLeverage(
    Position position, {
    required String leverage,
    required String idempotencyKey,
  });
  Future<TradingOrder> close(
    String positionId, {
    String? quantity,
    String? percent,
    TradingOrderType type = TradingOrderType.market,
    String? limitPrice,
    Position? expectedPosition,
    required String idempotencyKey,
  });
}
