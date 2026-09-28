// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bstocks_depth_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BstocksDepthStatus _$complete = const BstocksDepthStatus._('complete');
const BstocksDepthStatus _$partial = const BstocksDepthStatus._('partial');
const BstocksDepthStatus _$unavailable =
    const BstocksDepthStatus._('unavailable');

BstocksDepthStatus _$valueOf(String name) {
  switch (name) {
    case 'complete':
      return _$complete;
    case 'partial':
      return _$partial;
    case 'unavailable':
      return _$unavailable;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BstocksDepthStatus> _$values =
    BuiltSet<BstocksDepthStatus>(const <BstocksDepthStatus>[
  _$complete,
  _$partial,
  _$unavailable,
]);

class _$BstocksDepthStatusMeta {
  const _$BstocksDepthStatusMeta();
  BstocksDepthStatus get complete => _$complete;
  BstocksDepthStatus get partial => _$partial;
  BstocksDepthStatus get unavailable => _$unavailable;
  BstocksDepthStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<BstocksDepthStatus> get values => _$values;
}

abstract class _$BstocksDepthStatusMixin {
  // ignore: non_constant_identifier_names
  _$BstocksDepthStatusMeta get BstocksDepthStatus =>
      const _$BstocksDepthStatusMeta();
}

Serializer<BstocksDepthStatus> _$bstocksDepthStatusSerializer =
    _$BstocksDepthStatusSerializer();

class _$BstocksDepthStatusSerializer
    implements PrimitiveSerializer<BstocksDepthStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'complete': 'complete',
    'partial': 'partial',
    'unavailable': 'unavailable',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'complete': 'complete',
    'partial': 'partial',
    'unavailable': 'unavailable',
  };

  @override
  final Iterable<Type> types = const <Type>[BstocksDepthStatus];
  @override
  final String wireName = 'BstocksDepthStatus';

  @override
  Object serialize(Serializers serializers, BstocksDepthStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BstocksDepthStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BstocksDepthStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
