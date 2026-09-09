import 'package:dio/dio.dart';

import '../../domain/models/hip3_order_action.dart';
import '../../domain/services/hip3_typed_data_signer.dart';
import '../api/api_failure_mapper.dart';

/// Focused transport boundary for the v1.3 HIP-3 signature operation.
///
/// This stays beside generated services so no widget or business object calls
/// Dio. It can be replaced by `OrdersApi.submitHip3OrderAction` when the checked
/// in generated client is refreshed from the shared contract.
abstract interface class Hip3OrderActionService {
  Future<Hip3OrderAction> getAction(String orderId);

  Future<Hip3SubmissionResult> submit(
    Hip3OrderAction action,
    Hip3RsvSignature signature, {
    required String idempotencyKey,
  });
}

final class DioHip3OrderActionService implements Hip3OrderActionService {
  DioHip3OrderActionService(
    this._dio, {
    this.mapper = const ApiFailureMapper(),
  });

  final Dio _dio;
  final ApiFailureMapper mapper;

  @override
  Future<Hip3OrderAction> getAction(String orderId) async {
    try {
      final response = await _dio.get<Map<String, Object?>>(
        '/v1/orders/${Uri.encodeComponent(orderId)}',
      );
      final body = response.data;
      if (body == null) throw const FormatException('Missing order body');
      return Hip3OrderAction.fromOrderJson(body);
    } on DioException catch (error) {
      throw mapper.fromDio(error);
    }
  }

  @override
  Future<Hip3SubmissionResult> submit(
    Hip3OrderAction action,
    Hip3RsvSignature signature, {
    required String idempotencyKey,
  }) async {
    try {
      final response = await _dio.post<Map<String, Object?>>(
        '/v1/orders/${Uri.encodeComponent(action.orderId)}'
        '/hip3-actions/${Uri.encodeComponent(action.actionId)}/submissions',
        options: Options(headers: {'Idempotency-Key': idempotencyKey}),
        data: {'signature': signature.toJson()},
      );
      final body = response.data;
      if (body == null) throw const FormatException('Missing order body');
      return Hip3SubmissionResult(
        orderId: body['order_id'] as String,
        status: body['status'] as String,
        providerOrderId: body['provider_order_id'] as String?,
      );
    } on DioException catch (error) {
      throw mapper.fromDio(error);
    }
  }
}
