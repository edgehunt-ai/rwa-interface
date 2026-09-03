// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_kind.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SessionKind _$premarket = const SessionKind._('premarket');
const SessionKind _$regular = const SessionKind._('regular');
const SessionKind _$after = const SessionKind._('after');
const SessionKind _$overnight = const SessionKind._('overnight');
const SessionKind _$weekend = const SessionKind._('weekend');
const SessionKind _$holiday = const SessionKind._('holiday');
const SessionKind _$unknownDefaultOpenApi =
    const SessionKind._('unknownDefaultOpenApi');

SessionKind _$valueOf(String name) {
  switch (name) {
    case 'premarket':
      return _$premarket;
    case 'regular':
      return _$regular;
    case 'after':
      return _$after;
    case 'overnight':
      return _$overnight;
    case 'weekend':
      return _$weekend;
    case 'holiday':
      return _$holiday;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<SessionKind> _$values =
    BuiltSet<SessionKind>(const <SessionKind>[
  _$premarket,
  _$regular,
  _$after,
  _$overnight,
  _$weekend,
  _$holiday,
  _$unknownDefaultOpenApi,
]);

class _$SessionKindMeta {
  const _$SessionKindMeta();
  SessionKind get premarket => _$premarket;
  SessionKind get regular => _$regular;
  SessionKind get after => _$after;
  SessionKind get overnight => _$overnight;
  SessionKind get weekend => _$weekend;
  SessionKind get holiday => _$holiday;
  SessionKind get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  SessionKind valueOf(String name) => _$valueOf(name);
  BuiltSet<SessionKind> get values => _$values;
}

abstract class _$SessionKindMixin {
  // ignore: non_constant_identifier_names
  _$SessionKindMeta get SessionKind => const _$SessionKindMeta();
}

Serializer<SessionKind> _$sessionKindSerializer = _$SessionKindSerializer();

class _$SessionKindSerializer implements PrimitiveSerializer<SessionKind> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'premarket': 'premarket',
    'regular': 'regular',
    'after': 'after',
    'overnight': 'overnight',
    'weekend': 'weekend',
    'holiday': 'holiday',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'premarket': 'premarket',
    'regular': 'regular',
    'after': 'after',
    'overnight': 'overnight',
    'weekend': 'weekend',
    'holiday': 'holiday',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[SessionKind];
  @override
  final String wireName = 'SessionKind';

  @override
  Object serialize(Serializers serializers, SessionKind object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SessionKind deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SessionKind.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
