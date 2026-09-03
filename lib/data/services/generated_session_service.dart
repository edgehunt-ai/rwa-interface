import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import '../api/api_failure_mapper.dart';
import 'session_service.dart';

final class GeneratedSessionService implements SessionService {
  GeneratedSessionService(this._api, {this._mapper = const ApiFailureMapper()});
  final AuthApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<void> deleteSession() async {
    try {
      await _api.deleteSession();
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
