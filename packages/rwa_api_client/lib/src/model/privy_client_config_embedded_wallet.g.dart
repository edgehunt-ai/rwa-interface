// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'privy_client_config_embedded_wallet.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum
    _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_usersWithoutWallets =
    const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum._(
        'usersWithoutWallets');
const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum
    _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_allUsers =
    const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum._('allUsers');
const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum
    _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_false_ =
    const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum._('false_');
const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum
    _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_unknownDefaultOpenApi =
    const PrivyClientConfigEmbeddedWalletCreateOnLoginEnum._(
        'unknownDefaultOpenApi');

PrivyClientConfigEmbeddedWalletCreateOnLoginEnum
    _$privyClientConfigEmbeddedWalletCreateOnLoginEnumValueOf(String name) {
  switch (name) {
    case 'usersWithoutWallets':
      return _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_usersWithoutWallets;
    case 'allUsers':
      return _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_allUsers;
    case 'false_':
      return _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_false_;
    case 'unknownDefaultOpenApi':
      return _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_unknownDefaultOpenApi;
    default:
      return _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<PrivyClientConfigEmbeddedWalletCreateOnLoginEnum>
    _$privyClientConfigEmbeddedWalletCreateOnLoginEnumValues = BuiltSet<
        PrivyClientConfigEmbeddedWalletCreateOnLoginEnum>(const <PrivyClientConfigEmbeddedWalletCreateOnLoginEnum>[
  _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_usersWithoutWallets,
  _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_allUsers,
  _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_false_,
  _$privyClientConfigEmbeddedWalletCreateOnLoginEnum_unknownDefaultOpenApi,
]);

Serializer<PrivyClientConfigEmbeddedWalletCreateOnLoginEnum>
    _$privyClientConfigEmbeddedWalletCreateOnLoginEnumSerializer =
    _$PrivyClientConfigEmbeddedWalletCreateOnLoginEnumSerializer();

class _$PrivyClientConfigEmbeddedWalletCreateOnLoginEnumSerializer
    implements
        PrimitiveSerializer<PrivyClientConfigEmbeddedWalletCreateOnLoginEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'usersWithoutWallets': 'users-without-wallets',
    'allUsers': 'all-users',
    'false_': 'false',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'users-without-wallets': 'usersWithoutWallets',
    'all-users': 'allUsers',
    'false': 'false_',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    PrivyClientConfigEmbeddedWalletCreateOnLoginEnum
  ];
  @override
  final String wireName = 'PrivyClientConfigEmbeddedWalletCreateOnLoginEnum';

  @override
  Object serialize(Serializers serializers,
          PrivyClientConfigEmbeddedWalletCreateOnLoginEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PrivyClientConfigEmbeddedWalletCreateOnLoginEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PrivyClientConfigEmbeddedWalletCreateOnLoginEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$PrivyClientConfigEmbeddedWallet
    extends PrivyClientConfigEmbeddedWallet {
  @override
  final PrivyClientConfigEmbeddedWalletCreateOnLoginEnum? createOnLogin;
  @override
  final BuiltList<Chain>? chains;

  factory _$PrivyClientConfigEmbeddedWallet(
          [void Function(PrivyClientConfigEmbeddedWalletBuilder)? updates]) =>
      (PrivyClientConfigEmbeddedWalletBuilder()..update(updates))._build();

  _$PrivyClientConfigEmbeddedWallet._({this.createOnLogin, this.chains})
      : super._();
  @override
  PrivyClientConfigEmbeddedWallet rebuild(
          void Function(PrivyClientConfigEmbeddedWalletBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PrivyClientConfigEmbeddedWalletBuilder toBuilder() =>
      PrivyClientConfigEmbeddedWalletBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PrivyClientConfigEmbeddedWallet &&
        createOnLogin == other.createOnLogin &&
        chains == other.chains;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, createOnLogin.hashCode);
    _$hash = $jc(_$hash, chains.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'PrivyClientConfigEmbeddedWallet')
          ..add('createOnLogin', createOnLogin)
          ..add('chains', chains))
        .toString();
  }
}

class PrivyClientConfigEmbeddedWalletBuilder
    implements
        Builder<PrivyClientConfigEmbeddedWallet,
            PrivyClientConfigEmbeddedWalletBuilder> {
  _$PrivyClientConfigEmbeddedWallet? _$v;

  PrivyClientConfigEmbeddedWalletCreateOnLoginEnum? _createOnLogin;
  PrivyClientConfigEmbeddedWalletCreateOnLoginEnum? get createOnLogin =>
      _$this._createOnLogin;
  set createOnLogin(
          PrivyClientConfigEmbeddedWalletCreateOnLoginEnum? createOnLogin) =>
      _$this._createOnLogin = createOnLogin;

  ListBuilder<Chain>? _chains;
  ListBuilder<Chain> get chains => _$this._chains ??= ListBuilder<Chain>();
  set chains(ListBuilder<Chain>? chains) => _$this._chains = chains;

  PrivyClientConfigEmbeddedWalletBuilder() {
    PrivyClientConfigEmbeddedWallet._defaults(this);
  }

  PrivyClientConfigEmbeddedWalletBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _createOnLogin = $v.createOnLogin;
      _chains = $v.chains?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PrivyClientConfigEmbeddedWallet other) {
    _$v = other as _$PrivyClientConfigEmbeddedWallet;
  }

  @override
  void update(void Function(PrivyClientConfigEmbeddedWalletBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PrivyClientConfigEmbeddedWallet build() => _build();

  _$PrivyClientConfigEmbeddedWallet _build() {
    _$PrivyClientConfigEmbeddedWallet _$result;
    try {
      _$result = _$v ??
          _$PrivyClientConfigEmbeddedWallet._(
            createOnLogin: createOnLogin,
            chains: _chains?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'chains';
        _chains?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PrivyClientConfigEmbeddedWallet', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
