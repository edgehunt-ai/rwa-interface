final class RegisteredDevice {
  const RegisteredDevice({
    required this.deviceId,
    required this.platform,
    required this.pushTokenRegistered,
    this.appVersion,
    this.pushProvider,
    this.lastSeenAt,
    this.createdAt,
  });

  final String deviceId;
  final String platform;
  final String? appVersion;
  final String? pushProvider;
  final bool pushTokenRegistered;
  final DateTime? lastSeenAt;
  final DateTime? createdAt;
}

final class DeviceRegistration {
  const DeviceRegistration({
    required this.deviceId,
    required this.platform,
    required this.pushToken,
    this.appVersion,
    this.pushProvider,
  });

  final String deviceId;
  final String platform;
  final String pushToken;
  final String? appVersion;
  final String? pushProvider;
}
