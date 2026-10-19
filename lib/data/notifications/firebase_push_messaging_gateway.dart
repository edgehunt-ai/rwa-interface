import 'dart:async';
import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../domain/notifications/push_messaging_gateway.dart';
import '../../firebase_options.dart';

final class FirebasePushMessagingGateway implements PushMessagingGateway {
  FirebasePushMessagingGateway({
    Future<FirebaseApp> Function()? initializeFirebase,
    this._messaging,
  }) : _initializeFirebase = initializeFirebase ?? _initializeDefaultFirebase;

  FirebaseMessaging? _messaging;
  final Future<FirebaseApp> Function() _initializeFirebase;
  Future<void>? _initialization;
  final _notifications = FlutterLocalNotificationsPlugin();
  final _localOpened = StreamController<PushMessage>.broadcast();
  int _notificationId = 0;

  static const _channel = AndroidNotificationChannel(
    'account_updates',
    'Account updates',
    description: 'Order, account and risk notifications',
    importance: Importance.high,
  );

  @override
  bool get isSupported =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  @override
  Future<PushPermission> requestPermission() async {
    if (!isSupported) return PushPermission.unavailable;
    await _ensureInitialized();
    final settings = await _firebaseMessaging.requestPermission();
    return switch (settings.authorizationStatus) {
      AuthorizationStatus.authorized ||
      AuthorizationStatus.provisional => PushPermission.granted,
      AuthorizationStatus.denied => PushPermission.denied,
      AuthorizationStatus.deniedPermanently => PushPermission.denied,
      AuthorizationStatus.notDetermined => PushPermission.denied,
    };
  }

  @override
  Future<String?> getToken() async {
    if (!isSupported) return null;
    await _ensureInitialized();
    return _firebaseMessaging.getToken();
  }

  @override
  Future<PushMessage?> getInitialMessage() async {
    if (!isSupported) return null;
    await _ensureInitialized();
    final localLaunch = await _notifications.getNotificationAppLaunchDetails();
    if (localLaunch?.didNotificationLaunchApp == true) {
      return _fromPayload(localLaunch?.notificationResponse?.payload);
    }
    final message = await _firebaseMessaging.getInitialMessage();
    return message == null ? null : _mapMessage(message);
  }

  @override
  Stream<String> get tokenRefreshes async* {
    if (!isSupported) return;
    await _ensureInitialized();
    yield* _firebaseMessaging.onTokenRefresh;
  }

  @override
  Stream<PushMessage> get openedMessages async* {
    if (!isSupported) return;
    await _ensureInitialized();
    yield* Stream<PushMessage>.multi((controller) {
      final remote = FirebaseMessaging.onMessageOpenedApp
          .map(_mapMessage)
          .listen(controller.addSync, onError: controller.addErrorSync);
      final local = _localOpened.stream.listen(controller.addSync);
      controller.onCancel = () async {
        await remote.cancel();
        await local.cancel();
      };
    });
  }

  @override
  Stream<PushMessage> get foregroundMessages async* {
    if (!isSupported) return;
    await _ensureInitialized();
    yield* FirebaseMessaging.onMessage.map(_mapMessage);
  }

  @override
  Future<void> showForegroundMessage(PushMessage message) async {
    if (!isSupported) return;
    final title = message.title?.trim() ?? '';
    final body = message.body?.trim() ?? '';
    if (title.isEmpty && body.isEmpty) return;
    await _ensureInitialized();
    await _notifications.show(
      id: _notificationId++ % 2147483647,
      title: title.isEmpty ? null : title,
      body: body.isEmpty ? null : body,
      notificationDetails: NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          importance: Importance.high,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(body),
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBanner: true,
          presentList: true,
          presentSound: true,
        ),
      ),
      payload: jsonEncode(message.data),
    );
  }

  Future<void> _ensureInitialized() => _initialization ??= _initialize();

  Future<void> _initialize() async {
    await _initializeFirebase();
    await _notifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('ic_notification'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      ),
      onDidReceiveNotificationResponse: (response) {
        final message = _fromPayload(response.payload);
        if (message != null) _localOpened.add(message);
      },
    );
    await _notifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(_channel);
    // Foreground display is handled by local notifications on both platforms.
    await _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: false,
      badge: false,
      sound: false,
    );
  }

  PushMessage? _fromPayload(String? payload) {
    if (payload == null) return null;
    try {
      final data = jsonDecode(payload);
      if (data is! Map<String, dynamic> ||
          data.values.any((value) => value is! String)) {
        return null;
      }
      return PushMessage(data.cast<String, String>());
    } on FormatException {
      return null;
    }
  }

  static Future<FirebaseApp> _initializeDefaultFirebase() {
    if (Firebase.apps.isNotEmpty) return Future.value(Firebase.app());
    return Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  FirebaseMessaging get _firebaseMessaging =>
      _messaging ??= FirebaseMessaging.instance;

  PushMessage _mapMessage(RemoteMessage message) => PushMessage(
    message.data.map((key, value) => MapEntry(key, value.toString())),
    title: message.notification?.title ?? message.data['title']?.toString(),
    body: message.notification?.body ?? message.data['body']?.toString(),
  );
}
