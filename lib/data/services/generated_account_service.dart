import 'package:dio/dio.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/api_failure.dart';
import '../api/api_failure_mapper.dart';
import 'account_service.dart';

final class GeneratedAccountService implements AccountService {
  GeneratedAccountService(this._api, {this._mapper = const ApiFailureMapper()});

  final api.AccountApi _api;
  final ApiFailureMapper _mapper;

  @override
  Future<api.User> getMe() => _body(() => _api.getMe());

  @override
  Future<api.UserSettings> updateSettings(api.UserSettingsUpdate update) =>
      _body(() => _api.updateSettings(userSettingsUpdate: update));

  @override
  Future<api.DevicePage> listDevices({String? cursor}) =>
      _body(() => _api.listDevices(cursor: cursor));

  @override
  Future<api.Device> registerDevice(api.DeviceRegisterRequest request) =>
      _body(() => _api.registerDevice(deviceRegisterRequest: request));

  @override
  Future<void> deleteDevice(String deviceId) async {
    try {
      await _api.deleteDevice(deviceId: deviceId);
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }

  Future<T> _body<T>(Future<Response<T>> Function() request) async {
    try {
      final response = await request();
      final data = response.data;
      if (data == null) {
        throw DecodingFailure(
          requestId: response.headers.value('x-request-id'),
        );
      }
      return data;
    } on DioException catch (error) {
      throw _mapper.fromDio(error);
    }
  }
}
