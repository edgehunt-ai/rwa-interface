import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../../domain/models/hip3_action_pending.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import 'hip3_action_binding.dart';
import 'hip3_position_action_service.dart';

/// Session-scoped executor. The repository maps each frozen step to a domain
/// confirmation before invoking [confirm]; generated types stay in data code.
final class Hip3PositionActionExecutor {
  Hip3PositionActionExecutor(
    this._service,
    this._signer, {
    DateTime Function()? now,
    Future<void> Function(Duration)? delay,
    bool Function()? isActive,
  }) : _now = now ?? DateTime.now,
       _delay = delay ?? Future<void>.delayed,
       _isActive = isActive ?? (() => true);

  final Hip3PositionActionService _service;
  final Hip3TypedDataSigner _signer;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _delay;
  final bool Function() _isActive;
  final Map<String, api.Hip3StepSigningPayload> _payloads = {};
  final Map<String, Hip3RsvSignature> _signatures = {};
  final Set<String> _running = {};

  Future<api.Hip3Action> resume({
    required String actionId,
    required Hip3ActionBinding binding,
    required Future<bool> Function(api.Hip3Action, api.Hip3ActionStep) confirm,
  }) async {
    // Do not silently share a running task with a different confirmation intent.
    if (!_running.add(actionId)) throw Hip3ActionPending(actionId);
    try {
      // Always fetch on entry: a prior signature may already have been submitted.
      var current = await _read(actionId);
      for (var attempt = 0; attempt < 30; attempt++) {
        _checkSession(actionId);
        binding.validate(current, expectedActionId: actionId);
        switch (current.status) {
          case api.Hip3ActionStatus.succeeded:
            return current;
          case api.Hip3ActionStatus.manualReview:
            throw Hip3ActionPending(actionId, requiresReview: true);
          case api.Hip3ActionStatus.expired:
            throw const Hip3SigningFailure(
              Hip3SigningFailureCode.actionExpired,
            );
          case api.Hip3ActionStatus.failed:
          case api.Hip3ActionStatus.cancelled:
          case api.Hip3ActionStatus.unknownDefaultOpenApi:
            throw const Hip3SigningFailure(
              Hip3SigningFailureCode.invalidPayload,
            );
          default:
            break;
        }
        if (current.status == api.Hip3ActionStatus.awaitingSignature) {
          final candidates = current.steps
              .where((s) => s.stepId == current.currentStepId)
              .toList();
          if (candidates.length != 1 ||
              candidates.single.status !=
                  api.Hip3ActionStepStatusEnum.prepared ||
              candidates.single.signing == null) {
            throw const Hip3SigningFailure(
              Hip3SigningFailureCode.invalidPayload,
            );
          }
          final step = candidates.single;
          if (step.kind == api.Hip3ActionStepKindEnum.unknownDefaultOpenApi ||
              ((step.kind == api.Hip3ActionStepKindEnum.placeTakeProfit ||
                      step.kind == api.Hip3ActionStepKindEnum.placeStopLoss) &&
                  step.normalizedProtection == null)) {
            throw const Hip3SigningFailure(
              Hip3SigningFailureCode.invalidPayload,
            );
          }
          final signing = step.signing!;
          final key = '$actionId:${step.stepId}';
          if ((_payloads[key] != null && _payloads[key] != signing) ||
              signing.signingMethod !=
                  api
                      .Hip3StepSigningPayloadSigningMethodEnum
                      .ethSignTypedDataV4 ||
              signing.signatureFormat !=
                  api.Hip3StepSigningPayloadSignatureFormatEnum.rSV) {
            throw const Hip3SigningFailure(
              Hip3SigningFailureCode.invalidPayload,
            );
          }
          _payloads[key] = signing;
          _checkExpiry(signing);
          var signature = _signatures[key];
          if (signature == null) {
            if (!await confirm(current, step)) {
              throw const Hip3SigningFailure(Hip3SigningFailureCode.rejected);
            }
            _checkSession(actionId);
            _checkExpiry(signing);
            final typed = api.standardSerializers.serializeWith(
              api.Hip3Eip712TypedData.serializer,
              signing.signingTypedData,
            );
            if (typed is! Map) {
              throw const Hip3SigningFailure(
                Hip3SigningFailureCode.invalidPayload,
              );
            }
            signature = Hip3RsvSignature.fromCompactHex(
              await _signer.signTypedDataV4(
                expectedSigner: signing.expectedSigner,
                typedData: typed.map(
                  (k, v) => MapEntry(k.toString(), v as Object?),
                ),
              ),
            );
            _signatures[key] = signature;
          }
          _checkSession(actionId);
          _checkExpiry(signing);
          try {
            current = await _service.submit(
              actionId,
              step.stepId,
              api.Hip3ActionSubmissionRequest(
                (b) => b.signature
                  ..r = signature!.r
                  ..s = signature.s
                  ..v = signature.v == 27
                      ? api.HyperliquidSignatureVEnum.number27
                      : api.HyperliquidSignatureVEnum.number28,
              ),
              'hip3-action-$actionId-${step.stepId}',
            );
            continue;
          } on ApiFailure catch (failure) {
            if (!_transient(failure)) rethrow;
            // Never retry from a stale prepared snapshot after a lost response.
          }
        }
        await _delay(const Duration(milliseconds: 500));
        current = await _read(actionId);
      }
      throw Hip3ActionPending(actionId);
    } finally {
      _running.remove(actionId);
    }
  }

  void _checkExpiry(api.Hip3StepSigningPayload signing) {
    if (!signing.validUntil.toUtc().isAfter(_now().toUtc())) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.actionExpired);
    }
  }

  Future<api.Hip3Action> _read(String actionId) async {
    for (var retry = 0; retry < 3; retry++) {
      _checkSession(actionId);
      try {
        return await _service.get(actionId);
      } on ApiFailure catch (failure) {
        if (!_transient(failure)) rethrow;
        await _delay(const Duration(milliseconds: 500));
      }
    }
    throw Hip3ActionPending(actionId);
  }

  void _checkSession(String actionId) {
    if (!_isActive()) {
      _signatures.clear();
      _payloads.clear();
      throw Hip3ActionPending(actionId);
    }
  }

  bool _transient(ApiFailure failure) =>
      failure is NetworkFailure ||
      failure is TimeoutFailure ||
      (failure is ServerFailure &&
          failure.retryable &&
          (failure.statusCode == 429 || failure.statusCode >= 500));
}
