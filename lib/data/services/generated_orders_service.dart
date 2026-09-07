import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import '../api/api_failure_mapper.dart';
import 'orders_service.dart';

final class GeneratedOrdersService implements OrdersService {
  GeneratedOrdersService(this._api, {this._mapper = const ApiFailureMapper()});
  final OrdersApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<OrderPreview> previewOrder(
    OrderPreviewRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.previewOrder(
      idempotencyKey: idempotencyKey,
      orderPreviewRequest: request,
    ),
  );

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

  @override
  Future<OrderPage> listOrders({String? cursor}) =>
      _body(() => _api.listOrders(cursor: cursor));
  @override
  Future<Order> getOrder(String orderId) =>
      _body(() => _api.getOrder(orderId: orderId));
  @override
  Future<Order> cancelOrder(String orderId, {required String idempotencyKey}) =>
      _body(
        () =>
            _api.cancelOrder(orderId: orderId, idempotencyKey: idempotencyKey),
      );

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
