// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'known_financial_asset_identity_not_not.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const KnownFinancialAssetIdentityNotNotEnvironmentEnum
    _$knownFinancialAssetIdentityNotNotEnvironmentEnum_mainnet =
    const KnownFinancialAssetIdentityNotNotEnvironmentEnum._('mainnet');
const KnownFinancialAssetIdentityNotNotEnvironmentEnum
    _$knownFinancialAssetIdentityNotNotEnvironmentEnum_testnet =
    const KnownFinancialAssetIdentityNotNotEnvironmentEnum._('testnet');

KnownFinancialAssetIdentityNotNotEnvironmentEnum
    _$knownFinancialAssetIdentityNotNotEnvironmentEnumValueOf(String name) {
  switch (name) {
    case 'mainnet':
      return _$knownFinancialAssetIdentityNotNotEnvironmentEnum_mainnet;
    case 'testnet':
      return _$knownFinancialAssetIdentityNotNotEnvironmentEnum_testnet;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<KnownFinancialAssetIdentityNotNotEnvironmentEnum>
    _$knownFinancialAssetIdentityNotNotEnvironmentEnumValues = BuiltSet<
        KnownFinancialAssetIdentityNotNotEnvironmentEnum>(const <KnownFinancialAssetIdentityNotNotEnvironmentEnum>[
  _$knownFinancialAssetIdentityNotNotEnvironmentEnum_mainnet,
  _$knownFinancialAssetIdentityNotNotEnvironmentEnum_testnet,
]);

Serializer<KnownFinancialAssetIdentityNotNotEnvironmentEnum>
    _$knownFinancialAssetIdentityNotNotEnvironmentEnumSerializer =
    _$KnownFinancialAssetIdentityNotNotEnvironmentEnumSerializer();

class _$KnownFinancialAssetIdentityNotNotEnvironmentEnumSerializer
    implements
        PrimitiveSerializer<KnownFinancialAssetIdentityNotNotEnvironmentEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mainnet': 'mainnet',
    'testnet': 'testnet',
  };

  @override
  final Iterable<Type> types = const <Type>[
    KnownFinancialAssetIdentityNotNotEnvironmentEnum
  ];
  @override
  final String wireName = 'KnownFinancialAssetIdentityNotNotEnvironmentEnum';

  @override
  Object serialize(Serializers serializers,
          KnownFinancialAssetIdentityNotNotEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  KnownFinancialAssetIdentityNotNotEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      KnownFinancialAssetIdentityNotNotEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$KnownFinancialAssetIdentityNotNot
    extends KnownFinancialAssetIdentityNotNot {
  @override
  final KnownFinancialAssetIdentityNotNotEnvironmentEnum environment;

  factory _$KnownFinancialAssetIdentityNotNot(
          [void Function(KnownFinancialAssetIdentityNotNotBuilder)? updates]) =>
      (KnownFinancialAssetIdentityNotNotBuilder()..update(updates))._build();

  _$KnownFinancialAssetIdentityNotNot._({required this.environment})
      : super._();
  @override
  KnownFinancialAssetIdentityNotNot rebuild(
          void Function(KnownFinancialAssetIdentityNotNotBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KnownFinancialAssetIdentityNotNotBuilder toBuilder() =>
      KnownFinancialAssetIdentityNotNotBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KnownFinancialAssetIdentityNotNot &&
        environment == other.environment;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, environment.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KnownFinancialAssetIdentityNotNot')
          ..add('environment', environment))
        .toString();
  }
}

class KnownFinancialAssetIdentityNotNotBuilder
    implements
        Builder<KnownFinancialAssetIdentityNotNot,
            KnownFinancialAssetIdentityNotNotBuilder> {
  _$KnownFinancialAssetIdentityNotNot? _$v;

  KnownFinancialAssetIdentityNotNotEnvironmentEnum? _environment;
  KnownFinancialAssetIdentityNotNotEnvironmentEnum? get environment =>
      _$this._environment;
  set environment(
          KnownFinancialAssetIdentityNotNotEnvironmentEnum? environment) =>
      _$this._environment = environment;

  KnownFinancialAssetIdentityNotNotBuilder() {
    KnownFinancialAssetIdentityNotNot._defaults(this);
  }

  KnownFinancialAssetIdentityNotNotBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _environment = $v.environment;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KnownFinancialAssetIdentityNotNot other) {
    _$v = other as _$KnownFinancialAssetIdentityNotNot;
  }

  @override
  void update(
      void Function(KnownFinancialAssetIdentityNotNotBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KnownFinancialAssetIdentityNotNot build() => _build();

  _$KnownFinancialAssetIdentityNotNot _build() {
    final _$result = _$v ??
        _$KnownFinancialAssetIdentityNotNot._(
          environment: BuiltValueNullFieldError.checkNotNull(
              environment, r'KnownFinancialAssetIdentityNotNot', 'environment'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
