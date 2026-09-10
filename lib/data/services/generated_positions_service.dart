import 'package:dio/dio.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import 'positions_service.dart';

final class GeneratedPositionsService implements PositionsService {
  GeneratedPositionsService(
    this._positionsApi,
    this._ordersApi,
    this._signer, {
    this._mapper = const ApiFailureMapper(),
  });
  final api.PositionsApi _positionsApi;
  final api.OrdersApi _ordersApi;
  final Hip3TypedDataSigner _signer;
  final ApiFailureMapper _mapper;
  @override
  Future<api.PositionPage> listPositions({
    String? symbol,
    api.ProductKind? kind,
    String? cursor,
  }) => _body(
    () =>
        _positionsApi.listPositions(symbol: symbol, kind: kind, cursor: cursor),
  );
  @override
  Future<api.Position> getPosition(String positionId) =>
      _body(() => _positionsApi.getPosition(positionId: positionId));
  @override
  Future<api.Hip3TradingContext> getHip3TradingContext(String productId) =>
      _body(() => _ordersApi.getHip3TradingContext(productId: productId));
  @override
  Future<api.Position> updateTpSl(
    api.Hip3SetTpSlActionRequest request, {
    required String idempotencyKey,
  }) async {
    await _execute(_action(request), idempotencyKey: idempotencyKey);
    return getPosition(request.positionId);
  }

  @override
  Future<api.Position> clearTpSl(
    api.Hip3ClearTpSlActionRequest request, {
    required String idempotencyKey,
  }) async {
    await _execute(_action(request), idempotencyKey: idempotencyKey);
    return getPosition(request.positionId);
  }

  @override
  Future<api.Position> updateLeverage(
    String positionId,
    api.Hip3SetLeverageActionRequest request, {
    required String idempotencyKey,
  }) async {
    await _execute(_action(request), idempotencyKey: idempotencyKey);
    return getPosition(positionId);
  }

  @override
  Future<api.Order> closePosition(
    String positionId,
    api.Hip3ClosePreviewRequest request, {
    required String idempotencyKey,
  }) async {
    final preview = await _body(
      () => _ordersApi.previewHip3ClosePosition(
        positionId: positionId,
        idempotencyKey: '$idempotencyKey-preview',
        hip3ClosePreviewRequest: request,
      ),
    );
    final action = await _execute(
      _action(
        api.Hip3CloseActionRequest(
          (action) => action
            ..operation = api.Hip3CloseActionRequestOperationEnum.closePosition
            ..previewId = preview.previewId,
        ),
      ),
      idempotencyKey: idempotencyKey,
    );
    final orderId = action.affectedOrderIds.firstOrNull;
    if (orderId == null) {
      throw const FormatException(
        'HIP3 close action omitted its affected order',
      );
    }
    return _body(() => _ordersApi.getOrder(orderId: orderId));
  }

  api.Hip3ActionCreateRequest _action(Object value) =>
      api.Hip3ActionCreateRequest(
        (builder) => builder.oneOf = OneOfDynamic(
          typeIndex: switch (value) {
            api.Hip3ClearTpSlActionRequest _ => 1,
            api.Hip3CloseActionRequest _ => 2,
            api.Hip3SetLeverageActionRequest _ => 4,
            api.Hip3SetTpSlActionRequest _ => 5,
            _ => throw ArgumentError.value(
              value,
              'value',
              'Unsupported HIP3 action',
            ),
          },
          types: const [
            api.Hip3CancelOrderActionRequest,
            api.Hip3ClearTpSlActionRequest,
            api.Hip3CloseActionRequest,
            api.Hip3PlaceOrderActionRequest,
            api.Hip3SetLeverageActionRequest,
            api.Hip3SetTpSlActionRequest,
          ],
          value: value,
        ),
      );

  Future<api.Hip3Action> _execute(
    api.Hip3ActionCreateRequest request, {
    required String idempotencyKey,
  }) async {
    var action = await _body(
      () => _ordersApi.createHip3Action(
        idempotencyKey: idempotencyKey,
        hip3ActionCreateRequest: request,
      ),
    );
    for (var attempt = 0; attempt < 30; attempt++) {
      if (action.status == api.Hip3ActionStatus.succeeded) return action;
      _throwIfTerminal(action);
      final step = action.steps
          .where(
            (step) =>
                step.stepId == action.currentStepId && step.signing != null,
          )
          .firstOrNull;
      if (step == null) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        action = await _body(
          () => _ordersApi.getHip3Action(actionId: action.actionId),
        );
        continue;
      }
      final signing = step.signing!;
      if (!signing.validUntil.toUtc().isAfter(DateTime.now().toUtc())) {
        throw const Hip3SigningFailure(Hip3SigningFailureCode.actionExpired);
      }
      final signature = Hip3RsvSignature.fromCompactHex(
        await _signer.signTypedDataV4(
          expectedSigner: signing.expectedSigner,
          typedData: _typedData(signing),
        ),
      );
      action = await _body(
        () => _ordersApi.submitHip3ActionStep(
          actionId: action.actionId,
          stepId: step.stepId,
          idempotencyKey: '$idempotencyKey-${step.stepId}',
          hip3ActionSubmissionRequest: api.Hip3ActionSubmissionRequest(
            (request) => request.signature
              ..r = signature.r
              ..s = signature.s
              ..v = signature.v == 27
                  ? api.HyperliquidSignatureVEnum.number27
                  : api.HyperliquidSignatureVEnum.number28,
          ),
        ),
      );
    }
    throw const Hip3SigningFailure(
      Hip3SigningFailureCode.actionNotReady,
      retryable: true,
    );
  }

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
    return serialized.map((key, value) => MapEntry('$key', value as Object?));
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

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final data = (await request()).data;
      if (data == null) throw const FormatException('Missing response body');
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
