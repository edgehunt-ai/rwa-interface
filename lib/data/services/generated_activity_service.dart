import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../api/api_failure_mapper.dart';
import 'activity_service.dart';

final class GeneratedActivityService implements ActivityService {
  GeneratedActivityService(
    this._api, {
    this._mapper = const ApiFailureMapper(),
  });
  final api.ActivityApi _api;
  final ApiFailureMapper _mapper;
  @override
  Future<api.ActivityPage> list({
    api.ActivityCategory? category,
    api.ActivityStatus? status,
    String? cursor,
  }) async {
    try {
      final data = (await _api.listActivity(
        category: category,
        status: status,
        cursor: cursor,
      )).data;
      if (data == null) throw const FormatException('Missing response body');
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
