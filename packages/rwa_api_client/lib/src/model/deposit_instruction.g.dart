// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deposit_instruction.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const DepositInstructionChainEnum _$depositInstructionChainEnum_arbitrum =
    const DepositInstructionChainEnum._('arbitrum');

DepositInstructionChainEnum _$depositInstructionChainEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$depositInstructionChainEnum_arbitrum;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositInstructionChainEnum>
    _$depositInstructionChainEnumValues =
    BuiltSet<DepositInstructionChainEnum>(const <DepositInstructionChainEnum>[
  _$depositInstructionChainEnum_arbitrum,
]);

const DepositInstructionChainIdEnum
    _$depositInstructionChainIdEnum_number42161 =
    const DepositInstructionChainIdEnum._('number42161');

DepositInstructionChainIdEnum _$depositInstructionChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number42161':
      return _$depositInstructionChainIdEnum_number42161;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositInstructionChainIdEnum>
    _$depositInstructionChainIdEnumValues = BuiltSet<
        DepositInstructionChainIdEnum>(const <DepositInstructionChainIdEnum>[
  _$depositInstructionChainIdEnum_number42161,
]);

const DepositInstructionTokenEnum _$depositInstructionTokenEnum_USDC =
    const DepositInstructionTokenEnum._('USDC');

