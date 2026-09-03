// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ActivityStatus _$pending = const ActivityStatus._('pending');
const ActivityStatus _$success = const ActivityStatus._('success');
const ActivityStatus _$failed = const ActivityStatus._('failed');
const ActivityStatus _$cancelled = const ActivityStatus._('cancelled');
const ActivityStatus _$unknownDefaultOpenApi =
    const ActivityStatus._('unknownDefaultOpenApi');

ActivityStatus _$valueOf(String name) {
  switch (name) {
    case 'pending':
      return _$pending;
    case 'success':
      return _$success;
    case 'failed':
      return _$failed;
    case 'cancelled':
      return _$cancelled;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<ActivityStatus> _$values =
    BuiltSet<ActivityStatus>(const <ActivityStatus>[
  _$pending,
  _$success,
  _$failed,
  _$cancelled,
  _$unknownDefaultOpenApi,
]);

class _$ActivityStatusMeta {
  const _$ActivityStatusMeta();
  ActivityStatus get pending => _$pending;
  ActivityStatus get success => _$success;
  ActivityStatus get failed => _$failed;
  ActivityStatus get cancelled => _$cancelled;
  ActivityStatus get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  ActivityStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<ActivityStatus> get values => _$values;
}

abstract class _$ActivityStatusMixin {
  // ignore: non_constant_identifier_names
  _$ActivityStatusMeta get ActivityStatus => const _$ActivityStatusMeta();
}

Serializer<ActivityStatus> _$activityStatusSerializer =
    _$ActivityStatusSerializer();

class _$ActivityStatusSerializer
    implements PrimitiveSerializer<ActivityStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pending': 'pending',
    'success': 'success',
    'failed': 'failed',
    'cancelled': 'cancelled',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'pending': 'pending',
    'success': 'success',
    'failed': 'failed',
    'cancelled': 'cancelled',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ActivityStatus];
  @override
  final String wireName = 'ActivityStatus';

  @override
  Object serialize(Serializers serializers, ActivityStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ActivityStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ActivityStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
