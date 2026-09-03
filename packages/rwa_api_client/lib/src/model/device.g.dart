// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DevicePushProviderEnum _$devicePushProviderEnum_apns =
    const DevicePushProviderEnum._('apns');
const DevicePushProviderEnum _$devicePushProviderEnum_fcm =
    const DevicePushProviderEnum._('fcm');
const DevicePushProviderEnum _$devicePushProviderEnum_unknownDefaultOpenApi =
    const DevicePushProviderEnum._('unknownDefaultOpenApi');

DevicePushProviderEnum _$devicePushProviderEnumValueOf(String name) {
  switch (name) {
    case 'apns':
      return _$devicePushProviderEnum_apns;
    case 'fcm':
      return _$devicePushProviderEnum_fcm;
    case 'unknownDefaultOpenApi':
      return _$devicePushProviderEnum_unknownDefaultOpenApi;
    default:
      return _$devicePushProviderEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DevicePushProviderEnum> _$devicePushProviderEnumValues =
    BuiltSet<DevicePushProviderEnum>(const <DevicePushProviderEnum>[
  _$devicePushProviderEnum_apns,
  _$devicePushProviderEnum_fcm,
  _$devicePushProviderEnum_unknownDefaultOpenApi,
]);

Serializer<DevicePushProviderEnum> _$devicePushProviderEnumSerializer =
    _$DevicePushProviderEnumSerializer();

class _$DevicePushProviderEnumSerializer
    implements PrimitiveSerializer<DevicePushProviderEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'apns': 'apns',
    'fcm': 'fcm',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'apns': 'apns',
    'fcm': 'fcm',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DevicePushProviderEnum];
  @override
  final String wireName = 'DevicePushProviderEnum';

  @override
  Object serialize(Serializers serializers, DevicePushProviderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DevicePushProviderEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DevicePushProviderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Device extends Device {
  @override
  final String deviceId;
  @override
  final String platform;
  @override
  final String? appVersion;
  @override
  final DevicePushProviderEnum? pushProvider;
  @override
  final bool? pushTokenRegistered;
  @override
  final DateTime? lastSeenAt;
  @override
  final DateTime? createdAt;

  factory _$Device([void Function(DeviceBuilder)? updates]) =>
      (DeviceBuilder()..update(updates))._build();

  _$Device._(
      {required this.deviceId,
      required this.platform,
      this.appVersion,
      this.pushProvider,
      this.pushTokenRegistered,
      this.lastSeenAt,
      this.createdAt})
      : super._();
  @override
  Device rebuild(void Function(DeviceBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeviceBuilder toBuilder() => DeviceBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Device &&
        deviceId == other.deviceId &&
        platform == other.platform &&
        appVersion == other.appVersion &&
        pushProvider == other.pushProvider &&
        pushTokenRegistered == other.pushTokenRegistered &&
        lastSeenAt == other.lastSeenAt &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, appVersion.hashCode);
    _$hash = $jc(_$hash, pushProvider.hashCode);
    _$hash = $jc(_$hash, pushTokenRegistered.hashCode);
    _$hash = $jc(_$hash, lastSeenAt.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Device')
          ..add('deviceId', deviceId)
          ..add('platform', platform)
          ..add('appVersion', appVersion)
          ..add('pushProvider', pushProvider)
          ..add('pushTokenRegistered', pushTokenRegistered)
          ..add('lastSeenAt', lastSeenAt)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class DeviceBuilder implements Builder<Device, DeviceBuilder> {
  _$Device? _$v;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  DevicePushProviderEnum? _pushProvider;
  DevicePushProviderEnum? get pushProvider => _$this._pushProvider;
  set pushProvider(DevicePushProviderEnum? pushProvider) =>
      _$this._pushProvider = pushProvider;

  bool? _pushTokenRegistered;
  bool? get pushTokenRegistered => _$this._pushTokenRegistered;
  set pushTokenRegistered(bool? pushTokenRegistered) =>
      _$this._pushTokenRegistered = pushTokenRegistered;

  DateTime? _lastSeenAt;
  DateTime? get lastSeenAt => _$this._lastSeenAt;
  set lastSeenAt(DateTime? lastSeenAt) => _$this._lastSeenAt = lastSeenAt;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DeviceBuilder() {
    Device._defaults(this);
  }

  DeviceBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _platform = $v.platform;
      _appVersion = $v.appVersion;
      _pushProvider = $v.pushProvider;
      _pushTokenRegistered = $v.pushTokenRegistered;
      _lastSeenAt = $v.lastSeenAt;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Device other) {
    _$v = other as _$Device;
  }

  @override
  void update(void Function(DeviceBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Device build() => _build();

  _$Device _build() {
    final _$result = _$v ??
        _$Device._(
          deviceId: BuiltValueNullFieldError.checkNotNull(
              deviceId, r'Device', 'deviceId'),
          platform: BuiltValueNullFieldError.checkNotNull(
              platform, r'Device', 'platform'),
          appVersion: appVersion,
          pushProvider: pushProvider,
          pushTokenRegistered: pushTokenRegistered,
          lastSeenAt: lastSeenAt,
          createdAt: createdAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
