import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';
import 'charts_service.dart';

final class GeneratedChartsService implements ChartsService {
  GeneratedChartsService(this._api, {this._mapper = const ApiFailureMapper()});
  final api.ChartsApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<api.CandleSeries> getCandles(
    String symbol,
    api.ProductKind kind, {
    String? interval,
    DateTime? from,
    DateTime? to,
  }) => _body(
    () => _api.getCandles(
      symbol: symbol,
      kind: kind,
      interval: interval,
      from: from,
      to: to,
    ),
  );
  @override
  Future<api.MarketSessionInfo> getMarketSessions() =>
      _body(_api.getMarketSessions);
  @override
  Future<api.ReferencePrice> getReferencePrice(String symbol) =>
      _body(() => _api.getReferencePrice(symbol: symbol));

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
