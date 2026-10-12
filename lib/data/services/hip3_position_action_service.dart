import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';

/// Transport-only boundary. Signing and confirmation belong to the use case.
abstract interface class Hip3PositionActionService {
  Future<api.Hip3ActionPage> active({String? cursor});
  Future<api.Order> order(String orderId);
  Future<api.Hip3TradingContext> context(String productId);
  Future<api.Hip3ClosePreview> previewClose(
    String positionId,
    api.Hip3ClosePreviewRequest request,
    String idempotencyKey,
  );
  Future<api.Hip3Action> create(
    api.Hip3ActionCreateRequest request,
    String idempotencyKey,
  );
  Future<api.Hip3Action> get(String actionId);
  Future<api.Hip3Action> submit(
    String actionId,
    String stepId,
    api.Hip3ActionSubmissionRequest request,
    String idempotencyKey,
  );
}

final class GeneratedHip3PositionActionService
    implements Hip3PositionActionService {
  GeneratedHip3PositionActionService(
    this._api, {
    this.mapper = const ApiFailureMapper(),
  });
  final api.OrdersApi _api;
  final ApiFailureMapper mapper;

  @override
  Future<api.Hip3ActionPage> active({String? cursor}) => _body(
    () => _api.listHip3Actions(cursor: cursor, statusGroup: 'active'),
    apiOperation: 'orders.list_hip3_actions',
    responseModel: 'Hip3ActionPage',
  );

  @override
  Future<api.Order> order(String orderId) => _body(
    () => _api.getOrder(orderId: orderId),
    apiOperation: 'orders.get_order',
    responseModel: 'Order',
  );

  @override
  Future<api.Hip3TradingContext> context(String productId) => _body(
    () => _api.getHip3TradingContext(productId: productId),
    apiOperation: 'orders.get_hip3_trading_context',
    responseModel: 'Hip3TradingContext',
  );
  @override
  Future<api.Hip3ClosePreview> previewClose(
    String positionId,
    api.Hip3ClosePreviewRequest request,
    String idempotencyKey,
  ) => _body(
    () => _api.previewHip3ClosePosition(
      positionId: positionId,
      hip3ClosePreviewRequest: request,
      idempotencyKey: idempotencyKey,
    ),
    apiOperation: 'orders.preview_hip3_close_position',
    responseModel: 'Hip3ClosePreview',
  );
  @override
  Future<api.Hip3Action> create(
    api.Hip3ActionCreateRequest request,
    String idempotencyKey,
  ) => _body(
    () => _api.createHip3Action(
      hip3ActionCreateRequest: request,
      idempotencyKey: idempotencyKey,
    ),
    apiOperation: 'orders.create_hip3_action',
    responseModel: 'Hip3Action',
  );
  @override
  Future<api.Hip3Action> get(String actionId) => _body(
    () => _api.getHip3Action(actionId: actionId),
    apiOperation: 'orders.get_hip3_action',
    responseModel: 'Hip3Action',
  );
  @override
  Future<api.Hip3Action> submit(
    String actionId,
    String stepId,
    api.Hip3ActionSubmissionRequest request,
    String idempotencyKey,
  ) => _body(
    () => _api.submitHip3ActionStep(
      actionId: actionId,
      stepId: stepId,
      hip3ActionSubmissionRequest: request,
      idempotencyKey: idempotencyKey,
    ),
    apiOperation: 'orders.submit_hip3_action_step',
    responseModel: 'Hip3Action',
  );

  Future<T> _body<T>(
    Future<Response<T>> Function() request, {
    required String apiOperation,
    required String responseModel,
  }) async {
    try {
      final response = await request();
      final body = response.data;
      if (body == null) {
        throw mapper.fromMissingBody(
          response,
          apiOperation: apiOperation,
          responseModel: responseModel,
        );
      }
      return body;
    } on DioException catch (error) {
      throw mapper.fromDio(
        error,
        apiOperation: apiOperation,
        responseModel: responseModel,
      );
    }
  }
}
