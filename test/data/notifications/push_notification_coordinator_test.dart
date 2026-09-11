import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:rwa_interface/app/providers/push_notification_providers.dart';
import 'package:rwa_interface/data/notifications/shared_preferences_device_identity_store.dart';
import 'package:rwa_interface/domain/models/domain_page.dart';
import 'package:rwa_interface/domain/models/registered_device.dart';
import 'package:rwa_interface/domain/models/user_account.dart';
import 'package:rwa_interface/domain/notifications/push_messaging_gateway.dart';
import 'package:rwa_interface/domain/repositories/account_repository.dart';

void main() {
  test(
    'registers the token and repeats registration after token rotation',
    () async {
      final messaging = _Messaging(token: 'token-1');
      final account = _AccountRepository();
      final coordinator = PushNotificationCoordinator(
        messaging,
        const _DeviceIds(),
        account,
        platform: () => 'android',
      );
      addTearDown(coordinator.dispose);

      await coordinator.activate(_settings);
      messaging.tokens.add('token-2');
      await Future<void>.delayed(Duration.zero);

      expect(account.registrations.map((item) => item.pushToken), [
        'token-1',
        'token-2',
      ]);
      expect(
        account.registrations.every((item) => item.deviceId == 'device-1'),
        isTrue,
      );
      expect(
        account.registrations.every((item) => item.pushProvider == 'fcm'),
        isTrue,
      );
    },
  );

  test(
    'does not request a token when server preferences disable push',
    () async {
      final messaging = _Messaging(token: 'token-1');
      final account = _AccountRepository();
      final coordinator = PushNotificationCoordinator(
        messaging,
        const _DeviceIds(),
        account,
        platform: () => 'android',
      );
      addTearDown(coordinator.dispose);

      await coordinator.activate(
        const UserPreferences(
          language: 'en',
          pushEnabled: false,
          notifyOrderFilled: true,
          notifyOrderFailed: true,
          notifyLiquidationWarning: true,
        ),
      );

      expect(messaging.permissionRequests, 0);
      expect(account.registrations, isEmpty);
    },
  );

  test('unregisters the stable device before logout', () async {
    final account = _AccountRepository();
    final coordinator = PushNotificationCoordinator(
      _Messaging(token: 'token'),
      const _DeviceIds(),
      account,
      platform: () => 'android',
    );
    addTearDown(coordinator.dispose);

    await coordinator.deactivate();

    expect(account.deletedDeviceIds, ['device-1']);
  });

  test('only emits approved in-app notification routes', () async {
    final messaging = _Messaging(token: 'token');
    final coordinator = PushNotificationCoordinator(
      messaging,
      const _DeviceIds(),
      _AccountRepository(),
      platform: () => 'android',
    );
    addTearDown(coordinator.dispose);
    final routes = <String>[];
    final subscription = coordinator.routes.listen(routes.add);
    addTearDown(subscription.cancel);

    await coordinator.activate(_settings);
    messaging.opened.add(const PushMessage({'route': '/activity'}));
    messaging.opened.add(
      const PushMessage({'route': 'https://attacker.invalid'}),
    );
    await Future<void>.delayed(Duration.zero);

    expect(routes, ['/activity']);
  });
}

const _settings = UserPreferences(
  language: 'en',
  pushEnabled: true,
  notifyOrderFilled: true,
  notifyOrderFailed: true,
  notifyLiquidationWarning: true,
);

final class _Messaging implements PushMessagingGateway {
  _Messaging({required this.token});

  final String token;
  final tokens = StreamController<String>.broadcast();
  final opened = StreamController<PushMessage>.broadcast();
  var permissionRequests = 0;

  @override
  bool get isSupported => true;
  @override
  Future<PushMessage?> getInitialMessage() async => null;
  @override
  Future<String?> getToken() async => token;
  @override
  Stream<PushMessage> get openedMessages => opened.stream;
  @override
  Future<PushPermission> requestPermission() async {
    permissionRequests++;
    return PushPermission.granted;
  }

  @override
  Stream<String> get tokenRefreshes => tokens.stream;
}

final class _DeviceIds implements DeviceIdentityStore {
  const _DeviceIds();
  @override
  Future<String> getOrCreate() async => 'device-1';
}

final class _AccountRepository implements AccountRepository {
  final registrations = <DeviceRegistration>[];
  final deletedDeviceIds = <String>[];
  @override
  Future<void> deleteDevice(String deviceId) async =>
      deletedDeviceIds.add(deviceId);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
  @override
  Future<UserAccount> getAccount() => throw UnimplementedError();
  @override
  Future<DomainPage<RegisteredDevice>> listDevices({String? cursor}) =>
      throw UnimplementedError();
  @override
  Future<RegisteredDevice> registerDevice(
    DeviceRegistration registration,
  ) async {
    registrations.add(registration);
    return RegisteredDevice(
      deviceId: registration.deviceId,
      platform: registration.platform,
      pushTokenRegistered: true,
    );
  }

  @override
  Future<UserPreferences> updateSettings(UserPreferencesPatch patch) =>
      throw UnimplementedError();
}
