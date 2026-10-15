import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../api/api_failure_mapper.dart';
import 'system_service.dart';

final class GeneratedSystemService implements SystemService {
  GeneratedSystemService(this._api, {this._mapper = const ApiFailureMapper()});

  final api.SystemApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<api.SystemEnvironment> getEnvironment() async {
    try {
      final response = await _api.getSystemEnvironment();
      final data = response.data;
      if (data == null) {
        throw _mapper.fromMissingBody(
          response,
          apiOperation: 'system.get_environment',
          responseModel: 'SystemEnvironment',
        );
      }
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(
        error,
        apiOperation: 'system.get_environment',
        responseModel: 'SystemEnvironment',
      );
    }
  }

  @override
  Future<List<api.AppVersionInfo>> listAppVersions({String? platform}) async {
    try {
      final response = await _api.listAppVersions(platform: platform);
      final data = response.data;
      if (data == null) {
        throw DecodingFailure(
          requestId: response.headers.value('x-request-id'),
        );
      }
      return data.platforms.toList(growable: false);
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
