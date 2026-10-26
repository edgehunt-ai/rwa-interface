// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_asset_identity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinancialAssetIdentityStatusEnum
    _$financialAssetIdentityStatusEnum_unknown =
    const FinancialAssetIdentityStatusEnum._('unknown');

FinancialAssetIdentityStatusEnum _$financialAssetIdentityStatusEnumValueOf(
    String name) {
  switch (name) {
    case 'unknown':
      return _$financialAssetIdentityStatusEnum_unknown;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialAssetIdentityStatusEnum>
    _$financialAssetIdentityStatusEnumValues = BuiltSet<
        FinancialAssetIdentityStatusEnum>(const <FinancialAssetIdentityStatusEnum>[
  _$financialAssetIdentityStatusEnum_unknown,
]);

const FinancialAssetIdentityNamespaceEnum
    _$financialAssetIdentityNamespaceEnum_eip155 =
    const FinancialAssetIdentityNamespaceEnum._('eip155');
const FinancialAssetIdentityNamespaceEnum
    _$financialAssetIdentityNamespaceEnum_hyperliquid =
    const FinancialAssetIdentityNamespaceEnum._('hyperliquid');

FinancialAssetIdentityNamespaceEnum
    _$financialAssetIdentityNamespaceEnumValueOf(String name) {
  switch (name) {
    case 'eip155':
      return _$financialAssetIdentityNamespaceEnum_eip155;
    case 'hyperliquid':
      return _$financialAssetIdentityNamespaceEnum_hyperliquid;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialAssetIdentityNamespaceEnum>
    _$financialAssetIdentityNamespaceEnumValues = BuiltSet<
        FinancialAssetIdentityNamespaceEnum>(const <FinancialAssetIdentityNamespaceEnum>[
  _$financialAssetIdentityNamespaceEnum_eip155,
  _$financialAssetIdentityNamespaceEnum_hyperliquid,
]);

const FinancialAssetIdentityEnvironmentEnum
    _$financialAssetIdentityEnvironmentEnum_mainnet =
    const FinancialAssetIdentityEnvironmentEnum._('mainnet');
const FinancialAssetIdentityEnvironmentEnum
    _$financialAssetIdentityEnvironmentEnum_testnet =
    const FinancialAssetIdentityEnvironmentEnum._('testnet');

FinancialAssetIdentityEnvironmentEnum
    _$financialAssetIdentityEnvironmentEnumValueOf(String name) {
  switch (name) {
    case 'mainnet':
      return _$financialAssetIdentityEnvironmentEnum_mainnet;
    case 'testnet':
      return _$financialAssetIdentityEnvironmentEnum_testnet;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialAssetIdentityEnvironmentEnum>
    _$financialAssetIdentityEnvironmentEnumValues = BuiltSet<
        FinancialAssetIdentityEnvironmentEnum>(const <FinancialAssetIdentityEnvironmentEnum>[
  _$financialAssetIdentityEnvironmentEnum_mainnet,
  _$financialAssetIdentityEnvironmentEnum_testnet,
]);

Serializer<FinancialAssetIdentityStatusEnum>
    _$financialAssetIdentityStatusEnumSerializer =
    _$FinancialAssetIdentityStatusEnumSerializer();
Serializer<FinancialAssetIdentityNamespaceEnum>
    _$financialAssetIdentityNamespaceEnumSerializer =
    _$FinancialAssetIdentityNamespaceEnumSerializer();
Serializer<FinancialAssetIdentityEnvironmentEnum>
    _$financialAssetIdentityEnvironmentEnumSerializer =
    _$FinancialAssetIdentityEnvironmentEnumSerializer();

class _$FinancialAssetIdentityStatusEnumSerializer
    implements PrimitiveSerializer<FinancialAssetIdentityStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[FinancialAssetIdentityStatusEnum];
  @override
  final String wireName = 'FinancialAssetIdentityStatusEnum';

  @override
  Object serialize(
          Serializers serializers, FinancialAssetIdentityStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialAssetIdentityStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialAssetIdentityStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinancialAssetIdentityNamespaceEnumSerializer
    implements PrimitiveSerializer<FinancialAssetIdentityNamespaceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'eip155': 'eip155',
    'hyperliquid': 'hyperliquid',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'eip155': 'eip155',
    'hyperliquid': 'hyperliquid',
  };

  @override
  final Iterable<Type> types = const <Type>[
    FinancialAssetIdentityNamespaceEnum
  ];
  @override
  final String wireName = 'FinancialAssetIdentityNamespaceEnum';

  @override
  Object serialize(
          Serializers serializers, FinancialAssetIdentityNamespaceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialAssetIdentityNamespaceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialAssetIdentityNamespaceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinancialAssetIdentityEnvironmentEnumSerializer
    implements PrimitiveSerializer<FinancialAssetIdentityEnvironmentEnum> {
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
    FinancialAssetIdentityEnvironmentEnum
  ];
  @override
  final String wireName = 'FinancialAssetIdentityEnvironmentEnum';

  @override
  Object serialize(
          Serializers serializers, FinancialAssetIdentityEnvironmentEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialAssetIdentityEnvironmentEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialAssetIdentityEnvironmentEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$FinancialAssetIdentity extends FinancialAssetIdentity {
  @override
  final OneOf oneOf;

  factory _$FinancialAssetIdentity(
          [void Function(FinancialAssetIdentityBuilder)? updates]) =>
      (FinancialAssetIdentityBuilder()..update(updates))._build();

  _$FinancialAssetIdentity._({required this.oneOf}) : super._();
  @override
  FinancialAssetIdentity rebuild(
          void Function(FinancialAssetIdentityBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FinancialAssetIdentityBuilder toBuilder() =>
      FinancialAssetIdentityBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FinancialAssetIdentity && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FinancialAssetIdentity')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class FinancialAssetIdentityBuilder
    implements Builder<FinancialAssetIdentity, FinancialAssetIdentityBuilder> {
  _$FinancialAssetIdentity? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  FinancialAssetIdentityBuilder() {
    FinancialAssetIdentity._defaults(this);
  }

  FinancialAssetIdentityBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FinancialAssetIdentity other) {
    _$v = other as _$FinancialAssetIdentity;
  }

  @override
  void update(void Function(FinancialAssetIdentityBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FinancialAssetIdentity build() => _build();

  _$FinancialAssetIdentity _build() {
    final _$result = _$v ??
        _$FinancialAssetIdentity._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'FinancialAssetIdentity', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
