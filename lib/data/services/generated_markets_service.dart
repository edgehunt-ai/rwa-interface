import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import '../api/api_failure_mapper.dart';
import 'markets_service.dart';

final class GeneratedMarketsService implements MarketsService {
  GeneratedMarketsService(this._api, {this._mapper = const ApiFailureMapper()});
  final MarketsApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<StockPage> listStocks() async {
    try {
      final data = (await _api.listStocks()).data;
      if (data == null) throw const FormatException('Missing listStocks body');
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
