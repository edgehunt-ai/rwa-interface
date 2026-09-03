import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import '../api/api_failure_mapper.dart';
import 'orders_service.dart';

final class GeneratedOrdersService implements OrdersService {
  GeneratedOrdersService(this._api, {this._mapper = const ApiFailureMapper()});
  final OrdersApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<Order> createOrder(
    CreateOrderRequest request, {
    required String idempotencyKey,
  }) async {
    try {
      final data = (await _api.createOrder(
        idempotencyKey: idempotencyKey,
        createOrderRequest: request,
      )).data;
      if (data == null) throw const FormatException('Missing createOrder body');
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
