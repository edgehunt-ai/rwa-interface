import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/app/providers/api_providers.dart';
import 'package:nobell/app/providers/session_scope.dart';
import 'package:nobell/domain/models/domain_page.dart';
import 'package:nobell/domain/models/account_deletion.dart';
import 'package:nobell/domain/models/registered_device.dart';
import 'package:nobell/domain/models/user_account.dart';
import 'package:nobell/domain/repositories/account_repository.dart';
import 'package:nobell/ui/features/account/providers/account_providers.dart';

void main() {
  test('account state reloads when the session generation changes', () async {
    final repository = _AccountRepository();
    final container = ProviderContainer(
      overrides: [accountRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(accountProvider, (_, _) {});
    addTearDown(subscription.close);
    expect((await container.read(accountProvider.future)).userId, 'user-1');
    container.read(sessionGenerationProvider.notifier).clearUserScope();
    expect((await container.read(accountProvider.future)).userId, 'user-2');
  });
}

final class _AccountRepository implements AccountRepository {
  int calls = 0;
  @override
  Future<UserAccount> getAccount() async =>
      UserAccount(userId: 'user-${++calls}', settings: _settings);

  @override
  Future<void> deleteDevice(String deviceId) async {}
  @override
  Future<AccountDeletion> getAccountDeletion() => throw UnimplementedError();
  @override
  Future<AccountDeletion> requestAccountDeletion({
    required String idempotencyKey,
  }) => throw UnimplementedError();
  @override
  Future<DomainPage<RegisteredDevice>> listDevices({String? cursor}) async =>
      const DomainPage(items: []);
  @override
  Future<RegisteredDevice> registerDevice(DeviceRegistration registration) =>
      throw UnimplementedError();
  @override
  Future<UserPreferences> updateSettings(UserPreferencesPatch patch) async =>
      _settings;
}

const _settings = UserPreferences(
  language: 'en',
  pushEnabled: true,
  notifyOrderFilled: true,
  notifyOrderFailed: true,
  notifyLiquidationWarning: true,
);
