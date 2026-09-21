// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderPreviewKindEnum _$orderPreviewKindEnum_bstock =
    const OrderPreviewKindEnum._('bstock');
const OrderPreviewKindEnum _$orderPreviewKindEnum_unknownDefaultOpenApi =
    const OrderPreviewKindEnum._('unknownDefaultOpenApi');

OrderPreviewKindEnum _$orderPreviewKindEnumValueOf(String name) {
  switch (name) {
    case 'bstock':
      return _$orderPreviewKindEnum_bstock;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewKindEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewKindEnum> _$orderPreviewKindEnumValues =
    BuiltSet<OrderPreviewKindEnum>(const <OrderPreviewKindEnum>[
  _$orderPreviewKindEnum_bstock,
  _$orderPreviewKindEnum_unknownDefaultOpenApi,
]);

const OrderPreviewNetworkEnum _$orderPreviewNetworkEnum_BSC =
    const OrderPreviewNetworkEnum._('BSC');
const OrderPreviewNetworkEnum _$orderPreviewNetworkEnum_unknownDefaultOpenApi =
    const OrderPreviewNetworkEnum._('unknownDefaultOpenApi');

OrderPreviewNetworkEnum _$orderPreviewNetworkEnumValueOf(String name) {
  switch (name) {
    case 'BSC':
      return _$orderPreviewNetworkEnum_BSC;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewNetworkEnum> _$orderPreviewNetworkEnumValues =
    BuiltSet<OrderPreviewNetworkEnum>(const <OrderPreviewNetworkEnum>[
  _$orderPreviewNetworkEnum_BSC,
  _$orderPreviewNetworkEnum_unknownDefaultOpenApi,
]);

const OrderPreviewSettlementAssetEnum _$orderPreviewSettlementAssetEnum_LUSDT =
    const OrderPreviewSettlementAssetEnum._('LUSDT');
const OrderPreviewSettlementAssetEnum
    _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi =
    const OrderPreviewSettlementAssetEnum._('unknownDefaultOpenApi');

OrderPreviewSettlementAssetEnum _$orderPreviewSettlementAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'LUSDT':
      return _$orderPreviewSettlementAssetEnum_LUSDT;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewSettlementAssetEnum>
    _$orderPreviewSettlementAssetEnumValues = BuiltSet<
        OrderPreviewSettlementAssetEnum>(const <OrderPreviewSettlementAssetEnum>[
  _$orderPreviewSettlementAssetEnum_LUSDT,
  _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi,
]);

const OrderPreviewSettlementChainIdEnum
    _$orderPreviewSettlementChainIdEnum_number56 =
    const OrderPreviewSettlementChainIdEnum._('number56');
const OrderPreviewSettlementChainIdEnum
    _$orderPreviewSettlementChainIdEnum_number31337 =
    const OrderPreviewSettlementChainIdEnum._('number31337');
const OrderPreviewSettlementChainIdEnum
    _$orderPreviewSettlementChainIdEnum_unknownDefaultOpenApi =
    const OrderPreviewSettlementChainIdEnum._('unknownDefaultOpenApi');

OrderPreviewSettlementChainIdEnum _$orderPreviewSettlementChainIdEnumValueOf(
    String name) {
  switch (name) {
    case 'number56':
      return _$orderPreviewSettlementChainIdEnum_number56;
    case 'number31337':
      return _$orderPreviewSettlementChainIdEnum_number31337;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewSettlementChainIdEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewSettlementChainIdEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewSettlementChainIdEnum>
    _$orderPreviewSettlementChainIdEnumValues = BuiltSet<
        OrderPreviewSettlementChainIdEnum>(const <OrderPreviewSettlementChainIdEnum>[
  _$orderPreviewSettlementChainIdEnum_number56,
  _$orderPreviewSettlementChainIdEnum_number31337,
  _$orderPreviewSettlementChainIdEnum_unknownDefaultOpenApi,
]);

const OrderPreviewFundingModeEnum
    _$orderPreviewFundingModeEnum_unreservedTransferFrom =
    const OrderPreviewFundingModeEnum._('unreservedTransferFrom');
const OrderPreviewFundingModeEnum
    _$orderPreviewFundingModeEnum_unknownDefaultOpenApi =
    const OrderPreviewFundingModeEnum._('unknownDefaultOpenApi');

OrderPreviewFundingModeEnum _$orderPreviewFundingModeEnumValueOf(String name) {
  switch (name) {
    case 'unreservedTransferFrom':
      return _$orderPreviewFundingModeEnum_unreservedTransferFrom;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewFundingModeEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewFundingModeEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewFundingModeEnum>
    _$orderPreviewFundingModeEnumValues =
    BuiltSet<OrderPreviewFundingModeEnum>(const <OrderPreviewFundingModeEnum>[
  _$orderPreviewFundingModeEnum_unreservedTransferFrom,
  _$orderPreviewFundingModeEnum_unknownDefaultOpenApi,
]);

Serializer<OrderPreviewKindEnum> _$orderPreviewKindEnumSerializer =
    _$OrderPreviewKindEnumSerializer();
Serializer<OrderPreviewNetworkEnum> _$orderPreviewNetworkEnumSerializer =
    _$OrderPreviewNetworkEnumSerializer();
Serializer<OrderPreviewSettlementAssetEnum>
    _$orderPreviewSettlementAssetEnumSerializer =
    _$OrderPreviewSettlementAssetEnumSerializer();
Serializer<OrderPreviewSettlementChainIdEnum>
    _$orderPreviewSettlementChainIdEnumSerializer =
    _$OrderPreviewSettlementChainIdEnumSerializer();
Serializer<OrderPreviewFundingModeEnum>
    _$orderPreviewFundingModeEnumSerializer =
    _$OrderPreviewFundingModeEnumSerializer();

class _$OrderPreviewKindEnumSerializer
    implements PrimitiveSerializer<OrderPreviewKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'bstock': 'bstock',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'bstock': 'bstock',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderPreviewKindEnum];
  @override
  final String wireName = 'OrderPreviewKindEnum';

  @override
  Object serialize(Serializers serializers, OrderPreviewKindEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderPreviewKindEnum deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderPreviewKindEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderPreviewNetworkEnumSerializer
    implements PrimitiveSerializer<OrderPreviewNetworkEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'BSC': 'BSC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'BSC': 'BSC',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderPreviewNetworkEnum];
  @override
  final String wireName = 'OrderPreviewNetworkEnum';

  @override
  Object serialize(Serializers serializers, OrderPreviewNetworkEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderPreviewNetworkEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderPreviewNetworkEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderPreviewSettlementAssetEnumSerializer
    implements PrimitiveSerializer<OrderPreviewSettlementAssetEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'LUSDT': 'LUSDT',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LUSDT': 'LUSDT',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderPreviewSettlementAssetEnum];
  @override
  final String wireName = 'OrderPreviewSettlementAssetEnum';

  @override
  Object serialize(
          Serializers serializers, OrderPreviewSettlementAssetEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderPreviewSettlementAssetEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderPreviewSettlementAssetEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderPreviewSettlementChainIdEnumSerializer
    implements PrimitiveSerializer<OrderPreviewSettlementChainIdEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'number56': 56,
    'number31337': 31337,
    'unknownDefaultOpenApi': 11184809,
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    56: 'number56',
    31337: 'number31337',
    11184809: 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderPreviewSettlementChainIdEnum];
  @override
  final String wireName = 'OrderPreviewSettlementChainIdEnum';

  @override
  Object serialize(
          Serializers serializers, OrderPreviewSettlementChainIdEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderPreviewSettlementChainIdEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderPreviewSettlementChainIdEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderPreviewFundingModeEnumSerializer
    implements PrimitiveSerializer<OrderPreviewFundingModeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'unreservedTransferFrom': 'unreserved_transfer_from',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'unreserved_transfer_from': 'unreservedTransferFrom',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderPreviewFundingModeEnum];
  @override
  final String wireName = 'OrderPreviewFundingModeEnum';

  @override
  Object serialize(Serializers serializers, OrderPreviewFundingModeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderPreviewFundingModeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderPreviewFundingModeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$OrderPreview extends OrderPreview {
  @override
  final OneOf oneOf;

  factory _$OrderPreview([void Function(OrderPreviewBuilder)? updates]) =>
      (OrderPreviewBuilder()..update(updates))._build();

  _$OrderPreview._({required this.oneOf}) : super._();
  @override
  OrderPreview rebuild(void Function(OrderPreviewBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderPreviewBuilder toBuilder() => OrderPreviewBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderPreview && oneOf == other.oneOf;
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
    return (newBuiltValueToStringHelper(r'OrderPreview')..add('oneOf', oneOf))
        .toString();
  }
}

class OrderPreviewBuilder
    implements Builder<OrderPreview, OrderPreviewBuilder> {
  _$OrderPreview? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  OrderPreviewBuilder() {
    OrderPreview._defaults(this);
  }

  OrderPreviewBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderPreview other) {
    _$v = other as _$OrderPreview;
  }

  @override
  void update(void Function(OrderPreviewBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderPreview build() => _build();

  _$OrderPreview _build() {
    final _$result = _$v ??
        _$OrderPreview._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'OrderPreview', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
