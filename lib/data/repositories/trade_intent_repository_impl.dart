import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/decimal_value.dart';
import '../../domain/models/trade_intent.dart';
import '../../domain/repositories/trade_intent_repository.dart';
import '../services/trade_intent_service.dart';

final class TradeIntentRepositoryImpl implements TradeIntentRepository {
  TradeIntentRepositoryImpl(this._service);

  final TradeIntentService _service;

  @override
  Future<TradeIntent> create(
    TradeIntentCreateInput input, {
    required String idempotencyKey,
  }) async => _map(
    await _service.create(
      api.TradeIntentCreateRequest(
        (builder) => builder.oneOf =
            input.fundingSessionId != null &&
                input.fundingSessionVersion != null
            ? OneOfDynamic(
                typeIndex: 2,
                types: const [
                  api.AutoMultiSourceTradeIntentCreateRequest,
                  api.AutoSingleSourceTradeIntentCreateRequest,
                  api.FundingSessionTradeIntentCreateRequest,
                ],
                value: api.FundingSessionTradeIntentCreateRequest(
                  (request) => request
                    ..fundingSessionId = input.fundingSessionId!
                    ..fundingSessionVersion = input.fundingSessionVersion!
                    ..fundingMode = api
                        .FundingSessionTradeIntentCreateRequestFundingModeEnum
                        .fundingSession
                    ..executionPolicy.replace(_policy(input.executionPolicy)),
                ),
              )
            : OneOfDynamic(
                typeIndex: 1,
                types: const [
                  api.AutoSingleSourceTradeIntentCreateRequest,
                  api.AutoMultiSourceTradeIntentCreateRequest,
                ],
                value: api.AutoMultiSourceTradeIntentCreateRequest(
                  (request) => request
                    ..previewId = input.previewId
                    ..authorizationId = input.authorizationId
                    ..fundingMode = api
                        .AutoMultiSourceTradeIntentCreateRequestFundingModeEnum
                        .autoMultiSource
                    ..executionPolicy.replace(_policy(input.executionPolicy)),
                ),
              ),
      ),
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<TradeIntent?> getCurrent() async {
    final value = await _service.getCurrent();
    return value == null ? null : _map(value);
  }

  @override
  Future<TradeIntent> get(String tradeIntentId) async =>
      _map(await _service.get(tradeIntentId));

  @override
  Future<TradeIntent> cancel(
    String tradeIntentId, {
    required String idempotencyKey,
  }) async => _map(
    await _service.cancel(tradeIntentId, idempotencyKey: idempotencyKey),
  );

  api.TradeIntentExecutionPolicy _policy(TradeIntentExecutionPolicy policy) =>
      api.TradeIntentExecutionPolicy(
        (builder) => builder
          ..orderType = api.TradeIntentExecutionPolicyOrderTypeEnum.ioc
          ..limitPrice = policy.limitPrice.value
          ..executeBefore = policy.executeBefore.toUtc(),
      );

  TradeIntent _map(api.TradeIntent value) => TradeIntent(
    tradeIntentId: value.tradeIntentId,
    previewId: value.previewId,
    authorizationId: value.authorizationId,
    productId: _productId(value.productId),
    status: _status(value.status),
    nextAction: _nextAction(value.nextAction),
    blocker: value.blocker == null ? null : _blocker(value.blocker!),
    executionPolicy: TradeIntentExecutionPolicy(
      limitPrice: DecimalValue(value.executionPolicy.limitPrice, unit: 'price'),
      executeBefore: value.executionPolicy.executeBefore.toUtc(),
    ),
    fundingPlanId: value.fundingPlanId,
    transferId: value.transferId,
    fundingLegs:
        value.fundingLegs
            ?.map(
              (leg) => TradeIntentFundingLeg(
                legId: leg.legId,
                ordinal: leg.ordinal,
                transferId: leg.transferId,
                status: _legStatus(leg.status),
              ),
            )
            .toList(growable: false) ??
        const [],
    orderId: value.orderId,
    createdAt: value.createdAt.toUtc(),
    updatedAt: value.updatedAt.toUtc(),
    expiresAt: value.expiresAt.toUtc(),
  );

  String _productId(api.Hip3MainnetProduct value) =>
      api.standardSerializers.serializeWith(
            api.Hip3MainnetProduct.serializer,
            value,
          )!
          as String;

  String _status(api.TradeIntentStatus value) =>
      api.standardSerializers.serializeWith(
            api.TradeIntentStatus.serializer,
            value,
          )!
          as String;

  String _nextAction(api.TradeIntentNextAction value) =>
      api.standardSerializers.serializeWith(
            api.TradeIntentNextAction.serializer,
            value,
          )!
          as String;

  String _blocker(api.TradeIntentBlocker value) =>
      api.standardSerializers.serializeWith(
            api.TradeIntentBlocker.serializer,
            value,
          )!
          as String;

  String _legStatus(api.MultiSourceFundingLegStatus value) =>
      api.standardSerializers.serializeWith(
            api.MultiSourceFundingLegStatus.serializer,
            value,
          )!
          as String;
}
