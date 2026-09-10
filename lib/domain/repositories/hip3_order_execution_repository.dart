import '../models/order.dart';
import '../models/resource_result.dart';
import '../models/domain_page.dart';

abstract interface class Hip3OrderExecutionRepository {
  /// Waits for the server-frozen action, asks the exact wallet to sign it, and
  /// submits only r/s/v. The backend remains responsible for broadcasting.
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(String orderId);
  Future<DomainPage<Hip3ActionSummary>> listActions({String? cursor});
  Future<Hip3ActionSummary> getAction(String actionId);
  Future<Hip3ActionSummary> cancelAction(
    String actionId, {
    required String idempotencyKey,
  });
}
