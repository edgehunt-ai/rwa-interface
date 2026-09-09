import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../../domain/notifications/push_messaging_gateway.dart';
import '../../firebase_options.dart';

final class FirebasePushMessagingGateway implements PushMessagingGateway {
  FirebasePushMessagingGateway({
    Future<FirebaseApp> Function()? initializeFirebase,
  }) : _initializeFirebase = initializeFirebase ?? _initializeDefaultFirebase;

  FirebaseMessaging? _messaging;
  final Future<FirebaseApp> Function() _initializeFirebase;
  Future<void>? _initialization;

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
    yield* FirebaseMessaging.onMessageOpenedApp.map(_mapMessage);
  }

  Future<void> _ensureInitialized() =>
      _initialization ??= _initializeFirebase().then((_) {});

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
  );
}
