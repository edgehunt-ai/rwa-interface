// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstock_order_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstockOrderStatus _$pending = const BstockOrderStatus._('pending');
const BstockOrderStatus _$awaitingConfirmation =
    const BstockOrderStatus._('awaitingConfirmation');
const BstockOrderStatus _$submitted = const BstockOrderStatus._('submitted');
const BstockOrderStatus _$open = const BstockOrderStatus._('open');
const BstockOrderStatus _$partiallyFilled =
    const BstockOrderStatus._('partiallyFilled');
const BstockOrderStatus _$filled = const BstockOrderStatus._('filled');
const BstockOrderStatus _$cancelled = const BstockOrderStatus._('cancelled');
const BstockOrderStatus _$failed = const BstockOrderStatus._('failed');
const BstockOrderStatus _$ambiguous = const BstockOrderStatus._('ambiguous');
const BstockOrderStatus _$manualReview =
    const BstockOrderStatus._('manualReview');

BstockOrderStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'awaitingConfirmation':
      return _$awaitingConfirmation;
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
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstockOrderStatus> _$values =
    BuiltSet<BstockOrderStatus>(const <BstockOrderStatus>[
  _$pending,
  _$awaitingConfirmation,
  _$submitted,
  _$open,
  _$partiallyFilled,
  _$filled,
  _$cancelled,
  _$failed,
  _$ambiguous,
  _$manualReview,
]);

class _$BstockOrderStatusMeta {
  const _$BstockOrderStatusMeta();
  BstockOrderStatus get pending => _$pending;
  BstockOrderStatus get awaitingConfirmation => _$awaitingConfirmation;
  BstockOrderStatus get submitted => _$submitted;
  BstockOrderStatus get open => _$open;
  BstockOrderStatus get partiallyFilled => _$partiallyFilled;
  BstockOrderStatus get filled => _$filled;
  BstockOrderStatus get cancelled => _$cancelled;
  BstockOrderStatus get failed => _$failed;
  BstockOrderStatus get ambiguous => _$ambiguous;
  BstockOrderStatus get manualReview => _$manualReview;
  BstockOrderStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<BstockOrderStatus> get values => _$values;
}

abstract class _$BstockOrderStatusMixin {
  // ignore: non_constant_identifier_names
  _$BstockOrderStatusMeta get BstockOrderStatus =>
      const _$BstockOrderStatusMeta();
}

Serializer<BstockOrderStatus> _$bstockOrderStatusSerializer =
    _$BstockOrderStatusSerializer();

class _$BstockOrderStatusSerializer
    implements PrimitiveSerializer<BstockOrderStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'awaitingConfirmation': 'awaiting_confirmation',
    'submitted': 'submitted',
    'open': 'open',
    'partiallyFilled': 'partially_filled',
    'filled': 'filled',
    'cancelled': 'cancelled',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manualReview': 'manual_review',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'awaiting_confirmation': 'awaitingConfirmation',
    'submitted': 'submitted',
    'open': 'open',
    'partially_filled': 'partiallyFilled',
    'filled': 'filled',
    'cancelled': 'cancelled',
    'failed': 'failed',
    'ambiguous': 'ambiguous',
    'manual_review': 'manualReview',
  };

  @override
  final Iterable<Type> types = const <Type>[BstockOrderStatus];
  @override
  final String wireName = 'BstockOrderStatus';

  @override
  Object serialize(Serializers serializers, BstockOrderStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstockOrderStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstockOrderStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
