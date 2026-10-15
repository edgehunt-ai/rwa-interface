// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hip3_position_protection_order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const Hip3PositionProtectionOrderRoleEnum
    _$hip3PositionProtectionOrderRoleEnum_takeProfit =
    const Hip3PositionProtectionOrderRoleEnum._('takeProfit');
const Hip3PositionProtectionOrderRoleEnum
    _$hip3PositionProtectionOrderRoleEnum_stopLoss =
    const Hip3PositionProtectionOrderRoleEnum._('stopLoss');

Hip3PositionProtectionOrderRoleEnum
    _$hip3PositionProtectionOrderRoleEnumValueOf(String name) {
  switch (name) {
    case 'takeProfit':
      return _$hip3PositionProtectionOrderRoleEnum_takeProfit;
    case 'stopLoss':
      return _$hip3PositionProtectionOrderRoleEnum_stopLoss;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3PositionProtectionOrderRoleEnum>
    _$hip3PositionProtectionOrderRoleEnumValues = BuiltSet<
        Hip3PositionProtectionOrderRoleEnum>(const <Hip3PositionProtectionOrderRoleEnum>[
  _$hip3PositionProtectionOrderRoleEnum_takeProfit,
  _$hip3PositionProtectionOrderRoleEnum_stopLoss,
]);

const Hip3PositionProtectionOrderSizeModeEnum
    _$hip3PositionProtectionOrderSizeModeEnum_entirePosition =
    const Hip3PositionProtectionOrderSizeModeEnum._('entirePosition');
const Hip3PositionProtectionOrderSizeModeEnum
    _$hip3PositionProtectionOrderSizeModeEnum_quantity =
    const Hip3PositionProtectionOrderSizeModeEnum._('quantity');

Hip3PositionProtectionOrderSizeModeEnum
    _$hip3PositionProtectionOrderSizeModeEnumValueOf(String name) {
  switch (name) {
    case 'entirePosition':
      return _$hip3PositionProtectionOrderSizeModeEnum_entirePosition;
    case 'quantity':
      return _$hip3PositionProtectionOrderSizeModeEnum_quantity;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3PositionProtectionOrderSizeModeEnum>
    _$hip3PositionProtectionOrderSizeModeEnumValues = BuiltSet<
        Hip3PositionProtectionOrderSizeModeEnum>(const <Hip3PositionProtectionOrderSizeModeEnum>[
  _$hip3PositionProtectionOrderSizeModeEnum_entirePosition,
  _$hip3PositionProtectionOrderSizeModeEnum_quantity,
]);

const Hip3PositionProtectionOrderTriggerReferenceEnum
    _$hip3PositionProtectionOrderTriggerReferenceEnum_mark =
    const Hip3PositionProtectionOrderTriggerReferenceEnum._('mark');

Hip3PositionProtectionOrderTriggerReferenceEnum
    _$hip3PositionProtectionOrderTriggerReferenceEnumValueOf(String name) {
  switch (name) {
    case 'mark':
      return _$hip3PositionProtectionOrderTriggerReferenceEnum_mark;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3PositionProtectionOrderTriggerReferenceEnum>
    _$hip3PositionProtectionOrderTriggerReferenceEnumValues = BuiltSet<
        Hip3PositionProtectionOrderTriggerReferenceEnum>(const <Hip3PositionProtectionOrderTriggerReferenceEnum>[
  _$hip3PositionProtectionOrderTriggerReferenceEnum_mark,
]);

const Hip3PositionProtectionOrderExecutionTypeEnum
    _$hip3PositionProtectionOrderExecutionTypeEnum_market =
    const Hip3PositionProtectionOrderExecutionTypeEnum._('market');
const Hip3PositionProtectionOrderExecutionTypeEnum
    _$hip3PositionProtectionOrderExecutionTypeEnum_limit =
    const Hip3PositionProtectionOrderExecutionTypeEnum._('limit');

Hip3PositionProtectionOrderExecutionTypeEnum
    _$hip3PositionProtectionOrderExecutionTypeEnumValueOf(String name) {
  switch (name) {
    case 'market':
      return _$hip3PositionProtectionOrderExecutionTypeEnum_market;
    case 'limit':
      return _$hip3PositionProtectionOrderExecutionTypeEnum_limit;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3PositionProtectionOrderExecutionTypeEnum>
    _$hip3PositionProtectionOrderExecutionTypeEnumValues = BuiltSet<
        Hip3PositionProtectionOrderExecutionTypeEnum>(const <Hip3PositionProtectionOrderExecutionTypeEnum>[
  _$hip3PositionProtectionOrderExecutionTypeEnum_market,
  _$hip3PositionProtectionOrderExecutionTypeEnum_limit,
]);

const Hip3PositionProtectionOrderActivationStatusEnum
    _$hip3PositionProtectionOrderActivationStatusEnum_active =
    const Hip3PositionProtectionOrderActivationStatusEnum._('active');

Hip3PositionProtectionOrderActivationStatusEnum
    _$hip3PositionProtectionOrderActivationStatusEnumValueOf(String name) {
  switch (name) {
    case 'active':
      return _$hip3PositionProtectionOrderActivationStatusEnum_active;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<Hip3PositionProtectionOrderActivationStatusEnum>
    _$hip3PositionProtectionOrderActivationStatusEnumValues = BuiltSet<
        Hip3PositionProtectionOrderActivationStatusEnum>(const <Hip3PositionProtectionOrderActivationStatusEnum>[
  _$hip3PositionProtectionOrderActivationStatusEnum_active,
]);

Serializer<Hip3PositionProtectionOrderRoleEnum>
    _$hip3PositionProtectionOrderRoleEnumSerializer =
    _$Hip3PositionProtectionOrderRoleEnumSerializer();
Serializer<Hip3PositionProtectionOrderSizeModeEnum>
    _$hip3PositionProtectionOrderSizeModeEnumSerializer =
    _$Hip3PositionProtectionOrderSizeModeEnumSerializer();
Serializer<Hip3PositionProtectionOrderTriggerReferenceEnum>
    _$hip3PositionProtectionOrderTriggerReferenceEnumSerializer =
    _$Hip3PositionProtectionOrderTriggerReferenceEnumSerializer();
Serializer<Hip3PositionProtectionOrderExecutionTypeEnum>
    _$hip3PositionProtectionOrderExecutionTypeEnumSerializer =
    _$Hip3PositionProtectionOrderExecutionTypeEnumSerializer();
Serializer<Hip3PositionProtectionOrderActivationStatusEnum>
    _$hip3PositionProtectionOrderActivationStatusEnumSerializer =
    _$Hip3PositionProtectionOrderActivationStatusEnumSerializer();

class _$Hip3PositionProtectionOrderRoleEnumSerializer
    implements PrimitiveSerializer<Hip3PositionProtectionOrderRoleEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'takeProfit': 'take_profit',
    'stopLoss': 'stop_loss',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'take_profit': 'takeProfit',
    'stop_loss': 'stopLoss',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3PositionProtectionOrderRoleEnum
  ];
  @override
  final String wireName = 'Hip3PositionProtectionOrderRoleEnum';

  @override
  Object serialize(
          Serializers serializers, Hip3PositionProtectionOrderRoleEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3PositionProtectionOrderRoleEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3PositionProtectionOrderRoleEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3PositionProtectionOrderSizeModeEnumSerializer
    implements PrimitiveSerializer<Hip3PositionProtectionOrderSizeModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'entirePosition': 'entire_position',
    'quantity': 'quantity',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'entire_position': 'entirePosition',
    'quantity': 'quantity',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3PositionProtectionOrderSizeModeEnum
  ];
  @override
  final String wireName = 'Hip3PositionProtectionOrderSizeModeEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3PositionProtectionOrderSizeModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3PositionProtectionOrderSizeModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3PositionProtectionOrderSizeModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3PositionProtectionOrderTriggerReferenceEnumSerializer
    implements
        PrimitiveSerializer<Hip3PositionProtectionOrderTriggerReferenceEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mark': 'mark',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'mark': 'mark',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3PositionProtectionOrderTriggerReferenceEnum
  ];
  @override
  final String wireName = 'Hip3PositionProtectionOrderTriggerReferenceEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3PositionProtectionOrderTriggerReferenceEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3PositionProtectionOrderTriggerReferenceEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3PositionProtectionOrderTriggerReferenceEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3PositionProtectionOrderExecutionTypeEnumSerializer
    implements
        PrimitiveSerializer<Hip3PositionProtectionOrderExecutionTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'market': 'market',
    'limit': 'limit',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'market': 'market',
    'limit': 'limit',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3PositionProtectionOrderExecutionTypeEnum
  ];
  @override
  final String wireName = 'Hip3PositionProtectionOrderExecutionTypeEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3PositionProtectionOrderExecutionTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3PositionProtectionOrderExecutionTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3PositionProtectionOrderExecutionTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3PositionProtectionOrderActivationStatusEnumSerializer
    implements
        PrimitiveSerializer<Hip3PositionProtectionOrderActivationStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'active': 'active',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'active': 'active',
  };

  @override
  final Iterable<Type> types = const <Type>[
    Hip3PositionProtectionOrderActivationStatusEnum
  ];
  @override
  final String wireName = 'Hip3PositionProtectionOrderActivationStatusEnum';

  @override
  Object serialize(Serializers serializers,
          Hip3PositionProtectionOrderActivationStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  Hip3PositionProtectionOrderActivationStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      Hip3PositionProtectionOrderActivationStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Hip3PositionProtectionOrder extends Hip3PositionProtectionOrder {
  @override
  final String orderId;
  @override
  final Hip3PositionProtectionOrderRoleEnum role;
  @override
  final Hip3PositionProtectionOrderSizeModeEnum sizeMode;
  @override
  final String quantity;
  @override
  final String triggerPrice;
  @override
  final Hip3PositionProtectionOrderTriggerReferenceEnum triggerReference;
  @override
  final Hip3PositionProtectionOrderExecutionTypeEnum executionType;
  @override
  final String? limitPrice;
  @override
  final Hip3PositionProtectionOrderActivationStatusEnum activationStatus;

  factory _$Hip3PositionProtectionOrder(
          [void Function(Hip3PositionProtectionOrderBuilder)? updates]) =>
      (Hip3PositionProtectionOrderBuilder()..update(updates))._build();

  _$Hip3PositionProtectionOrder._(
      {required this.orderId,
      required this.role,
      required this.sizeMode,
      required this.quantity,
      required this.triggerPrice,
      required this.triggerReference,
      required this.executionType,
      this.limitPrice,
      required this.activationStatus})
      : super._();
  @override
  Hip3PositionProtectionOrder rebuild(
          void Function(Hip3PositionProtectionOrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  Hip3PositionProtectionOrderBuilder toBuilder() =>
      Hip3PositionProtectionOrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Hip3PositionProtectionOrder &&
        orderId == other.orderId &&
        role == other.role &&
        sizeMode == other.sizeMode &&
        quantity == other.quantity &&
        triggerPrice == other.triggerPrice &&
        triggerReference == other.triggerReference &&
        executionType == other.executionType &&
        limitPrice == other.limitPrice &&
        activationStatus == other.activationStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, orderId.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, sizeMode.hashCode);
    _$hash = $jc(_$hash, quantity.hashCode);
    _$hash = $jc(_$hash, triggerPrice.hashCode);
    _$hash = $jc(_$hash, triggerReference.hashCode);
    _$hash = $jc(_$hash, executionType.hashCode);
    _$hash = $jc(_$hash, limitPrice.hashCode);
    _$hash = $jc(_$hash, activationStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Hip3PositionProtectionOrder')
          ..add('orderId', orderId)
          ..add('role', role)
          ..add('sizeMode', sizeMode)
          ..add('quantity', quantity)
          ..add('triggerPrice', triggerPrice)
          ..add('triggerReference', triggerReference)
          ..add('executionType', executionType)
          ..add('limitPrice', limitPrice)
          ..add('activationStatus', activationStatus))
        .toString();
  }
}

class Hip3PositionProtectionOrderBuilder
    implements
        Builder<Hip3PositionProtectionOrder,
            Hip3PositionProtectionOrderBuilder> {
  _$Hip3PositionProtectionOrder? _$v;

  String? _orderId;
  String? get orderId => _$this._orderId;
  set orderId(String? orderId) => _$this._orderId = orderId;

  Hip3PositionProtectionOrderRoleEnum? _role;
  Hip3PositionProtectionOrderRoleEnum? get role => _$this._role;
  set role(Hip3PositionProtectionOrderRoleEnum? role) => _$this._role = role;

  Hip3PositionProtectionOrderSizeModeEnum? _sizeMode;
  Hip3PositionProtectionOrderSizeModeEnum? get sizeMode => _$this._sizeMode;
  set sizeMode(Hip3PositionProtectionOrderSizeModeEnum? sizeMode) =>
      _$this._sizeMode = sizeMode;

  String? _quantity;
  String? get quantity => _$this._quantity;
  set quantity(String? quantity) => _$this._quantity = quantity;

  String? _triggerPrice;
  String? get triggerPrice => _$this._triggerPrice;
  set triggerPrice(String? triggerPrice) => _$this._triggerPrice = triggerPrice;

  Hip3PositionProtectionOrderTriggerReferenceEnum? _triggerReference;
  Hip3PositionProtectionOrderTriggerReferenceEnum? get triggerReference =>
      _$this._triggerReference;
  set triggerReference(
          Hip3PositionProtectionOrderTriggerReferenceEnum? triggerReference) =>
      _$this._triggerReference = triggerReference;

  Hip3PositionProtectionOrderExecutionTypeEnum? _executionType;
  Hip3PositionProtectionOrderExecutionTypeEnum? get executionType =>
      _$this._executionType;
  set executionType(
          Hip3PositionProtectionOrderExecutionTypeEnum? executionType) =>
      _$this._executionType = executionType;

  String? _limitPrice;
  String? get limitPrice => _$this._limitPrice;
  set limitPrice(String? limitPrice) => _$this._limitPrice = limitPrice;

  Hip3PositionProtectionOrderActivationStatusEnum? _activationStatus;
  Hip3PositionProtectionOrderActivationStatusEnum? get activationStatus =>
      _$this._activationStatus;
  set activationStatus(
          Hip3PositionProtectionOrderActivationStatusEnum? activationStatus) =>
      _$this._activationStatus = activationStatus;

  Hip3PositionProtectionOrderBuilder() {
    Hip3PositionProtectionOrder._defaults(this);
  }

  Hip3PositionProtectionOrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _orderId = $v.orderId;
      _role = $v.role;
      _sizeMode = $v.sizeMode;
      _quantity = $v.quantity;
      _triggerPrice = $v.triggerPrice;
      _triggerReference = $v.triggerReference;
      _executionType = $v.executionType;
      _limitPrice = $v.limitPrice;
      _activationStatus = $v.activationStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Hip3PositionProtectionOrder other) {
    _$v = other as _$Hip3PositionProtectionOrder;
  }

  @override
  void update(void Function(Hip3PositionProtectionOrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Hip3PositionProtectionOrder build() => _build();

  _$Hip3PositionProtectionOrder _build() {
    final _$result = _$v ??
        _$Hip3PositionProtectionOrder._(
          orderId: BuiltValueNullFieldError.checkNotNull(
              orderId, r'Hip3PositionProtectionOrder', 'orderId'),
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'Hip3PositionProtectionOrder', 'role'),
          sizeMode: BuiltValueNullFieldError.checkNotNull(
              sizeMode, r'Hip3PositionProtectionOrder', 'sizeMode'),
          quantity: BuiltValueNullFieldError.checkNotNull(
              quantity, r'Hip3PositionProtectionOrder', 'quantity'),
          triggerPrice: BuiltValueNullFieldError.checkNotNull(
              triggerPrice, r'Hip3PositionProtectionOrder', 'triggerPrice'),
          triggerReference: BuiltValueNullFieldError.checkNotNull(
              triggerReference,
              r'Hip3PositionProtectionOrder',
              'triggerReference'),
          executionType: BuiltValueNullFieldError.checkNotNull(
              executionType, r'Hip3PositionProtectionOrder', 'executionType'),
          limitPrice: limitPrice,
          activationStatus: BuiltValueNullFieldError.checkNotNull(
              activationStatus,
              r'Hip3PositionProtectionOrder',
              'activationStatus'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
