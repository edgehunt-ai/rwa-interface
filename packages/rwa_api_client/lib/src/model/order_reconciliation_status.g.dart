// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_reconciliation_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const OrderReconciliationStatus _$pending =
    const OrderReconciliationStatus._('pending');
const OrderReconciliationStatus _$matched =
    const OrderReconciliationStatus._('matched');
const OrderReconciliationStatus _$conflicting =
    const OrderReconciliationStatus._('conflicting');
const OrderReconciliationStatus _$manualReview =
    const OrderReconciliationStatus._('manualReview');
const OrderReconciliationStatus _$unknownDefaultOpenApi =
    const OrderReconciliationStatus._('unknownDefaultOpenApi');

OrderReconciliationStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'matched':
      return _$matched;
    case 'conflicting':
      return _$conflicting;
    case 'manualReview':
      return _$manualReview;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<OrderReconciliationStatus> _$values =
    BuiltSet<OrderReconciliationStatus>(const <OrderReconciliationStatus>[
  _$pending,
  _$matched,
  _$conflicting,
  _$manualReview,
  _$unknownDefaultOpenApi,
]);

class _$OrderReconciliationStatusMeta {
  const _$OrderReconciliationStatusMeta();
  OrderReconciliationStatus get pending => _$pending;
  OrderReconciliationStatus get matched => _$matched;
  OrderReconciliationStatus get conflicting => _$conflicting;
  OrderReconciliationStatus get manualReview => _$manualReview;
  OrderReconciliationStatus get unknownDefaultOpenApi =>
      _$unknownDefaultOpenApi;
  OrderReconciliationStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<OrderReconciliationStatus> get values => _$values;
}

abstract class _$OrderReconciliationStatusMixin {
  // ignore: non_constant_identifier_names
  _$OrderReconciliationStatusMeta get OrderReconciliationStatus =>
      const _$OrderReconciliationStatusMeta();
}

Serializer<OrderReconciliationStatus> _$orderReconciliationStatusSerializer =
    _$OrderReconciliationStatusSerializer();

class _$OrderReconciliationStatusSerializer
    implements PrimitiveSerializer<OrderReconciliationStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'matched': 'matched',
    'conflicting': 'conflicting',
    'manualReview': 'manual_review',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'matched': 'matched',
    'conflicting': 'conflicting',
    'manual_review': 'manualReview',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[OrderReconciliationStatus];
  @override
  final String wireName = 'OrderReconciliationStatus';

  @override
  Object serialize(Serializers serializers, OrderReconciliationStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  OrderReconciliationStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      OrderReconciliationStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
