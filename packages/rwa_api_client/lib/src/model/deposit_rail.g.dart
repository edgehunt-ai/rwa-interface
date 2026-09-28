// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_rail.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositRailChainEnum _$depositRailChainEnum_arbitrum =
    const DepositRailChainEnum._('arbitrum');

DepositRailChainEnum _$depositRailChainEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$depositRailChainEnum_arbitrum;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositRailChainEnum> _$depositRailChainEnumValues =
    BuiltSet<DepositRailChainEnum>(const <DepositRailChainEnum>[
  _$depositRailChainEnum_arbitrum,
]);

const DepositRailChainIdEnum _$depositRailChainIdEnum_number42161 =
    const DepositRailChainIdEnum._('number42161');

DepositRailChainIdEnum _$depositRailChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number42161':
      return _$depositRailChainIdEnum_number42161;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositRailChainIdEnum> _$depositRailChainIdEnumValues =
    BuiltSet<DepositRailChainIdEnum>(const <DepositRailChainIdEnum>[
  _$depositRailChainIdEnum_number42161,
]);

const DepositRailTokenEnum _$depositRailTokenEnum_USDC =
    const DepositRailTokenEnum._('USDC');

DepositRailTokenEnum _$depositRailTokenEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$depositRailTokenEnum_USDC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositRailTokenEnum> _$depositRailTokenEnumValues =
    BuiltSet<DepositRailTokenEnum>(const <DepositRailTokenEnum>[
  _$depositRailTokenEnum_USDC,
]);

const DepositRailTokenContractEnum
    _$depositRailTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
    const DepositRailTokenContractEnum._(
        'n0xaf88d065e77c8cc2239327c5edb3a432268e5831');

DepositRailTokenContractEnum _$depositRailTokenContractEnumValueOf(
    String name) {
  switch (name) {
    case 'n0xaf88d065e77c8cc2239327c5edb3a432268e5831':
      return _$depositRailTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositRailTokenContractEnum>
    _$depositRailTokenContractEnumValues =
    BuiltSet<DepositRailTokenContractEnum>(const <DepositRailTokenContractEnum>[
  _$depositRailTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831,
]);

const DepositRailTokenDecimalsEnum _$depositRailTokenDecimalsEnum_number6 =
    const DepositRailTokenDecimalsEnum._('number6');

DepositRailTokenDecimalsEnum _$depositRailTokenDecimalsEnumValueOf(
    String name) {
  switch (name) {
    case 'number6':
      return _$depositRailTokenDecimalsEnum_number6;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositRailTokenDecimalsEnum>
    _$depositRailTokenDecimalsEnumValues =
    BuiltSet<DepositRailTokenDecimalsEnum>(const <DepositRailTokenDecimalsEnum>[
  _$depositRailTokenDecimalsEnum_number6,
]);

const DepositRailConfirmationsRequiredEnum
    _$depositRailConfirmationsRequiredEnum_number20 =
    const DepositRailConfirmationsRequiredEnum._('number20');

DepositRailConfirmationsRequiredEnum
    _$depositRailConfirmationsRequiredEnumValueOf(String name) {
  switch (name) {
    case 'number20':
      return _$depositRailConfirmationsRequiredEnum_number20;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositRailConfirmationsRequiredEnum>
    _$depositRailConfirmationsRequiredEnumValues = BuiltSet<
        DepositRailConfirmationsRequiredEnum>(const <DepositRailConfirmationsRequiredEnum>[
  _$depositRailConfirmationsRequiredEnum_number20,
]);

Serializer<DepositRailChainEnum> _$depositRailChainEnumSerializer =
    _$DepositRailChainEnumSerializer();
Serializer<DepositRailChainIdEnum> _$depositRailChainIdEnumSerializer =
    _$DepositRailChainIdEnumSerializer();
Serializer<DepositRailTokenEnum> _$depositRailTokenEnumSerializer =
    _$DepositRailTokenEnumSerializer();
Serializer<DepositRailTokenContractEnum>
    _$depositRailTokenContractEnumSerializer =
    _$DepositRailTokenContractEnumSerializer();
Serializer<DepositRailTokenDecimalsEnum>
    _$depositRailTokenDecimalsEnumSerializer =
    _$DepositRailTokenDecimalsEnumSerializer();
Serializer<DepositRailConfirmationsRequiredEnum>
    _$depositRailConfirmationsRequiredEnumSerializer =
    _$DepositRailConfirmationsRequiredEnumSerializer();

class _$DepositRailChainEnumSerializer
    implements PrimitiveSerializer<DepositRailChainEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositRailChainEnum];
  @override
  final String wireName = 'DepositRailChainEnum';

  @override
  Object serialize(Serializers serializers, DepositRailChainEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositRailChainEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositRailChainEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositRailChainIdEnumSerializer
    implements PrimitiveSerializer<DepositRailChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number42161': 42161,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    42161: 'number42161',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositRailChainIdEnum];
  @override
  final String wireName = 'DepositRailChainIdEnum';

  @override
  Object serialize(Serializers serializers, DepositRailChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositRailChainIdEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositRailChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositRailTokenEnumSerializer
    implements PrimitiveSerializer<DepositRailTokenEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositRailTokenEnum];
  @override
  final String wireName = 'DepositRailTokenEnum';

  @override
  Object serialize(Serializers serializers, DepositRailTokenEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositRailTokenEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositRailTokenEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositRailTokenContractEnumSerializer
    implements PrimitiveSerializer<DepositRailTokenContractEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        'n0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositRailTokenContractEnum];
  @override
  final String wireName = 'DepositRailTokenContractEnum';

  @override
  Object serialize(Serializers serializers, DepositRailTokenContractEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositRailTokenContractEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositRailTokenContractEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositRailTokenDecimalsEnumSerializer
    implements PrimitiveSerializer<DepositRailTokenDecimalsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number6': 6,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    6: 'number6',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositRailTokenDecimalsEnum];
  @override
  final String wireName = 'DepositRailTokenDecimalsEnum';

  @override
  Object serialize(Serializers serializers, DepositRailTokenDecimalsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositRailTokenDecimalsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositRailTokenDecimalsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositRailConfirmationsRequiredEnumSerializer
    implements PrimitiveSerializer<DepositRailConfirmationsRequiredEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number20': 20,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    20: 'number20',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DepositRailConfirmationsRequiredEnum
  ];
  @override
  final String wireName = 'DepositRailConfirmationsRequiredEnum';

  @override
  Object serialize(
          Serializers serializers, DepositRailConfirmationsRequiredEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositRailConfirmationsRequiredEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositRailConfirmationsRequiredEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositRail extends DepositRail {
  @override
  final OneOf oneOf;

  factory _$DepositRail([void Function(DepositRailBuilder)? updates]) =>
      (DepositRailBuilder()..update(updates))._build();

  _$DepositRail._({required this.oneOf}) : super._();
  @override
  DepositRail rebuild(void Function(DepositRailBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositRailBuilder toBuilder() => DepositRailBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositRail && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'DepositRail')..add('oneOf', oneOf))
        .toString();
  }
}

class DepositRailBuilder implements Builder<DepositRail, DepositRailBuilder> {
  _$DepositRail? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  DepositRailBuilder() {
    DepositRail._defaults(this);
  }

  DepositRailBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositRail other) {
    _$v = other as _$DepositRail;
  }

  @override
  void update(void Function(DepositRailBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositRail build() => _build();

  _$DepositRail _build() {
    final _$result = _$v ??
        _$DepositRail._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'DepositRail', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
