import 'package:rwa_api_client/rwa_api_client.dart' as api;

import '../../domain/models/domain_page.dart';
import '../../domain/models/registered_device.dart';
import '../../domain/models/user_account.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/account_service.dart';
import 'session_repository_impl.dart';

final class AccountRepositoryImpl implements AccountRepository {
  AccountRepositoryImpl(this._service);

  final AccountService _service;

  @override
  Future<UserAccount> getAccount() async => mapUser(await _service.getMe());

  @override
  Future<UserPreferences> updateSettings(UserPreferencesPatch patch) async {
    final update = api.UserSettingsUpdate((builder) {
      if (patch.language != null) {
        builder.language = switch (patch.language) {
          'zh-CN' => api.UserLanguage.zhCN,
          'en' => api.UserLanguage.en,
          _ => api.UserLanguage.unknownDefaultOpenApi,
        };
      }
      builder
        ..pushEnabled = patch.pushEnabled
        ..notifyOrderFilled = patch.notifyOrderFilled
        ..notifyOrderFailed = patch.notifyOrderFailed
        ..notifyLiquidationWarning = patch.notifyLiquidationWarning;
    });
    return mapSettings(await _service.updateSettings(update));
  }

  @override
  Future<DomainPage<RegisteredDevice>> listDevices({String? cursor}) async {
    final page = await _service.listDevices(cursor: cursor);
    return DomainPage(
      items: page.items.map(_mapDevice).toList(),
      nextCursor: page.nextCursor,
      hasMore: page.hasMore,
    );
  }

  @override
  Future<RegisteredDevice> registerDevice(
    DeviceRegistration registration,
  ) async {
    final request = api.DeviceRegisterRequest(
      (builder) => builder
        ..deviceId = registration.deviceId
        ..platform = registration.platform
        ..appVersion = registration.appVersion
        ..pushToken = registration.pushToken
        ..pushProvider = switch (registration.pushProvider) {
          'apns' => api.DeviceRegisterRequestPushProviderEnum.apns,
          'fcm' => api.DeviceRegisterRequestPushProviderEnum.fcm,
          _ => null,
        },
    );
    return _mapDevice(await _service.registerDevice(request));
  }

  @override
  Future<void> deleteDevice(String deviceId) => _service.deleteDevice(deviceId);

  RegisteredDevice _mapDevice(api.Device value) => RegisteredDevice(
    deviceId: value.deviceId,
    platform: value.platform,
    appVersion: value.appVersion,
    pushProvider: value.pushProvider?.name,
    pushTokenRegistered: value.pushTokenRegistered ?? false,
    lastSeenAt: value.lastSeenAt?.toUtc(),
    createdAt: value.createdAt?.toUtc(),
  );
}
