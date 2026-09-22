import '../models/order.dart';
import '../models/order_intent.dart';
import '../models/resource_result.dart';

abstract interface class BstocksOrderExecutionRepository {
  Future<ResourceResult<TradingOrder>> execute({
    required OrderIntent intent,
    required ResourceResult<TradingOrder> created,
    required String previewId,
    bool Function()? isCancelled,
  });
}