DepositInstructionTokenEnum _$depositInstructionTokenEnumValueOf(String name) {
  switch (name) {
    case 'USDC':
      return _$depositInstructionTokenEnum_USDC;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositInstructionTokenEnum>
    _$depositInstructionTokenEnumValues =
    BuiltSet<DepositInstructionTokenEnum>(const <DepositInstructionTokenEnum>[
  _$depositInstructionTokenEnum_USDC,
]);

const DepositInstructionTokenContractEnum
    _$depositInstructionTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831 =
    const DepositInstructionTokenContractEnum._(
        'n0xaf88d065e77c8cc2239327c5edb3a432268e5831');

DepositInstructionTokenContractEnum
    _$depositInstructionTokenContractEnumValueOf(String name) {
  switch (name) {
    case 'n0xaf88d065e77c8cc2239327c5edb3a432268e5831':
      return _$depositInstructionTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositInstructionTokenContractEnum>
    _$depositInstructionTokenContractEnumValues = BuiltSet<
        DepositInstructionTokenContractEnum>(const <DepositInstructionTokenContractEnum>[
  _$depositInstructionTokenContractEnum_n0xaf88d065e77c8cc2239327c5edb3a432268e5831,
]);

const DepositInstructionTokenDecimalsEnum
    _$depositInstructionTokenDecimalsEnum_number6 =
    const DepositInstructionTokenDecimalsEnum._('number6');

DepositInstructionTokenDecimalsEnum
    _$depositInstructionTokenDecimalsEnumValueOf(String name) {
  switch (name) {
    case 'number6':
      return _$depositInstructionTokenDecimalsEnum_number6;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositInstructionTokenDecimalsEnum>
    _$depositInstructionTokenDecimalsEnumValues = BuiltSet<
        DepositInstructionTokenDecimalsEnum>(const <DepositInstructionTokenDecimalsEnum>[
  _$depositInstructionTokenDecimalsEnum_number6,
]);

const DepositInstructionConfirmationsRequiredEnum
    _$depositInstructionConfirmationsRequiredEnum_number20 =
    const DepositInstructionConfirmationsRequiredEnum._('number20');

DepositInstructionConfirmationsRequiredEnum
    _$depositInstructionConfirmationsRequiredEnumValueOf(String name) {
  switch (name) {
    case 'number20':
      return _$depositInstructionConfirmationsRequiredEnum_number20;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<DepositInstructionConfirmationsRequiredEnum>
    _$depositInstructionConfirmationsRequiredEnumValues = BuiltSet<
        DepositInstructionConfirmationsRequiredEnum>(const <DepositInstructionConfirmationsRequiredEnum>[
  _$depositInstructionConfirmationsRequiredEnum_number20,
]);

Serializer<DepositInstructionChainEnum>
    _$depositInstructionChainEnumSerializer =
    _$DepositInstructionChainEnumSerializer();
Serializer<DepositInstructionChainIdEnum>
    _$depositInstructionChainIdEnumSerializer =
    _$DepositInstructionChainIdEnumSerializer();
Serializer<DepositInstructionTokenEnum>
    _$depositInstructionTokenEnumSerializer =
    _$DepositInstructionTokenEnumSerializer();
Serializer<DepositInstructionTokenContractEnum>
    _$depositInstructionTokenContractEnumSerializer =
    _$DepositInstructionTokenContractEnumSerializer();
Serializer<DepositInstructionTokenDecimalsEnum>
    _$depositInstructionTokenDecimalsEnumSerializer =
    _$DepositInstructionTokenDecimalsEnumSerializer();
Serializer<DepositInstructionConfirmationsRequiredEnum>
    _$depositInstructionConfirmationsRequiredEnumSerializer =
    _$DepositInstructionConfirmationsRequiredEnumSerializer();

class _$DepositInstructionChainEnumSerializer
    implements PrimitiveSerializer<DepositInstructionChainEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'arbitrum': 'Arbitrum',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositInstructionChainEnum];
  @override
  final String wireName = 'DepositInstructionChainEnum';

  @override
  Object serialize(Serializers serializers, DepositInstructionChainEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositInstructionChainEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositInstructionChainEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositInstructionChainIdEnumSerializer
    implements PrimitiveSerializer<DepositInstructionChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number42161': 42161,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    42161: 'number42161',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositInstructionChainIdEnum];
  @override
  final String wireName = 'DepositInstructionChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, DepositInstructionChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositInstructionChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositInstructionChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositInstructionTokenEnumSerializer
    implements PrimitiveSerializer<DepositInstructionTokenEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'USDC': 'USDC',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
  };

  @override
  final Iterable<Type> types = const <Type>[DepositInstructionTokenEnum];
  @override
  final String wireName = 'DepositInstructionTokenEnum';

  @override
  Object serialize(Serializers serializers, DepositInstructionTokenEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositInstructionTokenEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositInstructionTokenEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositInstructionTokenContractEnumSerializer
    implements PrimitiveSerializer<DepositInstructionTokenContractEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        '0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '0xaf88d065e77c8cc2239327c5edb3a432268e5831':
        'n0xaf88d065e77c8cc2239327c5edb3a432268e5831',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DepositInstructionTokenContractEnum
  ];
  @override
  final String wireName = 'DepositInstructionTokenContractEnum';

  @override
  Object serialize(
          Serializers serializers, DepositInstructionTokenContractEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositInstructionTokenContractEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositInstructionTokenContractEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositInstructionTokenDecimalsEnumSerializer
    implements PrimitiveSerializer<DepositInstructionTokenDecimalsEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number6': 6,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    6: 'number6',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DepositInstructionTokenDecimalsEnum
  ];
  @override
  final String wireName = 'DepositInstructionTokenDecimalsEnum';

  @override
  Object serialize(
          Serializers serializers, DepositInstructionTokenDecimalsEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositInstructionTokenDecimalsEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositInstructionTokenDecimalsEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositInstructionConfirmationsRequiredEnumSerializer
    implements
        PrimitiveSerializer<DepositInstructionConfirmationsRequiredEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number20': 20,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    20: 'number20',
  };

  @override
  final Iterable<Type> types = const <Type>[
    DepositInstructionConfirmationsRequiredEnum
  ];
  @override
  final String wireName = 'DepositInstructionConfirmationsRequiredEnum';

  @override
  Object serialize(Serializers serializers,
          DepositInstructionConfirmationsRequiredEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  DepositInstructionConfirmationsRequiredEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      DepositInstructionConfirmationsRequiredEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$DepositInstruction extends DepositInstruction {
  @override
  final OneOf oneOf;

  factory _$DepositInstruction(
          [void Function(DepositInstructionBuilder)? updates]) =>
      (DepositInstructionBuilder()..update(updates))._build();

  _$DepositInstruction._({required this.oneOf}) : super._();
  @override
  DepositInstruction rebuild(
          void Function(DepositInstructionBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DepositInstructionBuilder toBuilder() =>
      DepositInstructionBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DepositInstruction && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'DepositInstruction')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class DepositInstructionBuilder
    implements Builder<DepositInstruction, DepositInstructionBuilder> {
  _$DepositInstruction? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  DepositInstructionBuilder() {
    DepositInstruction._defaults(this);
  }

  DepositInstructionBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DepositInstruction other) {
    _$v = other as _$DepositInstruction;
  }

  @override
  void update(void Function(DepositInstructionBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DepositInstruction build() => _build();

  _$DepositInstruction _build() {
    final _$result = _$v ??
        _$DepositInstruction._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'DepositInstruction', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
