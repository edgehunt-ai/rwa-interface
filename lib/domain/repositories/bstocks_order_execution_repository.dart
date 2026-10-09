import '../models/order.dart';
import '../models/order_intent.dart';
import '../models/resource_result.dart';

abstract interface class BstocksOrderExecutionRepository {
  Future<ResourceResult<TradingOrder>> execute({
    required OrderIntent intent,
    required ResourceResult<TradingOrder> created,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  });

  Future<ResourceResult<TradingOrder>> continueOrder({
    required OrderIntent intent,
    required String orderId,
    required String previewId,
    bool Function()? isCancelled,
    bool stopAfterApproval = false,
  });

  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    bool Function()? isCancelled,
  });

  Future<ResourceResult<TradingOrder>> executeExisting({
    required ResourceResult<TradingOrder> order,
    bool Function()? isCancelled,
  });
}
