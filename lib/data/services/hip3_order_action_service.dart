import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';

abstract interface class Hip3OrderActionService {
  Future<api.Order> getOrder(String orderId);

  Future<api.Hip3Action> createPlaceOrderAction({
    required String orderId,
    required String idempotencyKey,
  });

  Future<api.Hip3Action> getAction(String actionId);

  Future<api.Hip3ActionPage> listActions({String? cursor});

  Future<api.Hip3Action> cancelAction(
    String actionId, {
    required String idempotencyKey,
  });

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
      hip3ActionCreateRequest: api.standardSerializers.deserializeWith(
        api.Hip3ActionCreateRequest.serializer,
        {'operation': 'place_order', 'order_id': orderId},
      )!,
    ),
  );

  @override
  Future<api.Hip3Action> getAction(String actionId) =>
      _body(() => _api.getHip3Action(actionId: actionId));

  @override
  Future<api.Hip3ActionPage> listActions({String? cursor}) =>
      _body(() => _api.listHip3Actions(cursor: cursor));

  @override
  Future<api.Hip3Action> cancelAction(
    String actionId, {
    required String idempotencyKey,
  }) => _body(
    () => _api.cancelHip3Action(
      actionId: actionId,
      idempotencyKey: idempotencyKey,
    ),
  );

  @override
  Future<api.Hip3Action> createCancelOrderAction({
    required String orderId,
    required String idempotencyKey,
  }) => _body(
    () => _api.createHip3Action(
      idempotencyKey: idempotencyKey,
      hip3ActionCreateRequest: api.standardSerializers.deserializeWith(
        api.Hip3ActionCreateRequest.serializer,
        {'operation': 'cancel_order', 'order_id': orderId},
      )!,
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
