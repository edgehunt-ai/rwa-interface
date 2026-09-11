// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'realtime_resource_change.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RealtimeResourceChange _$created =
    const RealtimeResourceChange._('created');
const RealtimeResourceChange _$updated =
    const RealtimeResourceChange._('updated');
const RealtimeResourceChange _$removed =
    const RealtimeResourceChange._('removed');
const RealtimeResourceChange _$unknownDefaultOpenApi =
    const RealtimeResourceChange._('unknownDefaultOpenApi');

RealtimeResourceChange _$valueOf(String name) {
  switch (name) {
    case 'created':
      return _$created;
    case 'updated':
      return _$updated;
    case 'removed':
      return _$removed;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<RealtimeResourceChange> _$values =
    BuiltSet<RealtimeResourceChange>(const <RealtimeResourceChange>[
  _$created,
  _$updated,
  _$removed,
  _$unknownDefaultOpenApi,
]);

class _$RealtimeResourceChangeMeta {
  const _$RealtimeResourceChangeMeta();
  RealtimeResourceChange get created => _$created;
  RealtimeResourceChange get updated => _$updated;
  RealtimeResourceChange get removed => _$removed;
  RealtimeResourceChange get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  RealtimeResourceChange valueOf(String name) => _$valueOf(name);
  BuiltSet<RealtimeResourceChange> get values => _$values;
}

abstract class _$RealtimeResourceChangeMixin {
  // ignore: non_constant_identifier_names
  _$RealtimeResourceChangeMeta get RealtimeResourceChange =>
      const _$RealtimeResourceChangeMeta();
}

Serializer<RealtimeResourceChange> _$realtimeResourceChangeSerializer =
    _$RealtimeResourceChangeSerializer();

class _$RealtimeResourceChangeSerializer
    implements PrimitiveSerializer<RealtimeResourceChange> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'created': 'created',
    'updated': 'updated',
    'removed': 'removed',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'created': 'created',
    'updated': 'updated',
    'removed': 'removed',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[RealtimeResourceChange];
  @override
  final String wireName = 'RealtimeResourceChange';

  @override
  Object serialize(Serializers serializers, RealtimeResourceChange object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RealtimeResourceChange deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RealtimeResourceChange.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
