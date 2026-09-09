import '../models/domain_page.dart';
import '../models/registered_device.dart';
import '../models/user_account.dart';

abstract interface class AccountRepository {
  Future<UserAccount> getAccount();
  Future<UserPreferences> updateSettings(UserPreferencesPatch patch);
  Future<DomainPage<RegisteredDevice>> listDevices({String? cursor});
  Future<RegisteredDevice> registerDevice(DeviceRegistration registration);
  Future<void> deleteDevice(String deviceId);
}
