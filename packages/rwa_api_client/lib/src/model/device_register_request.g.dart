// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_register_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DeviceRegisterRequestPushProviderEnum
    _$deviceRegisterRequestPushProviderEnum_apns =
    const DeviceRegisterRequestPushProviderEnum._('apns');
const DeviceRegisterRequestPushProviderEnum
    _$deviceRegisterRequestPushProviderEnum_fcm =
    const DeviceRegisterRequestPushProviderEnum._('fcm');
const DeviceRegisterRequestPushProviderEnum
    _$deviceRegisterRequestPushProviderEnum_unknownDefaultOpenApi =
    const DeviceRegisterRequestPushProviderEnum._('unknownDefaultOpenApi');

DeviceRegisterRequestPushProviderEnum
    _$deviceRegisterRequestPushProviderEnumValueOf(String name) {
  switch (name) {
    case 'apns':
      return _$deviceRegisterRequestPushProviderEnum_apns;
    case 'fcm':
      return _$deviceRegisterRequestPushProviderEnum_fcm;
    case 'unknownDefaultOpenApi':
      return _$deviceRegisterRequestPushProviderEnum_unknownDefaultOpenApi;
    default:
      return _$deviceRegisterRequestPushProviderEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DeviceRegisterRequestPushProviderEnum>
    _$deviceRegisterRequestPushProviderEnumValues = BuiltSet<
        DeviceRegisterRequestPushProviderEnum>(const <DeviceRegisterRequestPushProviderEnum>[
  _$deviceRegisterRequestPushProviderEnum_apns,
  _$deviceRegisterRequestPushProviderEnum_fcm,
  _$deviceRegisterRequestPushProviderEnum_unknownDefaultOpenApi,
]);

Serializer<DeviceRegisterRequestPushProviderEnum>
    _$deviceRegisterRequestPushProviderEnumSerializer =
    _$DeviceRegisterRequestPushProviderEnumSerializer();

class _$DeviceRegisterRequestPushProviderEnumSerializer
    implements PrimitiveSerializer<DeviceRegisterRequestPushProviderEnum> {
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
  final Iterable<Type> types = const <Type>[
    DeviceRegisterRequestPushProviderEnum
  ];
  @override
  final String wireName = 'DeviceRegisterRequestPushProviderEnum';

  @override
  Object serialize(
          Serializers serializers, DeviceRegisterRequestPushProviderEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DeviceRegisterRequestPushProviderEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DeviceRegisterRequestPushProviderEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DeviceRegisterRequest extends DeviceRegisterRequest {
  @override
  final String deviceId;
  @override
  final String platform;
  @override
  final String? appVersion;
  @override
  final String pushToken;
  @override
  final DeviceRegisterRequestPushProviderEnum? pushProvider;

  factory _$DeviceRegisterRequest(
          [void Function(DeviceRegisterRequestBuilder)? updates]) =>
      (DeviceRegisterRequestBuilder()..update(updates))._build();

  _$DeviceRegisterRequest._(
      {required this.deviceId,
      required this.platform,
      this.appVersion,
      required this.pushToken,
      this.pushProvider})
      : super._();
  @override
  DeviceRegisterRequest rebuild(
          void Function(DeviceRegisterRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeviceRegisterRequestBuilder toBuilder() =>
      DeviceRegisterRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeviceRegisterRequest &&
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
    return (newBuiltValueToStringHelper(r'DeviceRegisterRequest')
          ..add('deviceId', deviceId)
          ..add('platform', platform)
          ..add('appVersion', appVersion)
          ..add('pushToken', pushToken)
          ..add('pushProvider', pushProvider))
        .toString();
  }
}

class DeviceRegisterRequestBuilder
    implements Builder<DeviceRegisterRequest, DeviceRegisterRequestBuilder> {
  _$DeviceRegisterRequest? _$v;

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

  DeviceRegisterRequestPushProviderEnum? _pushProvider;
  DeviceRegisterRequestPushProviderEnum? get pushProvider =>
      _$this._pushProvider;
  set pushProvider(DeviceRegisterRequestPushProviderEnum? pushProvider) =>
      _$this._pushProvider = pushProvider;

  DeviceRegisterRequestBuilder() {
    DeviceRegisterRequest._defaults(this);
  }

  DeviceRegisterRequestBuilder get _$this {
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
  void replace(DeviceRegisterRequest other) {
    _$v = other as _$DeviceRegisterRequest;
  }

  @override
  void update(void Function(DeviceRegisterRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeviceRegisterRequest build() => _build();

  _$DeviceRegisterRequest _build() {
    final _$result = _$v ??
        _$DeviceRegisterRequest._(
          deviceId: BuiltValueNullFieldError.checkNotNull(
              deviceId, r'DeviceRegisterRequest', 'deviceId'),
          platform: BuiltValueNullFieldError.checkNotNull(
              platform, r'DeviceRegisterRequest', 'platform'),
          appVersion: appVersion,
          pushToken: BuiltValueNullFieldError.checkNotNull(
              pushToken, r'DeviceRegisterRequest', 'pushToken'),
          pushProvider: pushProvider,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
