import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../api/api_failure_mapper.dart';
import 'trade_intent_service.dart';

final class GeneratedTradeIntentService implements TradeIntentService {
  GeneratedTradeIntentService(
    this._api, {
    this._mapper = const ApiFailureMapper(),
  });

  final api.OrdersApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<api.TradeIntent> create(
    api.TradeIntentCreateRequest request, {
    required String idempotencyKey,
  }) => _body(
    () => _api.createTradeIntent(
      idempotencyKey: idempotencyKey,
      tradeIntentCreateRequest: request,
    ),
  );

  @override
  Future<api.TradeIntent?> getCurrent() async {
    try {
      return (await _api.getCurrentTradeIntent()).data ??
          (throw const FormatException('Missing response body'));
    } on DioException catch (error) {
      final failure = _mapper.fromDio(error);
      if (failure case ServerFailure(statusCode: 404)) return null;
      throw failure;
    }
  }

  @override
  Future<api.TradeIntent> get(String tradeIntentId) =>
      _body(() => _api.getTradeIntent(tradeIntentId: tradeIntentId));

  @override
  Future<api.TradeIntent> cancel(
    String tradeIntentId, {
    required String idempotencyKey,
  }) => _body(
    () => _api.cancelTradeIntent(
      tradeIntentId: tradeIntentId,
      idempotencyKey: idempotencyKey,
    ),
  );

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      return (await request()).data ??
          (throw const FormatException('Missing response body'));
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
