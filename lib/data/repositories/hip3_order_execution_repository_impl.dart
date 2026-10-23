import '../services/hip3_action_mapper.dart';

import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/domain_page.dart';
import '../../domain/models/hip3_action_summary.dart';
import '../../domain/models/order.dart';
import '../../domain/models/api_failure.dart';
import '../../domain/models/resource_result.dart';
import '../../domain/repositories/hip3_order_execution_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../services/hip3_order_action_service.dart';
import '../api/idempotency_key.dart';
import 'orders_repository_impl.dart';

final class Hip3OrderExecutionRepositoryImpl
    implements Hip3OrderExecutionRepository {
  Hip3OrderExecutionRepositoryImpl(
    this._signer,
    this._service, {
    DateTime Function()? now,
    Future<void> Function(Duration)? delay,
    bool Function()? isCancelled,
  }) : _now = now ?? DateTime.now,
       _delay = delay ?? Future<void>.delayed,
       _isCancelled = isCancelled ?? (() => false);

  final Hip3TypedDataSigner _signer;
  final Hip3OrderActionService _service;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _delay;
  final bool Function() _isCancelled;
  final Map<String, Hip3RsvSignature> _signatures = {};
  final Map<String, Future<ResourceResult<TradingOrder>>> _inFlight = {};

  @override
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(String orderId) =>
      _execute(
        orderId,
        cancel: false,
        key: scopedIdempotencyKey('hip3-action-create-$orderId'),
      );

  @override
  Future<ResourceResult<TradingOrder>> cancelOrder(
    String orderId, {
    required String idempotencyKey,
  }) => _execute(orderId, cancel: true, key: idempotencyKey);

  @override
  Future<DomainPage<Hip3ActionSummary>> listActions({String? cursor}) async {
    final page = await _service.listActions(cursor: cursor);
    return DomainPage(
      items: page.items.map(_summary).toList(growable: false),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<Hip3ActionSummary> getAction(String actionId) async =>
      _summary(await _service.getAction(actionId));

  @override
  Future<Hip3ActionSummary> cancelAction(
    String actionId, {
    required String idempotencyKey,
  }) async => _summary(
    await _service.cancelAction(actionId, idempotencyKey: idempotencyKey),
  );

  Future<ResourceResult<TradingOrder>> _execute(
    String orderId, {
    required bool cancel,
    required String key,
  }) {
    final flightKey = '${cancel ? 'cancel' : 'place'}:$orderId';
    return _inFlight.putIfAbsent(flightKey, () async {
      try {
        api.Hip3Action? action;
        for (var attempt = 0; attempt < 30; attempt++) {
          if (_isCancelled()) throw const CancelledFailure();
          try {
            action = cancel
                ? await _service.createCancelOrderAction(
                    orderId: orderId,
                    idempotencyKey: key,
                  )
                : await _service.createPlaceOrderAction(
                    orderId: orderId,
                    idempotencyKey: key,
                  );
            break;
          } on ServerFailure catch (failure) {
            if (cancel ||
                failure.code != 'hip3_action_not_ready' ||
                !failure.retryable) {
              rethrow;
            }
            await _delay(const Duration(milliseconds: 500));
          }
        }
        if (action == null) {
          throw const Hip3SigningFailure(
            Hip3SigningFailureCode.actionNotReady,
            retryable: true,
          );
        }
        var current = action;
        // Cancellation belongs to the session, not the currently visible tab.
        // Keep querying until a final result, review state, or query failure.
        for (var attempt = 0; cancel || attempt < 30; attempt++) {
          if (_isCancelled()) throw const CancelledFailure();
          if (current.orderId != orderId ||
              current.operation != (cancel ? 'cancel_order' : 'place_order')) {
            throw const Hip3SigningFailure(
              Hip3SigningFailureCode.invalidPayload,
            );
          }
          if (current.status == api.Hip3ActionStatus.succeeded) {
            return ResourceResult(
              resource: mapOrder(await _service.getOrder(orderId)),
            );
          }
          if (current.status == api.Hip3ActionStatus.manualReview) {
            throw Hip3ExecutionPending(
              orderId,
              current.actionId,
              requiresReview: true,
              reason: current.failureReason,
            );
          }
          _throwIfTerminal(current);
          final step = current.status == api.Hip3ActionStatus.awaitingSignature
              ? _signableStep(current)
              : null;
          if (step != null) {
            final signing = step.signing!;
            final signatureKey = '${current.actionId}:${step.stepId}';
            var signature = _signatures[signatureKey];
            if (signature == null) {
              if (!signing.validUntil.toUtc().isAfter(_now().toUtc())) {
                throw const Hip3SigningFailure(
                  Hip3SigningFailureCode.actionExpired,
                );
              }
              signature = Hip3RsvSignature.fromCompactHex(
                await _signer.signTypedDataV4(
                  expectedSigner: signing.expectedSigner,
                  typedData: _typedData(signing),
                ),
              );
              _signatures[signatureKey] = signature;
            }
            try {
              current = await _service.submitStep(
                orderId: orderId,
                actionId: current.actionId,
                stepId: step.stepId,
                request: _request(signature),
                idempotencyKey: scopedIdempotencyKey(
                  'hip3-action-${current.actionId}-${step.stepId}',
                ),
              );
              continue;
            } on ApiFailure catch (failure) {
              // The response may be lost after broadcast. Query before considering a same-key retry.
              if (!_transient(failure)) rethrow;
            }
          }
          await _delay(const Duration(milliseconds: 500));
          try {
            current = await _service.getAction(current.actionId);
          } on ApiFailure catch (failure) {
            if (!_transient(failure)) rethrow;
            // Do not resubmit from a stale prepared snapshot when status cannot be read.
            for (var retry = 0; retry < 3; retry++) {
              await _delay(const Duration(milliseconds: 500));
              try {
                current = await _service.getAction(current.actionId);
                break;
              } on ApiFailure catch (failure) {
                if (!_transient(failure)) rethrow;
                if (retry == 2) {
                  throw Hip3ExecutionPending(
                    orderId,
                    current.actionId,
                    failure: failure,
                  );
                }
              }
            }
          }
        }
        throw Hip3ExecutionPending(orderId, current.actionId);
      } finally {
        _inFlight.remove(flightKey);
      }
    });
  }

  bool _transient(ApiFailure failure) =>
      failure is NetworkFailure ||
      failure is TimeoutFailure ||
      (failure is ServerFailure &&
          failure.retryable &&
          (failure.statusCode == 429 || failure.statusCode >= 500));

  Hip3ActionSummary _summary(api.Hip3Action action) => Hip3ActionSummary(
    actionId: action.actionId,
    productId: action.productId,
    operation: hip3OperationName(action.operation),
    status: action.status.name,
    positionId: action.positionId,
    orderId: action.orderId,
    failureCode: action.failureCode,
    userAction: action.userAction,
    effectsApplied: action.effectsApplied,
    canResumePositionAction: false,
  );

  api.Hip3ActionStep? _signableStep(api.Hip3Action action) => action.steps
      .where(
        (step) =>
            step.stepId == action.currentStepId &&
            step.signing != null &&
            step.status.name == 'prepared',
      )
      .firstOrNull;

  Map<String, Object?> _typedData(api.Hip3StepSigningPayload signing) {
    if (signing.signingMethod !=
            api.Hip3StepSigningPayloadSigningMethodEnum.ethSignTypedDataV4 ||
        signing.signatureFormat !=
            api.Hip3StepSigningPayloadSignatureFormatEnum.rSV) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    final serialized = api.standardSerializers.serializeWith(
      api.Hip3Eip712TypedData.serializer,
      signing.signingTypedData,
    );
    if (serialized is! Map) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    return serialized.map(
      (key, value) => MapEntry(key.toString(), value as Object?),
    );
  }

  void _throwIfTerminal(api.Hip3Action action) {
    final failure = _failureMetadata(action);
    switch (action.status) {
      case api.Hip3ActionStatus.expired:
        throw Hip3SigningFailure(
          Hip3SigningFailureCode.actionExpired,
          reason: failure.reason,
          failureCode: failure.failureCode,
          userAction: failure.userAction,
        );
      case api.Hip3ActionStatus.failed:
      case api.Hip3ActionStatus.cancelled:
        throw Hip3SigningFailure(
          Hip3SigningFailureCode.invalidPayload,
          reason: failure.reason,
          failureCode: failure.failureCode,
          userAction: failure.userAction,
        );
      default:
        return;
    }
  }

  /// The step that actually failed explains more than the action-level reason,
  /// so prefer it and fall back to the action's own.
  ({String? reason, String? failureCode, String? userAction}) _failureMetadata(
    api.Hip3Action action,
  ) {
    final step = action.steps
        .where((step) => step.status == api.Hip3ActionStepStatusEnum.failed)
        .lastOrNull;
    return (
      reason: _nonEmpty(step?.failureReason) ?? _nonEmpty(action.failureReason),
      failureCode:
          _nonEmpty(step?.failureCode) ?? _nonEmpty(action.failureCode),
      userAction: _nonEmpty(action.userAction),
    );
  }

  String? _nonEmpty(String? value) {
    final trimmed = value?.trim();
    return trimmed == null || trimmed.isEmpty ? null : trimmed;
  }

  api.Hip3ActionSubmissionRequest _request(Hip3RsvSignature signature) =>
      api.Hip3ActionSubmissionRequest(
        (request) => request.signature
          ..r = signature.r
          ..s = signature.s
          ..v = signature.v == 27
              ? api.HyperliquidSignatureVEnum.number27
              : api.HyperliquidSignatureVEnum.number28,
      );
}
