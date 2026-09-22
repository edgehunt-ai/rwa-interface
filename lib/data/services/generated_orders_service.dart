import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import '../api/api_failure_mapper.dart';
import 'orders_service.dart';

/// Reports a 2xx response the generated client could not decode.
///
/// A body that does not match the contract is a contract mismatch, not a
/// transport error, and the failure it raises reads like any other request
/// failure. Surface it separately so it is diagnosable.
typedef WireDecodeFailureReporter = void Function({
  required String operation,
  required Object error,
  StackTrace? stackTrace,
});

final class GeneratedOrdersService implements OrdersService {
  GeneratedOrdersService(
    this._api, {
    this._mapper = const ApiFailureMapper(),
    this._onDecodeFailure,
  });
  final OrdersApi _api;
  final ApiFailureMapper _mapper;
  final WireDecodeFailureReporter? _onDecodeFailure;

  @override
  Future<PreviewOrderResponse> previewOrder(
    OrderPreviewRequest request, {
    required String idempotencyKey,
  }) async {
    try {
      final response = await _api.previewOrder(
        idempotencyKey: idempotencyKey,
        orderPreviewRequest: request,
      );
      final value = response.data;
      if (value == null) throw const FormatException('Missing preview body');
      return PreviewOrderResponse(value);
    } on DioException catch (error) {
      final status = error.response?.statusCode;
      // A 2xx the client cannot decode used to degrade to the untyped body,
      // which silently dropped the typed execution terms. Fail loudly instead.
      if (status != null && status >= 200 && status < 300) {
        _onDecodeFailure?.call(
          operation: 'orders.preview.decode_failed',
          error: error.error ?? error,
          stackTrace: error.stackTrace,
        );
      }
      throw _mapper.fromDio(error);
    }
  }

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
  Future<OrderPage> listOrders({
    String? cursor,
    ProductKind? kind,
    String? symbol,
    String? productId,
    String? statusGroup,
  }) => _body(
    () => _api.listOrders(
      cursor: cursor,
      kind: kind,
      symbol: symbol,
      productId: productId,
      statusGroup: statusGroup,
    ),
  );
  @override
  Future<Order> getOrder(String orderId) =>
      _body(() => _api.getOrder(orderId: orderId));
  @override
  Future<Order> cancelOrder(String orderId, {required String idempotencyKey}) =>
      _body(
        () =>
            _api.cancelOrder(orderId: orderId, idempotencyKey: idempotencyKey),
      );

  @override
  Future<BstocksWalletActionSubmission> submitBstocksWalletAction({
    required String orderId,
    required String stepId,
    required String transactionHash,
    required String idempotencyKey,
  }) => _body(
    () => _api.submitBstocksWalletAction(
      orderId: orderId,
      stepId: stepId,
      idempotencyKey: idempotencyKey,
      bstocksWalletActionSubmissionRequest:
          BstocksWalletActionSubmissionRequest(
            (request) => request.txHash = transactionHash,
          ),
    ),
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
