//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'margin_mode.g.dart';

class MarginMode extends EnumClass {
  @BuiltValueEnumConst(wireName: r'isolated')
  static const MarginMode isolated = _$isolated;
  @BuiltValueEnumConst(wireName: r'cross')
  static const MarginMode cross = _$cross;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MarginMode unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<MarginMode> get serializer => _$marginModeSerializer;

  const MarginMode._(String name) : super(name);

  static BuiltSet<MarginMode> get values => _$values;
  static MarginMode valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class MarginModeMixin = Object with _$MarginModeMixin;
