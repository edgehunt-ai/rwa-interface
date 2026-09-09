// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositChainIdEnum _$depositChainIdEnum_number42161 =
    const DepositChainIdEnum._('number42161');
const DepositChainIdEnum _$depositChainIdEnum_unknownDefaultOpenApi =
    const DepositChainIdEnum._('unknownDefaultOpenApi');

DepositChainIdEnum _$depositChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number42161':
      return _$depositChainIdEnum_number42161;
    case 'unknownDefaultOpenApi':
      return _$depositChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$depositChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositChainIdEnum> _$depositChainIdEnumValues =
    BuiltSet<DepositChainIdEnum>(const <DepositChainIdEnum>[
  _$depositChainIdEnum_number42161,
  _$depositChainIdEnum_unknownDefaultOpenApi,
]);

const DepositTokenEnum _$depositTokenEnum_USDC =
    const DepositTokenEnum._('USDC');
const DepositTokenEnum _$depositTokenEnum_unknownDefaultOpenApi =
    const DepositTokenEnum._('unknownDefaultOpenApi');

DepositTokenEnum _$depositTokenEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$depositTokenEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$depositTokenEnum_unknownDefaultOpenApi;
    default:
      return _$depositTokenEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositTokenEnum> _$depositTokenEnumValues =
    BuiltSet<DepositTokenEnum>(const <DepositTokenEnum>[
  _$depositTokenEnum_USDC,
  _$depositTokenEnum_unknownDefaultOpenApi,
]);

const DepositTokenContractEnum
    _$depositTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
    const DepositTokenContractEnum._(
        'n0xaf88d065e77c8cc2239327c5edb3a432268e5831');
const DepositTokenContractEnum
    _$depositTokenContractEnum_unknownDefaultOpenApi =
    const DepositTokenContractEnum._('unknownDefaultOpenApi');

DepositTokenContractEnum _$depositTokenContractEnumValueOf(String name) {
  switch (name) {
    case 'n0xaf88d065e77c8cc2239327c5edb3a432268e5831':
      return _$depositTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
    case 'unknownDefaultOpenApi':
      return _$depositTokenContractEnum_unknownDefaultOpenApi;
    default:
      return _$depositTokenContractEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositTokenContractEnum> _$depositTokenContractEnumValues =
    BuiltSet<DepositTokenContractEnum>(const <DepositTokenContractEnum>[
  _$depositTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831,
  _$depositTokenContractEnum_unknownDefaultOpenApi,
]);

const DepositTokenDecimalsEnum _$depositTokenDecimalsEnum_number6 =
    const DepositTokenDecimalsEnum._('number6');
const DepositTokenDecimalsEnum
    _$depositTokenDecimalsEnum_unknownDefaultOpenApi =
    const DepositTokenDecimalsEnum._('unknownDefaultOpenApi');

DepositTokenDecimalsEnum _$depositTokenDecimalsEnumValueOf(String name) {
  switch (name) {
    case 'number6':
      return _$depositTokenDecimalsEnum_number6;
    case 'unknownDefaultOpenApi':
      return _$depositTokenDecimalsEnum_unknownDefaultOpenApi;
    default:
      return _$depositTokenDecimalsEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<DepositTokenDecimalsEnum> _$depositTokenDecimalsEnumValues =
    BuiltSet<DepositTokenDecimalsEnum>(const <DepositTokenDecimalsEnum>[
  _$depositTokenDecimalsEnum_number6,
  _$depositTokenDecimalsEnum_unknownDefaultOpenApi,
]);

Serializer<DepositChainIdEnum> _$depositChainIdEnumSerializer =
    _$DepositChainIdEnumSerializer();
Serializer<DepositTokenEnum> _$depositTokenEnumSerializer =
    _$DepositTokenEnumSerializer();
Serializer<DepositTokenContractEnum> _$depositTokenContractEnumSerializer =
    _$DepositTokenContractEnumSerializer();
Serializer<DepositTokenDecimalsEnum> _$depositTokenDecimalsEnumSerializer =
    _$DepositTokenDecimalsEnumSerializer();

class _$DepositChainIdEnumSerializer
    implements PrimitiveSerializer<DepositChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number42161': 42161,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    42161: 'number42161',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositChainIdEnum];
  @override
  final String wireName = 'DepositChainIdEnum';

  @override
  Object serialize(Serializers serializers, DepositChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositChainIdEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositTokenEnumSerializer
    implements PrimitiveSerializer<DepositTokenEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositTokenEnum];
  @override
  final String wireName = 'DepositTokenEnum';

  @override
  Object serialize(Serializers serializers, DepositTokenEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositTokenEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositTokenEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositTokenContractEnumSerializer
    implements PrimitiveSerializer<DepositTokenContractEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        'n0xaf88d065e77c8cc2239327c5edb3a432268e5831',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositTokenContractEnum];
  @override
  final String wireName = 'DepositTokenContractEnum';

  @override
  Object serialize(Serializers serializers, DepositTokenContractEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositTokenContractEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositTokenContractEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositTokenDecimalsEnumSerializer
    implements PrimitiveSerializer<DepositTokenDecimalsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number6': 6,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    6: 'number6',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositTokenDecimalsEnum];
  @override
  final String wireName = 'DepositTokenDecimalsEnum';

  @override
  Object serialize(Serializers serializers, DepositTokenDecimalsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositTokenDecimalsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositTokenDecimalsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Deposit extends Deposit {
  @override
  final OneOf oneOf;

  factory _$Deposit([void Function(DepositBuilder)? updates]) =>
      (DepositBuilder()..update(updates))._build();

  _$Deposit._({required this.oneOf}) : super._();
  @override
  Deposit rebuild(void Function(DepositBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositBuilder toBuilder() => DepositBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Deposit && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'Deposit')..add('oneOf', oneOf))
        .toString();
  }
}

class DepositBuilder implements Builder<Deposit, DepositBuilder> {
  _$Deposit? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  DepositBuilder() {
    Deposit._defaults(this);
  }

  DepositBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Deposit other) {
    _$v = other as _$Deposit;
  }

  @override
  void update(void Function(DepositBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Deposit build() => _build();

  _$Deposit _build() {
    final _$result = _$v ??
        _$Deposit._(
          oneOf:
              BuiltValueNullFieldError.checkNotNull(oneOf, r'Deposit', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
