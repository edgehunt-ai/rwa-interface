import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_api_client/rwa_api_client.dart' as api;
import 'package:rwa_interface/data/repositories/account_repository_impl.dart';
import 'package:rwa_interface/data/services/account_service.dart';
import 'package:rwa_interface/domain/models/user_account.dart';

void main() {
  test(
    'maps settings patch and device pagination without push token',
    () async {
      final service = _AccountService();
      final repository = AccountRepositoryImpl(service);
      final settings = await repository.updateSettings(
        const UserPreferencesPatch(pushEnabled: false),
      );
      final devices = await repository.listDevices(cursor: 'next');
      expect(service.patch?.pushEnabled, isFalse);
      expect(settings.pushEnabled, isFalse);
      expect(devices.nextCursor, 'done');
      expect(devices.items.single.pushTokenRegistered, isTrue);
    },
  );
}

final class _AccountService implements AccountService {
  api.UserSettingsUpdate? patch;

  @override
  Future<void> deleteDevice(String deviceId) async {}

  @override
  Future<api.User> getMe() => throw UnimplementedError();

  @override
  Future<api.DevicePage> listDevices({String? cursor}) async => api.DevicePage(
    (builder) => builder
      ..hasMore = false
      ..nextCursor = 'done'
      ..items.add(
        api.Device(
          (device) => device
            ..deviceId = 'device-1'
            ..platform = 'ios'
            ..pushTokenRegistered = true,
        ),
      ),
  );

  @override
  Future<api.Device> registerDevice(api.DeviceRegisterRequest request) =>
      throw UnimplementedError();

  @override
  Future<api.UserSettings> updateSettings(api.UserSettingsUpdate update) async {
    patch = update;
    return api.UserSettings(
      (builder) => builder
        ..language = api.UserSettingsLanguageEnum.en
        ..pushEnabled = false
        ..notifyOrderFilled = true
        ..notifyOrderFailed = true
        ..notifyLiquidationWarning = true,
    );
  }
}
