import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/notifications/firebase_push_messaging_gateway.dart';
import '../../data/notifications/shared_preferences_device_identity_store.dart';
import '../../domain/models/registered_device.dart';
import '../../domain/models/user_account.dart';
import '../../domain/notifications/push_messaging_gateway.dart';
import '../../domain/repositories/account_repository.dart';
import '../routing/routes.dart';
import 'api_providers.dart';

final pushMessagingGatewayProvider = Provider<PushMessagingGateway>(
  (ref) => FirebasePushMessagingGateway(),
);

final deviceIdentityStoreProvider = Provider<DeviceIdentityStore>(
  (ref) => SharedPreferencesDeviceIdentityStore(),
);

final pushNotificationCoordinatorProvider =
    Provider<PushNotificationCoordinator>((ref) {
      final coordinator = PushNotificationCoordinator(
        ref.watch(pushMessagingGatewayProvider),
        ref.watch(deviceIdentityStoreProvider),
        ref.watch(accountRepositoryProvider),
      );
      ref.onDispose(coordinator.dispose);
      return coordinator;
    });

final pushNotificationRouteProvider = StreamProvider<String>((ref) {
  return ref.watch(pushNotificationCoordinatorProvider).routes;
});

final class PushNotificationCoordinator {
  PushNotificationCoordinator(
    this._messaging,
    this._devices,
    this._accountRepository, {
    String? Function()? platform,
  }) : _platform = platform ?? _defaultPlatform;

  final PushMessagingGateway _messaging;
  final DeviceIdentityStore _devices;
  final AccountRepository _accountRepository;
  final String? Function() _platform;
  final _routes = StreamController<String>.broadcast();
  StreamSubscription<String>? _tokenRefreshSubscription;
  StreamSubscription<PushMessage>? _openedMessageSubscription;
  Future<void> _deviceMutation = Future<void>.value();
  int _activationGeneration = 0;
  int? _activeActivationGeneration;

  Stream<String> get routes => _routes.stream;

  Future<void> activate(UserPreferences preferences) async {
    final generation = ++_activationGeneration;
    _activeActivationGeneration = null;
    if (!_messaging.isSupported || !preferences.pushEnabled) return;

    try {
      _openedMessageSubscription ??= _messaging.openedMessages.listen(
        _handleMessage,
      );
      final initial = await _messaging.getInitialMessage();
      if (generation != _activationGeneration) return;
      if (initial != null) _handleMessage(initial);

      final permission = await _messaging.requestPermission();
      if (generation != _activationGeneration ||
          permission != PushPermission.granted) {
        return;
      }

      _activeActivationGeneration = generation;
      _tokenRefreshSubscription ??= _messaging.tokenRefreshes.listen((token) {
        final activeGeneration = _activeActivationGeneration;
        if (activeGeneration != null) {
          unawaited(_registerToken(token, activeGeneration));
        }
      });
      final token = await _messaging.getToken();
      if (generation != _activationGeneration) return;
      await _registerToken(token, generation);
    } catch (_) {
      // Firebase configuration and network failures must not block login.
    }
  }

  Future<void> deactivate() async {
    _activationGeneration++;
    _activeActivationGeneration = null;
    await _tokenRefreshSubscription?.cancel();
    await _openedMessageSubscription?.cancel();
    _tokenRefreshSubscription = null;
    _openedMessageSubscription = null;
    await _enqueueDeviceMutation(() async {
      try {
        final deviceId = await _devices.getOrCreate();
        await _accountRepository.deleteDevice(deviceId);
      } catch (_) {
        // The server expires stale tokens; local logout must remain available.
      }
    });
  }

  Future<void> dispose() async {
    _activationGeneration++;
    _activeActivationGeneration = null;
    await _tokenRefreshSubscription?.cancel();
    await _openedMessageSubscription?.cancel();
    await _routes.close();
  }

  Future<void> _registerToken(String? token, int generation) async {
    final platform = _platform();
    if (generation != _activationGeneration ||
        token == null ||
        token.isEmpty ||
        platform == null) {
      return;
    }
    await _enqueueDeviceMutation(() async {
      if (generation != _activationGeneration) return;
      final deviceId = await _devices.getOrCreate();
      if (generation != _activationGeneration) return;
      await _accountRepository.registerDevice(
        DeviceRegistration(
          deviceId: deviceId,
          platform: platform,
          pushToken: token,
          pushProvider: 'fcm',
        ),
      );
    });
  }

  Future<void> _enqueueDeviceMutation(Future<void> Function() operation) {
    final result = _deviceMutation.then((_) => operation());
    _deviceMutation = result.catchError((_) {});
    return result;
  }

  void _handleMessage(PushMessage message) {
    final route = message.data['route'] ?? message.data['deep_link'];
    if (route == null || !_allowedRoutes.contains(route)) return;
    _routes.add(route);
  }

  static String? _defaultPlatform() {
    if (kIsWeb) return null;
    return switch (defaultTargetPlatform) {
      TargetPlatform.android => 'android',
      TargetPlatform.iOS => 'ios',
      _ => null,
    };
  }

  static const _allowedRoutes = <String>{
    AppRoutes.activityPath,
    AppRoutes.assetsPath,
    AppRoutes.depositPath,
    AppRoutes.tradePath,
  };
}
