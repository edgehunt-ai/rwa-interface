// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_private_channel.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimePrivateChannel _$orders =
    const RealtimePrivateChannel._('orders');
const RealtimePrivateChannel _$positions =
    const RealtimePrivateChannel._('positions');
const RealtimePrivateChannel _$transfers =
    const RealtimePrivateChannel._('transfers');
const RealtimePrivateChannel _$claims =
    const RealtimePrivateChannel._('claims');
const RealtimePrivateChannel _$deposits =
    const RealtimePrivateChannel._('deposits');
const RealtimePrivateChannel _$withdrawals =
    const RealtimePrivateChannel._('withdrawals');
const RealtimePrivateChannel _$balances =
    const RealtimePrivateChannel._('balances');
const RealtimePrivateChannel _$activity =
    const RealtimePrivateChannel._('activity');
const RealtimePrivateChannel _$unknownDefaultOpenApi =
    const RealtimePrivateChannel._('unknownDefaultOpenApi');

RealtimePrivateChannel _$valueOf(String name) {
  switch (name) {
    case 'orders':
      return _$orders;
    case 'positions':
      return _$positions;
    case 'transfers':
      return _$transfers;
    case 'claims':
      return _$claims;
    case 'deposits':
      return _$deposits;
    case 'withdrawals':
      return _$withdrawals;
    case 'balances':
      return _$balances;
    case 'activity':
      return _$activity;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimePrivateChannel> _$values =
    BuiltSet<RealtimePrivateChannel>(const <RealtimePrivateChannel>[
  _$orders,
  _$positions,
  _$transfers,
  _$claims,
  _$deposits,
  _$withdrawals,
  _$balances,
  _$activity,
  _$unknownDefaultOpenApi,
]);

class _$RealtimePrivateChannelMeta {
  const _$RealtimePrivateChannelMeta();
  RealtimePrivateChannel get orders => _$orders;
  RealtimePrivateChannel get positions => _$positions;
  RealtimePrivateChannel get transfers => _$transfers;
  RealtimePrivateChannel get claims => _$claims;
  RealtimePrivateChannel get deposits => _$deposits;
  RealtimePrivateChannel get withdrawals => _$withdrawals;
  RealtimePrivateChannel get balances => _$balances;
  RealtimePrivateChannel get activity => _$activity;
  RealtimePrivateChannel get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  RealtimePrivateChannel valueOf(String name) => _$valueOf(name);
  BuiltSet<RealtimePrivateChannel> get values => _$values;
}

abstract class _$RealtimePrivateChannelMixin {
  // ignore: non_constant_identifier_names
  _$RealtimePrivateChannelMeta get RealtimePrivateChannel =>
      const _$RealtimePrivateChannelMeta();
}

Serializer<RealtimePrivateChannel> _$realtimePrivateChannelSerializer =
    _$RealtimePrivateChannelSerializer();

class _$RealtimePrivateChannelSerializer
    implements PrimitiveSerializer<RealtimePrivateChannel> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'orders': 'orders',
    'positions': 'positions',
    'transfers': 'transfers',
    'claims': 'claims',
    'deposits': 'deposits',
    'withdrawals': 'withdrawals',
    'balances': 'balances',
    'activity': 'activity',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'orders': 'orders',
    'positions': 'positions',
    'transfers': 'transfers',
    'claims': 'claims',
    'deposits': 'deposits',
    'withdrawals': 'withdrawals',
    'balances': 'balances',
    'activity': 'activity',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimePrivateChannel];
  @override
  final String wireName = 'RealtimePrivateChannel';

  @override
  Object serialize(Serializers serializers, RealtimePrivateChannel object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimePrivateChannel deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimePrivateChannel.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
