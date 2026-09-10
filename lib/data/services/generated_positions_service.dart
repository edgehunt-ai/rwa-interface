import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';
import 'positions_service.dart';

final class GeneratedPositionsService implements PositionsService {
  GeneratedPositionsService(
    this._api, {
    this._mapper = const ApiFailureMapper(),
  });
  final api.PositionsApi _api;
  final ApiFailureMapper _mapper;
  @override
  Future<api.PositionPage> listPositions({
    String? symbol,
    api.ProductKind? kind,
    String? cursor,
  }) => _body(
    () => _api.listPositions(symbol: symbol, kind: kind, cursor: cursor),
  );
  @override
  Future<api.Position> getPosition(String positionId) =>
      _body(() => _api.getPosition(positionId: positionId));
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
