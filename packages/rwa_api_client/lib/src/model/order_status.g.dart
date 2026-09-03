// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderStatus _$pendingSignature = const OrderStatus._('pendingSignature');
const OrderStatus _$submitted = const OrderStatus._('submitted');
const OrderStatus _$open = const OrderStatus._('open');
const OrderStatus _$partiallyFilled = const OrderStatus._('partiallyFilled');
const OrderStatus _$filled = const OrderStatus._('filled');
const OrderStatus _$cancelled = const OrderStatus._('cancelled');
const OrderStatus _$failed = const OrderStatus._('failed');
const OrderStatus _$ambiguous = const OrderStatus._('ambiguous');
const OrderStatus _$manualReview = const OrderStatus._('manualReview');
const OrderStatus _$unknownDefaultOpenApi =
    const OrderStatus._('unknownDefaultOpenApi');

OrderStatus _$valueOf(String name) {
  switch (name) {
    case 'pendingSignature':
      return _$pendingSignature;
    case 'submitted':
      return _$submitted;
    case 'open':
      return _$open;
    case 'partiallyFilled':
      return _$partiallyFilled;
    case 'filled':
      return _$filled;
    case 'cancelled':
      return _$cancelled;
    case 'failed':
      return _$failed;
    case 'ambiguous':
      return _$ambiguous;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderStatus> _$values =
    BuiltSet<OrderStatus>(const <OrderStatus>[
  _$pendingSignature,
  _$submitted,
  _$open,
  _$partiallyFilled,
  _$filled,
  _$cancelled,
  _$failed,
  _$ambiguous,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$OrderStatusMeta {
  const _$OrderStatusMeta();
  OrderStatus get pendingSignature => _$pendingSignature;
  OrderStatus get submitted => _$submitted;
  OrderStatus get open => _$open;
  OrderStatus get partiallyFilled => _$partiallyFilled;
  OrderStatus get filled => _$filled;
  OrderStatus get cancelled => _$cancelled;
  OrderStatus get failed => _$failed;
  OrderStatus get ambiguous => _$ambiguous;
  OrderStatus get manualReview => _$manualReview;
  OrderStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  OrderStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<OrderStatus> get values => _$values;
}

abstract class _$OrderStatusMixin {
  // ignore: non_constant_identifier_names
  _$OrderStatusMeta get OrderStatus => const _$OrderStatusMeta();
}

Serializer<OrderStatus> _$orderStatusSerializer = _$OrderStatusSerializer();

class _$OrderStatusSerializer implements PrimitiveSerializer<OrderStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pendingSignature': 'pending_signature',
    'submitted': 'submitted',
    'open': 'open',
    'partiallyFilled': 'partially_filled',
    'filled': 'filled',
    'cancelled': 'cancelled',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending_signature': 'pendingSignature',
    'submitted': 'submitted',
    'open': 'open',
    'partially_filled': 'partiallyFilled',
    'filled': 'filled',
    'cancelled': 'cancelled',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderStatus];
  @override
  final String wireName = 'OrderStatus';

  @override
  Object serialize(Serializers serializers, OrderStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
