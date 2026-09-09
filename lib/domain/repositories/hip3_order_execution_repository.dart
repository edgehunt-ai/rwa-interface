import '../models/hip3_order_action.dart';

abstract interface class Hip3OrderExecutionRepository {
  /// Polls the authoritative order until preflight has produced a frozen
  /// action, asks the wallet to sign it, then submits only `{r,s,v}`.
  Future<Hip3SubmissionResult> awaitActionAndSubmit({
    required String orderId,
    required String idempotencyKey,
  });

  Future<Hip3SubmissionResult> signAndSubmit(
    Hip3OrderAction action, {
    required String idempotencyKey,
  });
}
