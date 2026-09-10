// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_opening_protection_confirmation_legs_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum
    _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_takeProfit =
    const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum._('takeProfit');
const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum
    _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_stopLoss =
    const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum._('stopLoss');
const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum
    _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_unknownDefaultOpenApi =
    const Hip3OpeningProtectionConfirmationLegsInnerRoleEnum._(
        'unknownDefaultOpenApi');

Hip3OpeningProtectionConfirmationLegsInnerRoleEnum
    _$hip3OpeningProtectionConfirmationLegsInnerRoleEnumValueOf(String name) {
  switch (name) {
    case 'takeProfit':
      return _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_takeProfit;
    case 'stopLoss':
      return _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_stopLoss;
    case 'unknownDefaultOpenApi':
      return _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_unknownDefaultOpenApi;
    default:
      return _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3OpeningProtectionConfirmationLegsInnerRoleEnum>
    _$hip3OpeningProtectionConfirmationLegsInnerRoleEnumValues = BuiltSet<
        Hip3OpeningProtectionConfirmationLegsInnerRoleEnum>(const <Hip3OpeningProtectionConfirmationLegsInnerRoleEnum>[
  _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_takeProfit,
  _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_stopLoss,
  _$hip3OpeningProtectionConfirmationLegsInnerRoleEnum_unknownDefaultOpenApi,
]);

const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum
    _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_market =
    const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum._(
        'market');
const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum
    _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_limit =
    const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum._(
        'limit');
const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum
    _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_unknownDefaultOpenApi =
    const Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum._(
        'unknownDefaultOpenApi');

Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum
    _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnumValueOf(
        String name) {
  switch (name) {
    case 'market':
      return _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_market;
    case 'limit':
      return _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_limit;
    case 'unknownDefaultOpenApi':
      return _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_unknownDefaultOpenApi;
    default:
      return _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum>
    _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnumValues =
    BuiltSet<
        Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum>(const <Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum>[
  _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_market,
  _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_limit,
  _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum_unknownDefaultOpenApi,
]);

Serializer<Hip3OpeningProtectionConfirmationLegsInnerRoleEnum>
    _$hip3OpeningProtectionConfirmationLegsInnerRoleEnumSerializer =
    _$Hip3OpeningProtectionConfirmationLegsInnerRoleEnumSerializer();
Serializer<Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum>
    _$hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnumSerializer =
    _$Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnumSerializer();

class _$Hip3OpeningProtectionConfirmationLegsInnerRoleEnumSerializer
    implements
        PrimitiveSerializer<
            Hip3OpeningProtectionConfirmationLegsInnerRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'takeProfit': 'take_profit',
    'stopLoss': 'stop_loss',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'take_profit': 'takeProfit',
    'stop_loss': 'stopLoss',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3OpeningProtectionConfirmationLegsInnerRoleEnum
  ];
  @override
  final String wireName = 'Hip3OpeningProtectionConfirmationLegsInnerRoleEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3OpeningProtectionConfirmationLegsInnerRoleEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3OpeningProtectionConfirmationLegsInnerRoleEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3OpeningProtectionConfirmationLegsInnerRoleEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnumSerializer
    implements
        PrimitiveSerializer<
            Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'market': 'market',
    'limit': 'limit',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'market': 'market',
    'limit': 'limit',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum
  ];
  @override
  final String wireName =
      'Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3OpeningProtectionConfirmationLegsInner
    extends Hip3OpeningProtectionConfirmationLegsInner {
  @override
  final Hip3OpeningProtectionConfirmationLegsInnerRoleEnum role;
  @override
  final String triggerPrice;
  @override
  final Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum
      executionType;
  @override
  final String executionPrice;

  factory _$Hip3OpeningProtectionConfirmationLegsInner(
          [void Function(Hip3OpeningProtectionConfirmationLegsInnerBuilder)?
              updates]) =>
      (Hip3OpeningProtectionConfirmationLegsInnerBuilder()..update(updates))
          ._build();

  _$Hip3OpeningProtectionConfirmationLegsInner._(
      {required this.role,
      required this.triggerPrice,
      required this.executionType,
      required this.executionPrice})
      : super._();
  @override
  Hip3OpeningProtectionConfirmationLegsInner rebuild(
          void Function(Hip3OpeningProtectionConfirmationLegsInnerBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3OpeningProtectionConfirmationLegsInnerBuilder toBuilder() =>
      Hip3OpeningProtectionConfirmationLegsInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3OpeningProtectionConfirmationLegsInner &&
        role == other.role &&
        triggerPrice == other.triggerPrice &&
        executionType == other.executionType &&
        executionPrice == other.executionPrice;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, triggerPrice.hashCode);
    _$hash = $jc(_$hash, executionType.hashCode);
    _$hash = $jc(_$hash, executionPrice.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'Hip3OpeningProtectionConfirmationLegsInner')
          ..add('role', role)
          ..add('triggerPrice', triggerPrice)
          ..add('executionType', executionType)
          ..add('executionPrice', executionPrice))
        .toString();
  }
}

class Hip3OpeningProtectionConfirmationLegsInnerBuilder
    implements
        Builder<Hip3OpeningProtectionConfirmationLegsInner,
            Hip3OpeningProtectionConfirmationLegsInnerBuilder> {
  _$Hip3OpeningProtectionConfirmationLegsInner? _$v;

  Hip3OpeningProtectionConfirmationLegsInnerRoleEnum? _role;
  Hip3OpeningProtectionConfirmationLegsInnerRoleEnum? get role => _$this._role;
  set role(Hip3OpeningProtectionConfirmationLegsInnerRoleEnum? role) =>
      _$this._role = role;

  String? _triggerPrice;
  String? get triggerPrice => _$this._triggerPrice;
  set triggerPrice(String? triggerPrice) => _$this._triggerPrice = triggerPrice;

  Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum? _executionType;
  Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum?
      get executionType => _$this._executionType;
  set executionType(
          Hip3OpeningProtectionConfirmationLegsInnerExecutionTypeEnum?
              executionType) =>
      _$this._executionType = executionType;

  String? _executionPrice;
  String? get executionPrice => _$this._executionPrice;
  set executionPrice(String? executionPrice) =>
      _$this._executionPrice = executionPrice;

  Hip3OpeningProtectionConfirmationLegsInnerBuilder() {
    Hip3OpeningProtectionConfirmationLegsInner._defaults(this);
  }

  Hip3OpeningProtectionConfirmationLegsInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _triggerPrice = $v.triggerPrice;
      _executionType = $v.executionType;
      _executionPrice = $v.executionPrice;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3OpeningProtectionConfirmationLegsInner other) {
    _$v = other as _$Hip3OpeningProtectionConfirmationLegsInner;
  }

  @override
  void update(
      void Function(Hip3OpeningProtectionConfirmationLegsInnerBuilder)?
          updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3OpeningProtectionConfirmationLegsInner build() => _build();

  _$Hip3OpeningProtectionConfirmationLegsInner _build() {
    final _$result = _$v ??
        _$Hip3OpeningProtectionConfirmationLegsInner._(
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'Hip3OpeningProtectionConfirmationLegsInner', 'role'),
          triggerPrice: BuiltValueNullFieldError.checkNotNull(triggerPrice,
              r'Hip3OpeningProtectionConfirmationLegsInner', 'triggerPrice'),
          executionType: BuiltValueNullFieldError.checkNotNull(executionType,
              r'Hip3OpeningProtectionConfirmationLegsInner', 'executionType'),
          executionPrice: BuiltValueNullFieldError.checkNotNull(executionPrice,
              r'Hip3OpeningProtectionConfirmationLegsInner', 'executionPrice'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
