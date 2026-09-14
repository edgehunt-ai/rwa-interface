// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chart_range.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ChartRange _$n15m = const ChartRange._('n15m');
const ChartRange _$n1h = const ChartRange._('n1h');
const ChartRange _$n4h = const ChartRange._('n4h');
const ChartRange _$n24h = const ChartRange._('n24h');
const ChartRange _$n1w = const ChartRange._('n1w');
const ChartRange _$unknownDefaultOpenApi =
    const ChartRange._('unknownDefaultOpenApi');

ChartRange _$valueOf(String name) {
  switch (name) {
    case 'n15m':
      return _$n15m;
    case 'n1h':
      return _$n1h;
    case 'n4h':
      return _$n4h;
    case 'n24h':
      return _$n24h;
    case 'n1w':
      return _$n1w;
    case 'unknownDefaultOpenApi':
      return _$unknownDefaultOpenApi;
    default:
      return _$unknownDefaultOpenApi;
  }
}

final BuiltSet<ChartRange> _$values = BuiltSet<ChartRange>(const <ChartRange>[
  _$n15m,
  _$n1h,
  _$n4h,
  _$n24h,
  _$n1w,
  _$unknownDefaultOpenApi,
]);

class _$ChartRangeMeta {
  const _$ChartRangeMeta();
  ChartRange get n15m => _$n15m;
  ChartRange get n1h => _$n1h;
  ChartRange get n4h => _$n4h;
  ChartRange get n24h => _$n24h;
  ChartRange get n1w => _$n1w;
  ChartRange get unknownDefaultOpenApi => _$unknownDefaultOpenApi;
  ChartRange valueOf(String name) => _$valueOf(name);
  BuiltSet<ChartRange> get values => _$values;
}

abstract class _$ChartRangeMixin {
  // ignore: non_constant_identifier_names
  _$ChartRangeMeta get ChartRange => const _$ChartRangeMeta();
}

Serializer<ChartRange> _$chartRangeSerializer = _$ChartRangeSerializer();

class _$ChartRangeSerializer implements PrimitiveSerializer<ChartRange> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'n15m': '15m',
    'n1h': '1h',
    'n4h': '4h',
    'n24h': '24h',
    'n1w': '1w',
    'unknownDefaultOpenApi': 'unknown_default_open_api',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    '15m': 'n15m',
    '1h': 'n1h',
    '4h': 'n4h',
    '24h': 'n24h',
    '1w': 'n1w',
    'unknown_default_open_api': 'unknownDefaultOpenApi',
  };

  @override
  final Iterable<Type> types = const <Type>[ChartRange];
  @override
  final String wireName = 'ChartRange';

  @override
  Object serialize(Serializers serializers, ChartRange object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ChartRange deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ChartRange.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
