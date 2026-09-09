import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/hip3_order_action.dart';
import '../../domain/models/order.dart';
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
        final action = await _awaitAction(orderId);
        if (action.isExpiredAt(_now())) {
          throw const Hip3SigningFailure(Hip3SigningFailureCode.actionExpired);
        }
        final signature = _signatures[action.actionId] ??=
            Hip3RsvSignature.fromCompactHex(
              await _signer.signTypedDataV4(
                expectedSigner: action.expectedSigner,
                typedData: action.typedData,
              ),
            );
        final wire = await _service.submit(
          orderId: orderId,
          actionId: action.actionId,
          request: _request(signature),
          idempotencyKey: 'hip3-action-${action.actionId}',
        );
        return ResourceResult(resource: mapOrder(wire));
      } finally {
        _inFlight.remove(orderId);
      }
    });
  }

  Future<Hip3OrderAction> _awaitAction(String orderId) async {
    for (var attempt = 0; attempt < 30; attempt++) {
      final order = await _service.getOrder(orderId);
      final action = order.hip3Action;
      if (action != null) return _mapAction(orderId, action);
      if (order.status == api.OrderStatus.failed ||
          order.status == api.OrderStatus.cancelled) {
        break;
      }
      await _delay(const Duration(milliseconds: 500));
    }
    throw const Hip3SigningFailure(
      Hip3SigningFailureCode.actionNotReady,
      retryable: true,
    );
  }

  Hip3OrderAction _mapAction(String orderId, api.Hip3OrderAction action) {
    if (action.signingMethod !=
            api.Hip3OrderActionSigningMethodEnum.ethSignTypedDataV4 ||
        action.signatureFormat != api.Hip3OrderActionSignatureFormatEnum.rSV) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    final serialized = api.standardSerializers.serializeWith(
      api.Hip3Eip712TypedData.serializer,
      action.signingTypedData,
    );
    if (serialized is! Map) {
      throw const Hip3SigningFailure(Hip3SigningFailureCode.invalidPayload);
    }
    return Hip3OrderAction(
      orderId: orderId,
      actionId: action.actionId,
      expectedSigner: action.expectedSigner,
      typedData: serialized.map(
        (key, value) => MapEntry(key.toString(), value as Object?),
      ),
      validUntil: action.validUntil.toUtc(),
    );
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
