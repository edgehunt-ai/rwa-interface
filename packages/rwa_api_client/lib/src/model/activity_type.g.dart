// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ActivityType _$market = const ActivityType._('market');
const ActivityType _$limit = const ActivityType._('limit');
const ActivityType _$tpsl = const ActivityType._('tpsl');
const ActivityType _$close = const ActivityType._('close');
const ActivityType _$liquidation = const ActivityType._('liquidation');
const ActivityType _$deposit = const ActivityType._('deposit');
const ActivityType _$external_ = const ActivityType._('external_');
const ActivityType _$bridge = const ActivityType._('bridge');
const ActivityType _$withdraw = const ActivityType._('withdraw');
const ActivityType _$claim = const ActivityType._('claim');
const ActivityType _$funding = const ActivityType._('funding');
const ActivityType _$approval = const ActivityType._('approval');
const ActivityType _$orderSign = const ActivityType._('orderSign');
const ActivityType _$bridgeSign = const ActivityType._('bridgeSign');
const ActivityType _$unknownDefaultOpenApi =
    const ActivityType._('unknownDefaultOpenApi');

ActivityType _$valueOf(String name) {
  switch (name) {
    case 'market':
      return _$market;
    case 'limit':
      return _$limit;
    case 'tpsl':
      return _$tpsl;
    case 'close':
      return _$close;
    case 'liquidation':
      return _$liquidation;
    case 'deposit':
      return _$deposit;
    case 'external_':
      return _$external_;
    case 'bridge':
      return _$bridge;
    case 'withdraw':
      return _$withdraw;
    case 'claim':
      return _$claim;
    case 'funding':
      return _$funding;
    case 'approval':
      return _$approval;
    case 'orderSign':
      return _$orderSign;
    case 'bridgeSign':
      return _$bridgeSign;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<ActivityType> _$values =
    BuiltSet<ActivityType>(const <ActivityType>[
  _$market,
  _$limit,
  _$tpsl,
  _$close,
  _$liquidation,
  _$deposit,
  _$external_,
  _$bridge,
  _$withdraw,
  _$claim,
  _$funding,
  _$approval,
  _$orderSign,
  _$bridgeSign,
  _$unknownDefaultOpenApi,
]);

class _$ActivityTypeMeta {
  const _$ActivityTypeMeta();
  ActivityType get market => _$market;
  ActivityType get limit => _$limit;
  ActivityType get tpsl => _$tpsl;
  ActivityType get close => _$close;
  ActivityType get liquidation => _$liquidation;
  ActivityType get deposit => _$deposit;
  ActivityType get external_ => _$external_;
  ActivityType get bridge => _$bridge;
  ActivityType get withdraw => _$withdraw;
  ActivityType get claim => _$claim;
  ActivityType get funding => _$funding;
  ActivityType get approval => _$approval;
  ActivityType get orderSign => _$orderSign;
  ActivityType get bridgeSign => _$bridgeSign;
  ActivityType get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  ActivityType valueOf(String name) => _$valueOf(name);
  BuiltSet<ActivityType> get values => _$values;
}

abstract class _$ActivityTypeMixin {
  // ignore: non_constant_identifier_names
  _$ActivityTypeMeta get ActivityType => const _$ActivityTypeMeta();
}

Serializer<ActivityType> _$activityTypeSerializer = _$ActivityTypeSerializer();

class _$ActivityTypeSerializer implements PrimitiveSerializer<ActivityType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'market': 'market',
    'limit': 'limit',
    'tpsl': 'tpsl',
    'close': 'close',
    'liquidation': 'liquidation',
    'deposit': 'deposit',
    'external_': 'external',
    'bridge': 'bridge',
    'withdraw': 'withdraw',
    'claim': 'claim',
    'funding': 'funding',
    'approval': 'approval',
    'orderSign': 'orderSign',
    'bridgeSign': 'bridgeSign',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'market': 'market',
    'limit': 'limit',
    'tpsl': 'tpsl',
    'close': 'close',
    'liquidation': 'liquidation',
    'deposit': 'deposit',
    'external': 'external_',
    'bridge': 'bridge',
    'withdraw': 'withdraw',
    'claim': 'claim',
    'funding': 'funding',
    'approval': 'approval',
    'orderSign': 'orderSign',
    'bridgeSign': 'bridgeSign',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ActivityType];
  @override
  final String wireName = 'ActivityType';

  @override
  Object serialize(Serializers serializers, ActivityType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ActivityType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ActivityType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
