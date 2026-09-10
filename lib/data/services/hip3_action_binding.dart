import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/services/hip3_typed_data_signer.dart';

/// Frozen client intent. Validate every create, poll and submission response
/// before using it to request a wallet signature or report success.
final class Hip3ActionBinding {
  const Hip3ActionBinding({
    required this.intent,
    required this.operation,
    required this.productId,
    required this.environment,
    this.positionId,
    this.orderId,
  });

  final api.Hip3ActionCreateRequest intent;
  final api.Hip3Operation operation;
  final String productId;
  final api.Hip3Environment environment;
  final String? positionId;
  final String? orderId;

  void validate(api.Hip3Action action, {String? expectedActionId}) {
    if (action.actionId.isEmpty ||
        (expectedActionId != null && action.actionId != expectedActionId) ||
        action.intent != intent ||
        action.operation != operation ||
        action.productId != productId ||
        action.environment != environment ||
        (positionId != null && action.positionId != positionId) ||
        (orderId != null && action.orderId != orderId)) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
  }
}
