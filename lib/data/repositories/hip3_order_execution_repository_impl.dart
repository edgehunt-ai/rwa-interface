import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/order.dart';
import '../../domain/models/domain_page.dart';
import '../../domain/models/resource_result.dart';
import '../../domain/repositories/hip3_order_execution_repository.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../services/hip3_order_action_service.dart';
import 'orders_repository_impl.dart';

final class Hip3OrderExecutionRepositoryImpl
    implements Hip3OrderExecutionRepository {
  Hip3OrderExecutionRepositoryImpl(
    this._signer,
    this._service, {
    DateTime Function()? now,
    Future<void> Function(Duration)? delay,
  }) : _now = now ?? DateTime.now,
       _delay = delay ?? Future<void>.delayed;

  final Hip3TypedDataSigner _signer;
  final Hip3OrderActionService _service;
  final DateTime Function() _now;
  final Future<void> Function(Duration) _delay;
  final Map<String, Hip3RsvSignature> _signatures = {};
  final Map<String, Future<ResourceResult<TradingOrder>>> _inFlight = {};

  @override
  Future<ResourceResult<TradingOrder>> awaitActionAndSubmit(String orderId) {
    return _inFlight.putIfAbsent(orderId, () async {
      try {
        var action = await _service.createPlaceOrderAction(
          orderId: orderId,
          idempotencyKey: 'hip3-action-create-$orderId',
        );
        for (var attempt = 0; attempt < 30; attempt++) {
          if (action.status == api.Hip3ActionStatus.succeeded) {
            return ResourceResult(
              resource: mapOrder(await _service.getOrder(orderId)),
            );
          }
          _throwIfTerminal(action);

          final step = _signableStep(action);
          if (step == null) {
            await _delay(const Duration(milliseconds: 500));
            action = await _service.getAction(action.actionId);
            continue;
          }

          final signing = step.signing!;
          if (!signing.validUntil.toUtc().isAfter(_now().toUtc())) {
            throw const Hip3SigningFailure(
              Hip3SigningFailureCode.actionExpired,
            );
          }
          final signature = _signatures['${action.actionId}:${step.stepId}'] ??=
              Hip3RsvSignature.fromCompactHex(
                await _signer.signTypedDataV4(
                  expectedSigner: signing.expectedSigner,
                  typedData: _typedData(signing),
                ),
              );
          action = await _service.submitStep(
            orderId: orderId,
            actionId: action.actionId,
            stepId: step.stepId,
            request: _request(signature),
            idempotencyKey: 'hip3-action-${action.actionId}-${step.stepId}',
          );
        }
        throw const Hip3SigningFailure(
          Hip3SigningFailureCode.actionNotReady,
          retryable: true,
        );
      } finally {
        _inFlight.remove(orderId);
      }
    });
  }

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

  Hip3ActionSummary _summary(api.Hip3Action action) => Hip3ActionSummary(
    actionId: action.actionId,
    operation: action.operation.name,
    status: action.status.name,
    productId: action.productId,
    positionId: action.positionId,
    orderId: action.orderId,
    failureReason: action.failureReason,
    updatedAt: action.updatedAt.toUtc(),
  );

  api.Hip3ActionStep? _signableStep(api.Hip3Action action) => action.steps
      .where(
        (step) => step.stepId == action.currentStepId && step.signing != null,
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
    switch (action.status) {
      case api.Hip3ActionStatus.expired:
        throw const Hip3SigningFailure(Hip3SigningFailureCode.actionExpired);
      case api.Hip3ActionStatus.failed:
      case api.Hip3ActionStatus.cancelled:
      case api.Hip3ActionStatus.ambiguous:
      case api.Hip3ActionStatus.manualReview:
      case api.Hip3ActionStatus.unknownDefaultOpenApi:
        throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
      default:
        return;
    }
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
