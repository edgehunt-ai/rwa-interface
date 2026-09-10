import '../models/order.dart';
import '../models/resource_result.dart';
import '../models/domain_page.dart';
import '../models/hip3_action_summary.dart';

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
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    required String idempotencyKey,
  });
}

/// Submission may already have reached the venue. Recover this order; never create a replacement.
final class Hip3ExecutionPending implements Exception {
  const Hip3ExecutionPending(
    this.orderId,
    this.actionId, {
    this.requiresReview = false,
  });
  final String orderId;
  final String actionId;
  final bool requiresReview;
}
