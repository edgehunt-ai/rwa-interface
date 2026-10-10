// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_email =
    const SessionRequestLoginMethodEnum._('email');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_sms =
    const SessionRequestLoginMethodEnum._('sms');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_google =
    const SessionRequestLoginMethodEnum._('google');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_apple =
    const SessionRequestLoginMethodEnum._('apple');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_twitter =
    const SessionRequestLoginMethodEnum._('twitter');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_discord =
    const SessionRequestLoginMethodEnum._('discord');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_github =
    const SessionRequestLoginMethodEnum._('github');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_wallet =
    const SessionRequestLoginMethodEnum._('wallet');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_passkey =
    const SessionRequestLoginMethodEnum._('passkey');
const SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnum_other =
    const SessionRequestLoginMethodEnum._('other');

SessionRequestLoginMethodEnum _$sessionRequestLoginMethodEnumValueOf(
    String name) {
  switch (name) {
    case 'email':
      return _$sessionRequestLoginMethodEnum_email;
    case 'sms':
      return _$sessionRequestLoginMethodEnum_sms;
    case 'google':
      return _$sessionRequestLoginMethodEnum_google;
    case 'apple':
      return _$sessionRequestLoginMethodEnum_apple;
    case 'twitter':
      return _$sessionRequestLoginMethodEnum_twitter;
    case 'discord':
      return _$sessionRequestLoginMethodEnum_discord;
    case 'github':
      return _$sessionRequestLoginMethodEnum_github;
    case 'wallet':
      return _$sessionRequestLoginMethodEnum_wallet;
    case 'passkey':
      return _$sessionRequestLoginMethodEnum_passkey;
    case 'other':
      return _$sessionRequestLoginMethodEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SessionRequestLoginMethodEnum>
    _$sessionRequestLoginMethodEnumValues = BuiltSet<
        SessionRequestLoginMethodEnum>(const <SessionRequestLoginMethodEnum>[
  _$sessionRequestLoginMethodEnum_email,
  _$sessionRequestLoginMethodEnum_sms,
  _$sessionRequestLoginMethodEnum_google,
  _$sessionRequestLoginMethodEnum_apple,
  _$sessionRequestLoginMethodEnum_twitter,
  _$sessionRequestLoginMethodEnum_discord,
  _$sessionRequestLoginMethodEnum_github,
  _$sessionRequestLoginMethodEnum_wallet,
  _$sessionRequestLoginMethodEnum_passkey,
  _$sessionRequestLoginMethodEnum_other,
]);

Serializer<SessionRequestLoginMethodEnum>
    _$sessionRequestLoginMethodEnumSerializer =
    _$SessionRequestLoginMethodEnumSerializer();

class _$SessionRequestLoginMethodEnumSerializer
    implements PrimitiveSerializer<SessionRequestLoginMethodEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'email': 'email',
    'sms': 'sms',
    'google': 'google',
    'apple': 'apple',
    'twitter': 'twitter',
    'discord': 'discord',
    'github': 'github',
    'wallet': 'wallet',
    'passkey': 'passkey',
    'other': 'other',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'email': 'email',
    'sms': 'sms',
    'google': 'google',
    'apple': 'apple',
    'twitter': 'twitter',
    'discord': 'discord',
    'github': 'github',
    'wallet': 'wallet',
    'passkey': 'passkey',
    'other': 'other',
  };

  @override
  final Iterable<Type> types = const <Type>[SessionRequestLoginMethodEnum];
  @override
  final String wireName = 'SessionRequestLoginMethodEnum';

  @override
  Object serialize(
          Serializers serializers, SessionRequestLoginMethodEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SessionRequestLoginMethodEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SessionRequestLoginMethodEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$SessionRequest extends SessionRequest {
  @override
  final String? language;
  @override
  final DeviceInfo? device;
  @override
  final SessionRequestLoginMethodEnum? loginMethod;

  factory _$SessionRequest([void Function(SessionRequestBuilder)? updates]) =>
      (SessionRequestBuilder()..update(updates))._build();

  _$SessionRequest._({this.language, this.device, this.loginMethod})
      : super._();
  @override
  SessionRequest rebuild(void Function(SessionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionRequestBuilder toBuilder() => SessionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionRequest &&
        language == other.language &&
        device == other.device &&
        loginMethod == other.loginMethod;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, language.hashCode);
    _$hash = $jc(_$hash, device.hashCode);
    _$hash = $jc(_$hash, loginMethod.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionRequest')
          ..add('language', language)
          ..add('device', device)
          ..add('loginMethod', loginMethod))
        .toString();
  }
}

class SessionRequestBuilder
    implements Builder<SessionRequest, SessionRequestBuilder> {
  _$SessionRequest? _$v;

  String? _language;
  String? get language => _$this._language;
  set language(String? language) => _$this._language = language;

  DeviceInfoBuilder? _device;
  DeviceInfoBuilder get device => _$this._device ??= DeviceInfoBuilder();
  set device(DeviceInfoBuilder? device) => _$this._device = device;

  SessionRequestLoginMethodEnum? _loginMethod;
  SessionRequestLoginMethodEnum? get loginMethod => _$this._loginMethod;
  set loginMethod(SessionRequestLoginMethodEnum? loginMethod) =>
      _$this._loginMethod = loginMethod;

  SessionRequestBuilder() {
    SessionRequest._defaults(this);
  }

  SessionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _language = $v.language;
      _device = $v.device?.toBuilder();
      _loginMethod = $v.loginMethod;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionRequest other) {
    _$v = other as _$SessionRequest;
  }

  @override
  void update(void Function(SessionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionRequest build() => _build();

  _$SessionRequest _build() {
    _$SessionRequest _$result;
    try {
      _$result = _$v ??
          _$SessionRequest._(
            language: language,
            device: _device?.build(),
            loginMethod: loginMethod,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'device';
        _device?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SessionRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
