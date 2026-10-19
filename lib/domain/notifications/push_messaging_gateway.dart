abstract interface class PushMessagingGateway {
  bool get isSupported;

  Future<PushPermission> requestPermission();
  Future<String?> getToken();
  Future<void> showForegroundMessage(PushMessage message);
  Future<PushMessage?> getInitialMessage();
  Stream<String> get tokenRefreshes;
  Stream<PushMessage> get openedMessages;
  Stream<PushMessage> get foregroundMessages;
}

enum PushPermission { granted, denied, unavailable }

final class PushMessage {
  const PushMessage(this.data, {this.title, this.body});

  final Map<String, String> data;
  final String? title;
  final String? body;
}
