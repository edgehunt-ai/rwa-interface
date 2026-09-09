import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';

abstract interface class Hip3OrderActionService {
  Future<api.Order> getOrder(String orderId);

  Future<api.Order> submit({
    required String orderId,
    required String actionId,
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
  Future<api.Order> submit({
    required String orderId,
    required String actionId,
    required api.Hip3ActionSubmissionRequest request,
    required String idempotencyKey,
  }) => _body(
    () => _api.submitHip3OrderAction(
      orderId: orderId,
      actionId: actionId,
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
