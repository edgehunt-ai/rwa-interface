import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nobell/data/notifications/firebase_push_messaging_gateway.dart';
import 'package:nobell/domain/notifications/push_messaging_gateway.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('dexterous.com/flutter/local_notifications');
  final calls = <MethodCall>[];
  late _Messaging messaging;
  late FirebasePushMessagingGateway gateway;
  Map<String, Object?>? launchDetails;

  setUp(() {
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    FlutterLocalNotificationsPlatform.instance =
        AndroidFlutterLocalNotificationsPlugin();
    calls.clear();
    launchDetails = null;
    messaging = _Messaging();
    gateway = FirebasePushMessagingGateway(
      initializeFirebase: () async => _App(),
      messaging: messaging,
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls.add(call);
          return switch (call.method) {
            'initialize' => true,
            'getNotificationAppLaunchDetails' => launchDetails,
            _ => null,
          };
        });
  });

  tearDown(() {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test(
    'shows a high importance system notification with the route payload',
    () async {
      const data = {'route': '/activity/order%2F123'};
      await gateway.showForegroundMessage(
        const PushMessage(
          data,
          title: 'Order updated',
          body: 'Your order filled',
        ),
      );
      final show = calls.singleWhere((call) => call.method == 'show');
      final arguments = show.arguments as Map;
      expect(arguments['title'], 'Order updated');
      expect(arguments['body'], 'Your order filled');
      expect(jsonDecode(arguments['payload'] as String), data);
      final android = arguments['platformSpecifics'] as Map;
      expect(android['channelId'], 'account_updates');
      expect(android['importance'], Importance.high.value);
      expect(
        android['icon'],
        isNull,
      ); // Uses the initialized notification icon.
      final initialization = calls.singleWhere(
        (call) => call.method == 'initialize',
      );
      expect(
        (initialization.arguments as Map)['defaultIcon'],
        'ic_notification',
      );
      expect(messaging.presentation, [false, false, false]);
      expect(
        calls.where((call) => call.method == 'createNotificationChannel'),
        hasLength(1),
      );
    },
  );

  test('does not display a notification for a silent data message', () async {
    await gateway.showForegroundMessage(
      const PushMessage({'route': '/activity'}),
    );
    expect(calls, isEmpty);
  });

  test(
    'restores the route when a local notification launches the app',
    () async {
      launchDetails = {
        'notificationLaunchedApp': true,
        'notificationResponse': {
          'notificationResponseType': 0,
          'id': 1,
          'payload': jsonEncode({'deep_link': '/activity/order%2F123'}),
        },
      };
      final message = await gateway.getInitialMessage();
      expect(message?.data, {'deep_link': '/activity/order%2F123'});
    },
  );

  test('local notification taps join the existing opened message stream', () async {
    final opened = gateway.openedMessages.first;
    // Wait for initialization and subscription before simulating a native tap.
    await gateway.getToken();
    await Future<void>.delayed(Duration.zero);
    await TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .handlePlatformMessage(
          channel.name,
          const StandardMethodCodec().encodeMethodCall(
            MethodCall('didReceiveNotificationResponse', {
              'notificationResponseType': 0,
              'id': 0,
              'payload': jsonEncode({'route': '/activity'}),
            }),
          ),
          (_) {},
        );
    expect((await opened).data, {'route': '/activity'});
  });
}

class _App implements FirebaseApp {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Messaging implements FirebaseMessaging {
  List<bool>? presentation;

  @override
  Future<void> setForegroundNotificationPresentationOptions({
    bool alert = false,
    bool badge = false,
    bool sound = false,
  }) async {
    presentation = [alert, badge, sound];
  }

  @override
  Future<String?> getToken({
    String? vapidKey,
    String? serviceWorkerScriptPath,
  }) async => 'token';

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
