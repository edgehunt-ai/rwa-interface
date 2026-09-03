// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ActivityCategory _$orders = const ActivityCategory._('orders');
const ActivityCategory _$funds = const ActivityCategory._('funds');
const ActivityCategory _$signatures = const ActivityCategory._('signatures');
const ActivityCategory _$unknownDefaultOpenApi =
    const ActivityCategory._('unknownDefaultOpenApi');

ActivityCategory _$valueOf(String name) {
  switch (name) {
    case 'orders':
      return _$orders;
    case 'funds':
      return _$funds;
    case 'signatures':
      return _$signatures;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<ActivityCategory> _$values =
    BuiltSet<ActivityCategory>(const <ActivityCategory>[
  _$orders,
  _$funds,
  _$signatures,
  _$unknownDefaultOpenApi,
]);

class _$ActivityCategoryMeta {
  const _$ActivityCategoryMeta();
  ActivityCategory get orders => _$orders;
  ActivityCategory get funds => _$funds;
  ActivityCategory get signatures => _$signatures;
  ActivityCategory get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  ActivityCategory valueOf(String name) => _$valueOf(name);
  BuiltSet<ActivityCategory> get values => _$values;
}

abstract class _$ActivityCategoryMixin {
  // ignore: non_constant_identifier_names
  _$ActivityCategoryMeta get ActivityCategory => const _$ActivityCategoryMeta();
}

Serializer<ActivityCategory> _$activityCategorySerializer =
    _$ActivityCategorySerializer();

class _$ActivityCategorySerializer
    implements PrimitiveSerializer<ActivityCategory> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'orders': 'orders',
    'funds': 'funds',
    'signatures': 'signatures',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'orders': 'orders',
    'funds': 'funds',
    'signatures': 'signatures',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ActivityCategory];
  @override
  final String wireName = 'ActivityCategory';

  @override
  Object serialize(Serializers serializers, ActivityCategory object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ActivityCategory deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ActivityCategory.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
