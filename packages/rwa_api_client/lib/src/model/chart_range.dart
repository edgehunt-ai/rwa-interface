//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chart_range.g.dart';

class ChartRange extends EnumClass {

  @BuiltValueEnumConst(wireName: r'15m')
  static const ChartRange n15m = _$n15m;
  @BuiltValueEnumConst(wireName: r'4h')
  static const ChartRange n4h = _$n4h;
  @BuiltValueEnumConst(wireName: r'24h')
  static const ChartRange n24h = _$n24h;
  @BuiltValueEnumConst(wireName: r'1w')
  static const ChartRange n1w = _$n1w;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ChartRange unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<ChartRange> get serializer => _$chartRangeSerializer;

  const ChartRange._(String name): super(name);

  static BuiltSet<ChartRange> get values => _$values;
  static ChartRange valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ChartRangeMixin = Object with _$ChartRangeMixin;

