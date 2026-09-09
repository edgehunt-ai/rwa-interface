import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/hip3_step_confirmation.dart';

Hip3StepConfirmation mapHip3StepConfirmation(
  api.Hip3Action action,
  api.Hip3ActionStep step,
) {
  final details = <String, String>{};
  void flatten(Object? value, String prefix) {
    if (value is Map) {
      for (final entry in value.entries) {
        flatten(
          entry.value,
          prefix.isEmpty ? entry.key.toString() : '$prefix.${entry.key}',
        );
      }
    } else if (value is String || value is num || value is bool) {
      details[prefix] = value.toString();
    }
  }

  // Only business schemas are serialized. The opaque EIP-712 payload is not
  // sufficient user consent and must not escape the signing data boundary.
  flatten(
    api.standardSerializers.serializeWith(
      api.Hip3ActionCreateRequest.serializer,
      action.intent,
    ),
    'intent',
  );
  if (step.normalizedProtection case final protection?) {
    flatten(
      api.standardSerializers.serializeWith(
        api.Hip3ProtectionSpec.serializer,
        protection,
      ),
      'normalized_protection',
    );
  }
  if (action.closePreview case final preview?) {
    flatten(
      api.standardSerializers.serializeWith(
        api.Hip3ClosePreview.serializer,
        preview,
      ),
      'close_preview',
    );
  }
  return Hip3StepConfirmation(
    actionId: action.actionId,
    stepId: step.stepId,
    productId: action.productId,
    operation: action.operation.name,
    stepKind: step.kind.name,
    validUntil: step.signing!.validUntil.toUtc(),
    details: Map.unmodifiable(details),
  );
}
