import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart';

import '../api/api_failure_mapper.dart';
import '../../domain/models/api_failure.dart';
import 'session_service.dart';

final class GeneratedSessionService implements SessionService {
  GeneratedSessionService(this._api, {this._mapper = const ApiFailureMapper()});
  final AuthApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<PrivyClientConfig> getAuthConfig() => _map(() => _api.getAuthConfig());

  @override
  Future<SessionResponse> createSession({String? language}) => _map(
    () => _api.createSession(
      sessionRequest: SessionRequest((builder) => builder.language = language),
    ),
  );

  @override
  Future<void> deleteSession() async {
    try {
      await _api.deleteSession();
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }

  Future<T> _map<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      final data = response.data;
      if (data == null) throw DecodingFailure(requestId: _requestId(response));
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }

  String? _requestId(Response<Object?> response) =>
      response.headers.value('x-request-id');
}
