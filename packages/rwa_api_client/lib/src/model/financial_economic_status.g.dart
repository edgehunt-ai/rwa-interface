// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_economic_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FinancialEconomicStatus _$reserved =
    const FinancialEconomicStatus._('reserved');
const FinancialEconomicStatus _$sourceDebited =
    const FinancialEconomicStatus._('sourceDebited');
const FinancialEconomicStatus _$inTransit =
    const FinancialEconomicStatus._('inTransit');
const FinancialEconomicStatus _$refundPending =
    const FinancialEconomicStatus._('refundPending');
const FinancialEconomicStatus _$partiallySettled =
    const FinancialEconomicStatus._('partiallySettled');
const FinancialEconomicStatus _$partiallyRefunded =
    const FinancialEconomicStatus._('partiallyRefunded');
const FinancialEconomicStatus _$credited =
    const FinancialEconomicStatus._('credited');
const FinancialEconomicStatus _$refunded =
    const FinancialEconomicStatus._('refunded');
const FinancialEconomicStatus _$compensated =
    const FinancialEconomicStatus._('compensated');
const FinancialEconomicStatus _$released =
    const FinancialEconomicStatus._('released');
const FinancialEconomicStatus _$settled =
    const FinancialEconomicStatus._('settled');
const FinancialEconomicStatus _$unknown =
    const FinancialEconomicStatus._('unknown');

FinancialEconomicStatus _$valueOf(String name) {
  switch (name) {
    case 'reserved':
      return _$reserved;
    case 'sourceDebited':
      return _$sourceDebited;
    case 'inTransit':
      return _$inTransit;
    case 'refundPending':
      return _$refundPending;
    case 'partiallySettled':
      return _$partiallySettled;
    case 'partiallyRefunded':
      return _$partiallyRefunded;
    case 'credited':
      return _$credited;
    case 'refunded':
      return _$refunded;
    case 'compensated':
      return _$compensated;
    case 'released':
      return _$released;
    case 'settled':
      return _$settled;
    case 'unknown':
      return _$unknown;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FinancialEconomicStatus> _$values =
    BuiltSet<FinancialEconomicStatus>(const <FinancialEconomicStatus>[
  _$reserved,
  _$sourceDebited,
  _$inTransit,
  _$refundPending,
  _$partiallySettled,
  _$partiallyRefunded,
  _$credited,
  _$refunded,
  _$compensated,
  _$released,
  _$settled,
  _$unknown,
]);

class _$FinancialEconomicStatusMeta {
  const _$FinancialEconomicStatusMeta();
  FinancialEconomicStatus get reserved => _$reserved;
  FinancialEconomicStatus get sourceDebited => _$sourceDebited;
  FinancialEconomicStatus get inTransit => _$inTransit;
  FinancialEconomicStatus get refundPending => _$refundPending;
  FinancialEconomicStatus get partiallySettled => _$partiallySettled;
  FinancialEconomicStatus get partiallyRefunded => _$partiallyRefunded;
  FinancialEconomicStatus get credited => _$credited;
  FinancialEconomicStatus get refunded => _$refunded;
  FinancialEconomicStatus get compensated => _$compensated;
  FinancialEconomicStatus get released => _$released;
  FinancialEconomicStatus get settled => _$settled;
  FinancialEconomicStatus get unknown => _$unknown;
  FinancialEconomicStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<FinancialEconomicStatus> get values => _$values;
}

abstract class _$FinancialEconomicStatusMixin {
  // ignore: non_constant_identifier_names
  _$FinancialEconomicStatusMeta get FinancialEconomicStatus =>
      const _$FinancialEconomicStatusMeta();
}

Serializer<FinancialEconomicStatus> _$financialEconomicStatusSerializer =
    _$FinancialEconomicStatusSerializer();

class _$FinancialEconomicStatusSerializer
    implements PrimitiveSerializer<FinancialEconomicStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'reserved': 'reserved',
    'sourceDebited': 'source_debited',
    'inTransit': 'in_transit',
    'refundPending': 'refund_pending',
    'partiallySettled': 'partially_settled',
    'partiallyRefunded': 'partially_refunded',
    'credited': 'credited',
    'refunded': 'refunded',
    'compensated': 'compensated',
    'released': 'released',
    'settled': 'settled',
    'unknown': 'unknown',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'reserved': 'reserved',
    'source_debited': 'sourceDebited',
    'in_transit': 'inTransit',
    'refund_pending': 'refundPending',
    'partially_settled': 'partiallySettled',
    'partially_refunded': 'partiallyRefunded',
    'credited': 'credited',
    'refunded': 'refunded',
    'compensated': 'compensated',
    'released': 'released',
    'settled': 'settled',
    'unknown': 'unknown',
  };

  @override
  final Iterable<Type> types = const <Type>[FinancialEconomicStatus];
  @override
  final String wireName = 'FinancialEconomicStatus';

  @override
  Object serialize(Serializers serializers, FinancialEconomicStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FinancialEconomicStatus deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FinancialEconomicStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
