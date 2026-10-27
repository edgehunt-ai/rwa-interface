import '../../domain/models/api_failure.dart';
import '../../domain/models/hip3_action_pending.dart';
import '../../domain/models/hip3_withdrawal_preview.dart';
import '../../domain/repositories/hip3_order_execution_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';

/// Stable diagnostics for domain exceptions whose runtime names are obfuscated
/// in release builds. Resource IDs belong in context, never in fingerprints.
typedef BusinessFailureDiagnostics = ({
  String type,
  String classifier,
  String message,
  Map<String, String> context,
});

BusinessFailureDiagnostics? businessFailureDiagnostics(Object? error) {
  switch (error) {
    case Hip3ExecutionPending():
      final failure = error.failure;
      final fallback = error.requiresReview
          ? 'Order execution requires review before continuing.'
          : 'Order execution is awaiting confirmation.';
      return (
        type: 'Hip3ExecutionPending',
        classifier: error.requiresReview ? 'manual_review' : 'pending',
        message:
            _reason(error.reason) ??
            (failure == null
                ? fallback
                : apiFailureMessage(failure, fallback: fallback)),
        context: {
          'order_id': error.orderId,
          'action_id': error.actionId,
          'requires_review': error.requiresReview.toString(),
          'request_id': ?failure?.requestId,
          if (failure case ServerFailure(:final statusCode, :final code)) ...{
            'http_status': statusCode.toString(),
            'api_code': code,
          },
        },
      );
    case Hip3ActionPending():
      return (
        type: 'Hip3ActionPending',
        classifier: error.requiresReview ? 'manual_review' : 'pending',
        message: error.requiresReview
            ? 'Action requires review before continuing.'
            : 'Action is awaiting confirmation.',
        context: {
          'action_id': error.actionId,
          'requires_review': error.requiresReview.toString(),
        },
      );
    case Hip3WithdrawalQuoteChanged():
      return (
        type: 'Hip3WithdrawalQuoteChanged',
        classifier: 'quote_changed',
        message: 'Withdrawal quote changed. Refresh and review before signing.',
        context: const {},
      );
    case Hip3SigningFailure():
      return (
        type: 'Hip3SigningFailure',
        classifier: error.code.name,
        message: _reason(error.reason) ?? 'Signing failed: ${error.code.name}.',
        context: {
          'failure_code': error.failureCode ?? error.code.name,
          'retryable': error.retryable.toString(),
        },
      );
    default:
      return null;
  }
}

String? _reason(String? value) =>
    value == null || value.trim().isEmpty ? null : value.trim();
