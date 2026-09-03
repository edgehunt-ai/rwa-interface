// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privy_client_config.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PrivyClientConfigLoginMethodsEnum
    _$privyClientConfigLoginMethodsEnum_email =
    const PrivyClientConfigLoginMethodsEnum._('email');
const PrivyClientConfigLoginMethodsEnum
    _$privyClientConfigLoginMethodsEnum_apple =
    const PrivyClientConfigLoginMethodsEnum._('apple');
const PrivyClientConfigLoginMethodsEnum
    _$privyClientConfigLoginMethodsEnum_google =
    const PrivyClientConfigLoginMethodsEnum._('google');
const PrivyClientConfigLoginMethodsEnum
    _$privyClientConfigLoginMethodsEnum_unknownDefaultOpenApi =
    const PrivyClientConfigLoginMethodsEnum._('unknownDefaultOpenApi');

PrivyClientConfigLoginMethodsEnum _$privyClientConfigLoginMethodsEnumValueOf(
    String name) {
  switch (name) {
    case 'email':
      return _$privyClientConfigLoginMethodsEnum_email;
    case 'apple':
      return _$privyClientConfigLoginMethodsEnum_apple;
    case 'google':
      return _$privyClientConfigLoginMethodsEnum_google;
    case 'unknownDefaultOpenApi':
      return _$privyClientConfigLoginMethodsEnum_unknownDefaultOpenApi;
    default:
      return _$privyClientConfigLoginMethodsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrivyClientConfigLoginMethodsEnum>
    _$privyClientConfigLoginMethodsEnumValues = BuiltSet<
        PrivyClientConfigLoginMethodsEnum>(const <PrivyClientConfigLoginMethodsEnum>[
  _$privyClientConfigLoginMethodsEnum_email,
  _$privyClientConfigLoginMethodsEnum_apple,
  _$privyClientConfigLoginMethodsEnum_google,
  _$privyClientConfigLoginMethodsEnum_unknownDefaultOpenApi,
]);

Serializer<PrivyClientConfigLoginMethodsEnum>
    _$privyClientConfigLoginMethodsEnumSerializer =
    _$PrivyClientConfigLoginMethodsEnumSerializer();

class _$PrivyClientConfigLoginMethodsEnumSerializer
    implements PrimitiveSerializer<PrivyClientConfigLoginMethodsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'email': 'email',
    'apple': 'apple',
    'google': 'google',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'email': 'email',
    'apple': 'apple',
    'google': 'google',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[PrivyClientConfigLoginMethodsEnum];
  @override
  final String wireName = 'PrivyClientConfigLoginMethodsEnum';

  @override
  Object serialize(
          Serializers serializers, PrivyClientConfigLoginMethodsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrivyClientConfigLoginMethodsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrivyClientConfigLoginMethodsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PrivyClientConfig extends PrivyClientConfig {
  @override
  final String privyAppId;
  @override
  final String? privyClientId;
  @override
  final BuiltList<PrivyClientConfigLoginMethodsEnum> loginMethods;
  @override
  final PrivyClientConfigEmbeddedWallet? embeddedWallet;
  @override
  final String? termsUrl;
  @override
  final String? privacyUrl;

  factory _$PrivyClientConfig(
          [void Function(PrivyClientConfigBuilder)? updates]) =>
      (PrivyClientConfigBuilder()..update(updates))._build();

  _$PrivyClientConfig._(
      {required this.privyAppId,
      this.privyClientId,
      required this.loginMethods,
      this.embeddedWallet,
      this.termsUrl,
      this.privacyUrl})
      : super._();
  @override
  PrivyClientConfig rebuild(void Function(PrivyClientConfigBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivyClientConfigBuilder toBuilder() =>
      PrivyClientConfigBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivyClientConfig &&
        privyAppId == other.privyAppId &&
        privyClientId == other.privyClientId &&
        loginMethods == other.loginMethods &&
        embeddedWallet == other.embeddedWallet &&
        termsUrl == other.termsUrl &&
        privacyUrl == other.privacyUrl;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, privyAppId.hashCode);
    _$hash = $jc(_$hash, privyClientId.hashCode);
    _$hash = $jc(_$hash, loginMethods.hashCode);
    _$hash = $jc(_$hash, embeddedWallet.hashCode);
    _$hash = $jc(_$hash, termsUrl.hashCode);
    _$hash = $jc(_$hash, privacyUrl.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivyClientConfig')
          ..add('privyAppId', privyAppId)
          ..add('privyClientId', privyClientId)
          ..add('loginMethods', loginMethods)
          ..add('embeddedWallet', embeddedWallet)
          ..add('termsUrl', termsUrl)
          ..add('privacyUrl', privacyUrl))
        .toString();
  }
}

class PrivyClientConfigBuilder
    implements Builder<PrivyClientConfig, PrivyClientConfigBuilder> {
  _$PrivyClientConfig? _$v;

  String? _privyAppId;
  String? get privyAppId => _$this._privyAppId;
  set privyAppId(String? privyAppId) => _$this._privyAppId = privyAppId;

  String? _privyClientId;
  String? get privyClientId => _$this._privyClientId;
  set privyClientId(String? privyClientId) =>
      _$this._privyClientId = privyClientId;

  ListBuilder<PrivyClientConfigLoginMethodsEnum>? _loginMethods;
  ListBuilder<PrivyClientConfigLoginMethodsEnum> get loginMethods =>
      _$this._loginMethods ??= ListBuilder<PrivyClientConfigLoginMethodsEnum>();
  set loginMethods(
          ListBuilder<PrivyClientConfigLoginMethodsEnum>? loginMethods) =>
      _$this._loginMethods = loginMethods;

  PrivyClientConfigEmbeddedWalletBuilder? _embeddedWallet;
  PrivyClientConfigEmbeddedWalletBuilder get embeddedWallet =>
      _$this._embeddedWallet ??= PrivyClientConfigEmbeddedWalletBuilder();
  set embeddedWallet(PrivyClientConfigEmbeddedWalletBuilder? embeddedWallet) =>
      _$this._embeddedWallet = embeddedWallet;

  String? _termsUrl;
  String? get termsUrl => _$this._termsUrl;
  set termsUrl(String? termsUrl) => _$this._termsUrl = termsUrl;

  String? _privacyUrl;
  String? get privacyUrl => _$this._privacyUrl;
  set privacyUrl(String? privacyUrl) => _$this._privacyUrl = privacyUrl;

  PrivyClientConfigBuilder() {
    PrivyClientConfig._defaults(this);
  }

  PrivyClientConfigBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _privyAppId = $v.privyAppId;
      _privyClientId = $v.privyClientId;
      _loginMethods = $v.loginMethods.toBuilder();
      _embeddedWallet = $v.embeddedWallet?.toBuilder();
      _termsUrl = $v.termsUrl;
      _privacyUrl = $v.privacyUrl;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivyClientConfig other) {
    _$v = other as _$PrivyClientConfig;
  }

  @override
  void update(void Function(PrivyClientConfigBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivyClientConfig build() => _build();

  _$PrivyClientConfig _build() {
    _$PrivyClientConfig _$result;
    try {
      _$result = _$v ??
          _$PrivyClientConfig._(
            privyAppId: BuiltValueNullFieldError.checkNotNull(
                privyAppId, r'PrivyClientConfig', 'privyAppId'),
            privyClientId: privyClientId,
            loginMethods: loginMethods.build(),
            embeddedWallet: _embeddedWallet?.build(),
            termsUrl: termsUrl,
            privacyUrl: privacyUrl,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'loginMethods';
        loginMethods.build();
        _$failedField = 'embeddedWallet';
        _embeddedWallet?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PrivyClientConfig', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
