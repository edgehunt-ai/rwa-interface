import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';
import 'portfolio_service.dart';

final class GeneratedPortfolioService implements PortfolioService {
  GeneratedPortfolioService(
    this._api, {
    this._mapper = const ApiFailureMapper(),
  });
  final api.PortfolioApi _api;
  final ApiFailureMapper _mapper;
  @override
  Future<api.PortfolioSummary> getSummary() => _body(_api.getPortfolioSummary);
  @override
  Future<api.PortfolioAccountPage> listAccounts() => _body(_api.listAccounts);
  @override
  Future<api.PortfolioHoldingPage> listHoldings({String? cursor}) =>
      _body(() => _api.listHoldings(cursor: cursor));

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
