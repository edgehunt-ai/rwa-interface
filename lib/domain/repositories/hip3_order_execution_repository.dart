import '../models/order.dart';
import '../models/resource_result.dart';

abstract interface class Hip3OrderExecutionRepository {
  /// Waits for the server-frozen action, asks the exact wallet to sign it, and
  /// submits only r/s/v. The backend remains responsible for broadcasting.
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(String orderId);
}
