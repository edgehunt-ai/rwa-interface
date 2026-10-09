// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderFundingModeEnum _$orderFundingModeEnum_unreservedTransferFrom =
    const OrderFundingModeEnum._('unreservedTransferFrom');

OrderFundingModeEnum _$orderFundingModeEnumValueOf(String name) {
  switch (name) {
    case 'unreservedTransferFrom':
      return _$orderFundingModeEnum_unreservedTransferFrom;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderFundingModeEnum> _$orderFundingModeEnumValues =
    BuiltSet<OrderFundingModeEnum>(const <OrderFundingModeEnum>[
  _$orderFundingModeEnum_unreservedTransferFrom,
]);

const OrderKindEnum _$orderKindEnum_perp = const OrderKindEnum._('perp');

OrderKindEnum _$orderKindEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$orderKindEnum_perp;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderKindEnum> _$orderKindEnumValues =
    BuiltSet<OrderKindEnum>(const <OrderKindEnum>[
  _$orderKindEnum_perp,
]);

const OrderWalletActionBlockerEnum
    _$orderWalletActionBlockerEnum_notApplicable =
    const OrderWalletActionBlockerEnum._('notApplicable');

OrderWalletActionBlockerEnum _$orderWalletActionBlockerEnumValueOf(
    String name) {
  switch (name) {
    case 'notApplicable':
      return _$orderWalletActionBlockerEnum_notApplicable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderWalletActionBlockerEnum>
    _$orderWalletActionBlockerEnumValues =
    BuiltSet<OrderWalletActionBlockerEnum>(const <OrderWalletActionBlockerEnum>[
  _$orderWalletActionBlockerEnum_notApplicable,
]);

const OrderChainIdEnum _$orderChainIdEnum_number56 =
    const OrderChainIdEnum._('number56');
const OrderChainIdEnum _$orderChainIdEnum_number97 =
    const OrderChainIdEnum._('number97');
const OrderChainIdEnum _$orderChainIdEnum_number31337 =
    const OrderChainIdEnum._('number31337');

OrderChainIdEnum _$orderChainIdEnumValueOf(String name) {
  switch (name) {
    case 'number56':
      return _$orderChainIdEnum_number56;
    case 'number97':
      return _$orderChainIdEnum_number97;
    case 'number31337':
      return _$orderChainIdEnum_number31337;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderChainIdEnum> _$orderChainIdEnumValues =
    BuiltSet<OrderChainIdEnum>(const <OrderChainIdEnum>[
  _$orderChainIdEnum_number56,
  _$orderChainIdEnum_number97,
  _$orderChainIdEnum_number31337,
]);

const OrderCancellationReasonEnum _$orderCancellationReasonEnum_userCancelled =
    const OrderCancellationReasonEnum._('userCancelled');
const OrderCancellationReasonEnum
    _$orderCancellationReasonEnum_insufficientBalance =
    const OrderCancellationReasonEnum._('insufficientBalance');
const OrderCancellationReasonEnum
    _$orderCancellationReasonEnum_insufficientAllowance =
    const OrderCancellationReasonEnum._('insufficientAllowance');

OrderCancellationReasonEnum _$orderCancellationReasonEnumValueOf(String name) {
  switch (name) {
    case 'userCancelled':
      return _$orderCancellationReasonEnum_userCancelled;
    case 'insufficientBalance':
      return _$orderCancellationReasonEnum_insufficientBalance;
    case 'insufficientAllowance':
      return _$orderCancellationReasonEnum_insufficientAllowance;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<OrderCancellationReasonEnum>
    _$orderCancellationReasonEnumValues =
    BuiltSet<OrderCancellationReasonEnum>(const <OrderCancellationReasonEnum>[
  _$orderCancellationReasonEnum_userCancelled,
  _$orderCancellationReasonEnum_insufficientBalance,
  _$orderCancellationReasonEnum_insufficientAllowance,
]);

Serializer<OrderFundingModeEnum> _$orderFundingModeEnumSerializer =
    _$OrderFundingModeEnumSerializer();
Serializer<OrderKindEnum> _$orderKindEnumSerializer =
    _$OrderKindEnumSerializer();
Serializer<OrderWalletActionBlockerEnum>
    _$orderWalletActionBlockerEnumSerializer =
    _$OrderWalletActionBlockerEnumSerializer();
Serializer<OrderChainIdEnum> _$orderChainIdEnumSerializer =
    _$OrderChainIdEnumSerializer();
Serializer<OrderCancellationReasonEnum>
    _$orderCancellationReasonEnumSerializer =
    _$OrderCancellationReasonEnumSerializer();

class _$OrderFundingModeEnumSerializer
    implements PrimitiveSerializer<OrderFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unreservedTransferFrom': 'unreserved_transfer_from',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unreserved_transfer_from': 'unreservedTransferFrom',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderFundingModeEnum];
  @override
  final String wireName = 'OrderFundingModeEnum';

  @override
  Object serialize(Serializers serializers, OrderFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderFundingModeEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderKindEnumSerializer implements PrimitiveSerializer<OrderKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderKindEnum];
  @override
  final String wireName = 'OrderKindEnum';

  @override
  Object serialize(Serializers serializers, OrderKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderKindEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderWalletActionBlockerEnumSerializer
    implements PrimitiveSerializer<OrderWalletActionBlockerEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'notApplicable': 'not_applicable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'not_applicable': 'notApplicable',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderWalletActionBlockerEnum];
  @override
  final String wireName = 'OrderWalletActionBlockerEnum';

  @override
  Object serialize(Serializers serializers, OrderWalletActionBlockerEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderWalletActionBlockerEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderWalletActionBlockerEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderChainIdEnumSerializer
    implements PrimitiveSerializer<OrderChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number56': 56,
    'number97': 97,
    'number31337': 31337,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    56: 'number56',
    97: 'number97',
    31337: 'number31337',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderChainIdEnum];
  @override
  final String wireName = 'OrderChainIdEnum';

  @override
  Object serialize(Serializers serializers, OrderChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderChainIdEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderCancellationReasonEnumSerializer
    implements PrimitiveSerializer<OrderCancellationReasonEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'userCancelled': 'user_cancelled',
    'insufficientBalance': 'insufficient_balance',
    'insufficientAllowance': 'insufficient_allowance',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'user_cancelled': 'userCancelled',
    'insufficient_balance': 'insufficientBalance',
    'insufficient_allowance': 'insufficientAllowance',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderCancellationReasonEnum];
  @override
  final String wireName = 'OrderCancellationReasonEnum';

  @override
  Object serialize(Serializers serializers, OrderCancellationReasonEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderCancellationReasonEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderCancellationReasonEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$Order extends Order {
  @override
  final OneOf oneOf;

  factory _$Order([void Function(OrderBuilder)? updates]) =>
      (OrderBuilder()..update(updates))._build();

  _$Order._({required this.oneOf}) : super._();
  @override
  Order rebuild(void Function(OrderBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderBuilder toBuilder() => OrderBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Order && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'Order')..add('oneOf', oneOf))
        .toString();
  }
}

class OrderBuilder implements Builder<Order, OrderBuilder> {
  _$Order? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  OrderBuilder() {
    Order._defaults(this);
  }

  OrderBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Order other) {
    _$v = other as _$Order;
  }

  @override
  void update(void Function(OrderBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Order build() => _build();

  _$Order _build() {
    final _$result = _$v ??
        _$Order._(
          oneOf:
              BuiltValueNullFieldError.checkNotNull(oneOf, r'Order', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
