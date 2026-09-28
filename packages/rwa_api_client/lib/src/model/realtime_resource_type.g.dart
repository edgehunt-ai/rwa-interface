// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_resource_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeResourceType _$order = const RealtimeResourceType._('order');
const RealtimeResourceType _$position =
    const RealtimeResourceType._('position');
const RealtimeResourceType _$transfer =
    const RealtimeResourceType._('transfer');
const RealtimeResourceType _$claim = const RealtimeResourceType._('claim');
const RealtimeResourceType _$deposit = const RealtimeResourceType._('deposit');
const RealtimeResourceType _$withdrawal =
    const RealtimeResourceType._('withdrawal');
const RealtimeResourceType _$balance = const RealtimeResourceType._('balance');
const RealtimeResourceType _$activity =
    const RealtimeResourceType._('activity');
const RealtimeResourceType _$session = const RealtimeResourceType._('session');

RealtimeResourceType _$valueOf(String name) {
  switch (name) {
    case 'order':
      return _$order;
    case 'position':
      return _$position;
    case 'transfer':
      return _$transfer;
    case 'claim':
      return _$claim;
    case 'deposit':
      return _$deposit;
    case 'withdrawal':
      return _$withdrawal;
    case 'balance':
      return _$balance;
    case 'activity':
      return _$activity;
    case 'session':
      return _$session;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<RealtimeResourceType> _$values =
    BuiltSet<RealtimeResourceType>(const <RealtimeResourceType>[
  _$order,
  _$position,
  _$transfer,
  _$claim,
  _$deposit,
  _$withdrawal,
  _$balance,
  _$activity,
  _$session,
]);

class _$RealtimeResourceTypeMeta {
  const _$RealtimeResourceTypeMeta();
  RealtimeResourceType get order => _$order;
  RealtimeResourceType get position => _$position;
  RealtimeResourceType get transfer => _$transfer;
  RealtimeResourceType get claim => _$claim;
  RealtimeResourceType get deposit => _$deposit;
  RealtimeResourceType get withdrawal => _$withdrawal;
  RealtimeResourceType get balance => _$balance;
  RealtimeResourceType get activity => _$activity;
  RealtimeResourceType get session => _$session;
  RealtimeResourceType valueOf(String name) => _$valueOf(name);
  BuiltSet<RealtimeResourceType> get values => _$values;
}

abstract class _$RealtimeResourceTypeMixin {
  // ignore: non_constant_identifier_names
  _$RealtimeResourceTypeMeta get RealtimeResourceType =>
      const _$RealtimeResourceTypeMeta();
}

Serializer<RealtimeResourceType> _$realtimeResourceTypeSerializer =
    _$RealtimeResourceTypeSerializer();

class _$RealtimeResourceTypeSerializer
    implements PrimitiveSerializer<RealtimeResourceType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'order': 'order',
    'position': 'position',
    'transfer': 'transfer',
    'claim': 'claim',
    'deposit': 'deposit',
    'withdrawal': 'withdrawal',
    'balance': 'balance',
    'activity': 'activity',
    'session': 'session',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'order': 'order',
    'position': 'position',
    'transfer': 'transfer',
    'claim': 'claim',
    'deposit': 'deposit',
    'withdrawal': 'withdrawal',
    'balance': 'balance',
    'activity': 'activity',
    'session': 'session',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeResourceType];
  @override
  final String wireName = 'RealtimeResourceType';

  @override
  Object serialize(Serializers serializers, RealtimeResourceType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeResourceType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeResourceType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
