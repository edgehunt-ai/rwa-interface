// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_info.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeviceInfoPushProviderEnum _$deviceInfoPushProviderEnum_apns =
    const DeviceInfoPushProviderEnum._('apns');
const DeviceInfoPushProviderEnum _$deviceInfoPushProviderEnum_fcm =
    const DeviceInfoPushProviderEnum._('fcm');
const DeviceInfoPushProviderEnum
    _$deviceInfoPushProviderEnum_unknownDefaultOpenApi =
    const DeviceInfoPushProviderEnum._('unknownDefaultOpenApi');

DeviceInfoPushProviderEnum _$deviceInfoPushProviderEnumValueOf(String name) {
  switch (name) {
    case 'apns':
      return _$deviceInfoPushProviderEnum_apns;
    case 'fcm':
      return _$deviceInfoPushProviderEnum_fcm;
    case 'unknownDefaultOpenApi':
      return _$deviceInfoPushProviderEnum_unknownDefaultOpenApi;
    default:
      return _$deviceInfoPushProviderEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeviceInfoPushProviderEnum> _$deviceInfoPushProviderEnumValues =
    BuiltSet<DeviceInfoPushProviderEnum>(const <DeviceInfoPushProviderEnum>[
  _$deviceInfoPushProviderEnum_apns,
  _$deviceInfoPushProviderEnum_fcm,
  _$deviceInfoPushProviderEnum_unknownDefaultOpenApi,
]);

Serializer<DeviceInfoPushProviderEnum> _$deviceInfoPushProviderEnumSerializer =
    _$DeviceInfoPushProviderEnumSerializer();

class _$DeviceInfoPushProviderEnumSerializer
    implements PrimitiveSerializer<DeviceInfoPushProviderEnum> {
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
  final Iterable<Type> types = const <Type>[DeviceInfoPushProviderEnum];
  @override
  final String wireName = 'DeviceInfoPushProviderEnum';

  @override
  Object serialize(Serializers serializers, DeviceInfoPushProviderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DeviceInfoPushProviderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DeviceInfoPushProviderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DeviceInfo extends DeviceInfo {
  @override
  final String? deviceId;
  @override
  final String? platform;
  @override
  final String? appVersion;
  @override
  final String? pushToken;
  @override
  final DeviceInfoPushProviderEnum? pushProvider;

  factory _$DeviceInfo([void Function(DeviceInfoBuilder)? updates]) =>
      (DeviceInfoBuilder()..update(updates))._build();

  _$DeviceInfo._(
      {this.deviceId,
      this.platform,
      this.appVersion,
      this.pushToken,
      this.pushProvider})
      : super._();
  @override
  DeviceInfo rebuild(void Function(DeviceInfoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeviceInfoBuilder toBuilder() => DeviceInfoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeviceInfo &&
        deviceId == other.deviceId &&
        platform == other.platform &&
        appVersion == other.appVersion &&
        pushToken == other.pushToken &&
        pushProvider == other.pushProvider;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, deviceId.hashCode);
    _$hash = $jc(_$hash, platform.hashCode);
    _$hash = $jc(_$hash, appVersion.hashCode);
    _$hash = $jc(_$hash, pushToken.hashCode);
    _$hash = $jc(_$hash, pushProvider.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeviceInfo')
          ..add('deviceId', deviceId)
          ..add('platform', platform)
          ..add('appVersion', appVersion)
          ..add('pushToken', pushToken)
          ..add('pushProvider', pushProvider))
        .toString();
  }
}

class DeviceInfoBuilder implements Builder<DeviceInfo, DeviceInfoBuilder> {
  _$DeviceInfo? _$v;

  String? _deviceId;
  String? get deviceId => _$this._deviceId;
  set deviceId(String? deviceId) => _$this._deviceId = deviceId;

  String? _platform;
  String? get platform => _$this._platform;
  set platform(String? platform) => _$this._platform = platform;

  String? _appVersion;
  String? get appVersion => _$this._appVersion;
  set appVersion(String? appVersion) => _$this._appVersion = appVersion;

  String? _pushToken;
  String? get pushToken => _$this._pushToken;
  set pushToken(String? pushToken) => _$this._pushToken = pushToken;

  DeviceInfoPushProviderEnum? _pushProvider;
  DeviceInfoPushProviderEnum? get pushProvider => _$this._pushProvider;
  set pushProvider(DeviceInfoPushProviderEnum? pushProvider) =>
      _$this._pushProvider = pushProvider;

  DeviceInfoBuilder() {
    DeviceInfo._defaults(this);
  }

  DeviceInfoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _deviceId = $v.deviceId;
      _platform = $v.platform;
      _appVersion = $v.appVersion;
      _pushToken = $v.pushToken;
      _pushProvider = $v.pushProvider;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeviceInfo other) {
    _$v = other as _$DeviceInfo;
  }

  @override
  void update(void Function(DeviceInfoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeviceInfo build() => _build();

  _$DeviceInfo _build() {
    final _$result = _$v ??
        _$DeviceInfo._(
          deviceId: deviceId,
          platform: platform,
          appVersion: appVersion,
          pushToken: pushToken,
          pushProvider: pushProvider,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
