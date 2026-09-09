abstract interface class PushMessagingGateway {
  bool get isSupported;

  Future<PushPermission> requestPermission();
  Future<String?> getToken();
  Future<PushMessage?> getInitialMessage();
  Stream<String> get tokenRefreshes;
  Stream<PushMessage> get openedMessages;
}

enum PushPermission { granted, denied, unavailable }

final class PushMessage {
  const PushMessage(this.data);

  final Map<String, String> data;
}
