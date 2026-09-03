// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_preview.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderPreviewKindEnum _$orderPreviewKindEnum_perp =
    const OrderPreviewKindEnum._('perp');
const OrderPreviewKindEnum _$orderPreviewKindEnum_unknownDefaultOpenApi =
    const OrderPreviewKindEnum._('unknownDefaultOpenApi');

OrderPreviewKindEnum _$orderPreviewKindEnumValueOf(String name) {
  switch (name) {
    case 'perp':
      return _$orderPreviewKindEnum_perp;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewKindEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewKindEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewKindEnum> _$orderPreviewKindEnumValues =
    BuiltSet<OrderPreviewKindEnum>(const <OrderPreviewKindEnum>[
  _$orderPreviewKindEnum_perp,
  _$orderPreviewKindEnum_unknownDefaultOpenApi,
]);

const OrderPreviewNetworkEnum _$orderPreviewNetworkEnum_arbitrum =
    const OrderPreviewNetworkEnum._('arbitrum');
const OrderPreviewNetworkEnum _$orderPreviewNetworkEnum_unknownDefaultOpenApi =
    const OrderPreviewNetworkEnum._('unknownDefaultOpenApi');

OrderPreviewNetworkEnum _$orderPreviewNetworkEnumValueOf(String name) {
  switch (name) {
    case 'arbitrum':
      return _$orderPreviewNetworkEnum_arbitrum;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewNetworkEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewNetworkEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewNetworkEnum> _$orderPreviewNetworkEnumValues =
    BuiltSet<OrderPreviewNetworkEnum>(const <OrderPreviewNetworkEnum>[
  _$orderPreviewNetworkEnum_arbitrum,
  _$orderPreviewNetworkEnum_unknownDefaultOpenApi,
]);

const OrderPreviewSettlementAssetEnum _$orderPreviewSettlementAssetEnum_USDC =
    const OrderPreviewSettlementAssetEnum._('USDC');
const OrderPreviewSettlementAssetEnum
    _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi =
    const OrderPreviewSettlementAssetEnum._('unknownDefaultOpenApi');

OrderPreviewSettlementAssetEnum _$orderPreviewSettlementAssetEnumValueOf(
    String name) {
  switch (name) {
    case 'USDC':
      return _$orderPreviewSettlementAssetEnum_USDC;
    case 'unknownDefaultOpenApi':
      return _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
    default:
      return _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderPreviewSettlementAssetEnum>
    _$orderPreviewSettlementAssetEnumValues = BuiltSet<
        OrderPreviewSettlementAssetEnum>(const <OrderPreviewSettlementAssetEnum>[
  _$orderPreviewSettlementAssetEnum_USDC,
  _$orderPreviewSettlementAssetEnum_unknownDefaultOpenApi,
]);

Serializer<OrderPreviewKindEnum> _$orderPreviewKindEnumSerializer =
    _$OrderPreviewKindEnumSerializer();
Serializer<OrderPreviewNetworkEnum> _$orderPreviewNetworkEnumSerializer =
    _$OrderPreviewNetworkEnumSerializer();
Serializer<OrderPreviewSettlementAssetEnum>
    _$orderPreviewSettlementAssetEnumSerializer =
    _$OrderPreviewSettlementAssetEnumSerializer();

class _$OrderPreviewKindEnumSerializer
    implements PrimitiveSerializer<OrderPreviewKindEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'perp': 'perp',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'perp': 'perp',
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
    'arbitrum': 'Arbitrum',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Arbitrum': 'arbitrum',
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
    'USDC': 'USDC',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'USDC': 'USDC',
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
