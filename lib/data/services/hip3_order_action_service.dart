import 'package:dio/dio.dart';
import 'package:one_of/one_of.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';

abstract interface class Hip3OrderActionService {
  Future<api.Order> getOrder(String orderId);

  Future<api.Hip3Action> createPlaceOrderAction({
    required String orderId,
    required String idempotencyKey,
  });

  Future<api.Hip3Action> getAction(String actionId);
  Future<api.Hip3Action> createCancelOrderAction({
    required String orderId,
    required String idempotencyKey,
  });

  Future<api.Hip3Action> submitStep({
    required String orderId,
    required String actionId,
    required String stepId,
    required api.Hip3ActionSubmissionRequest request,
    required String idempotencyKey,
  });
}

final class GeneratedHip3OrderActionService implements Hip3OrderActionService {
  GeneratedHip3OrderActionService(
    this._api, {
    this.mapper = const ApiFailureMapper(),
  });

  final api.OrdersApi _api;
  final ApiFailureMapper mapper;

  @override
  Future<api.Order> getOrder(String orderId) =>
      _body(() => _api.getOrder(orderId: orderId));

  @override
  Future<api.Hip3Action> createPlaceOrderAction({
    required String orderId,
    required String idempotencyKey,
  }) => _body(
    () => _api.createHip3Action(
      idempotencyKey: idempotencyKey,
      hip3ActionCreateRequest: api.Hip3ActionCreateRequest(
        (builder) => builder.oneOf = OneOfDynamic(
          typeIndex: 3,
          types: const [
            api.Hip3CancelOrderActionRequest,
            api.Hip3ClearTpSlActionRequest,
            api.Hip3CloseActionRequest,
            api.Hip3PlaceOrderActionRequest,
            api.Hip3SetLeverageActionRequest,
            api.Hip3SetTpSlActionRequest,
          ],
          value: api.Hip3PlaceOrderActionRequest(
            (request) => request
              ..operation =
                  api.Hip3PlaceOrderActionRequestOperationEnum.placeOrder
              ..orderId = orderId,
          ),
        ),
      ),
    ),
  );

  @override
  Future<api.Hip3Action> getAction(String actionId) =>
      _body(() => _api.getHip3Action(actionId: actionId));

  @override
  Future<api.Hip3Action> createCancelOrderAction({
    required String orderId,
    required String idempotencyKey,
  }) => _body(
    () => _api.createHip3Action(
      idempotencyKey: idempotencyKey,
      hip3ActionCreateRequest: api.Hip3ActionCreateRequest(
        (b) => b.oneOf = OneOfDynamic(
          typeIndex: 0,
          types: const [
            api.Hip3CancelOrderActionRequest,
            api.Hip3ClearTpSlActionRequest,
            api.Hip3CloseActionRequest,
            api.Hip3PlaceOrderActionRequest,
            api.Hip3SetLeverageActionRequest,
            api.Hip3SetTpSlActionRequest,
          ],
          value: api.Hip3CancelOrderActionRequest(
            (r) => r
              ..operation =
                  api.Hip3CancelOrderActionRequestOperationEnum.cancelOrder
              ..orderId = orderId,
          ),
        ),
      ),
    ),
  );

  @override
  Future<api.Hip3Action> submitStep({
    required String orderId,
    required String actionId,
    required String stepId,
    required api.Hip3ActionSubmissionRequest request,
    required String idempotencyKey,
  }) => _body(
    () => _api.submitHip3ActionStep(
      actionId: actionId,
      stepId: stepId,
      idempotencyKey: idempotencyKey,
      hip3ActionSubmissionRequest: request,
    ),
  );

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final data = (await request()).data;
      if (data == null) throw const FormatException('Missing response body');
      return data;
    } on DioException catch (error) {
      throw mapper.fromDio(error);
    }
  }
}
