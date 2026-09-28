// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'margin_mode.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MarginMode _$isolated = const MarginMode._('isolated');
const MarginMode _$cross = const MarginMode._('cross');

MarginMode _$valueOf(String name) {
  switch (name) {
    case 'isolated':
      return _$isolated;
    case 'cross':
      return _$cross;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MarginMode> _$values = BuiltSet<MarginMode>(const <MarginMode>[
  _$isolated,
  _$cross,
]);

class _$MarginModeMeta {
  const _$MarginModeMeta();
  MarginMode get isolated => _$isolated;
  MarginMode get cross => _$cross;
  MarginMode valueOf(String name) => _$valueOf(name);
  BuiltSet<MarginMode> get values => _$values;
}

abstract class _$MarginModeMixin {
  // ignore: non_constant_identifier_names
  _$MarginModeMeta get MarginMode => const _$MarginModeMeta();
}

Serializer<MarginMode> _$marginModeSerializer = _$MarginModeSerializer();

class _$MarginModeSerializer implements PrimitiveSerializer<MarginMode> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'isolated': 'isolated',
    'cross': 'cross',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'isolated': 'isolated',
    'cross': 'cross',
  };

  @override
  final Iterable<Type> types = const <Type>[MarginMode];
  @override
  final String wireName = 'MarginMode';

  @override
  Object serialize(Serializers serializers, MarginMode object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MarginMode deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MarginMode.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
