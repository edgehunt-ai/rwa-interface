import 'package:rwa_api_client/rwa_api_client.dart' as api;

abstract interface class AccountService {
  Future<api.User> getMe();
  Future<api.UserSettings> updateSettings(api.UserSettingsUpdate update);
  Future<api.DevicePage> listDevices({String? cursor});
  Future<api.Device> registerDevice(api.DeviceRegisterRequest request);
  Future<void> deleteDevice(String deviceId);
  Future<api.AccountDeletionRequest> requestAccountDeletion({
    required String idempotencyKey,
  });
  Future<api.AccountDeletionRequest> getAccountDeletion();
}
