//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_resource_change.g.dart';

class RealtimeResourceChange extends EnumClass {

  @BuiltValueEnumConst(wireName: r'created')
  static const RealtimeResourceChange created = _$created;
  @BuiltValueEnumConst(wireName: r'updated')
  static const RealtimeResourceChange updated = _$updated;
  @BuiltValueEnumConst(wireName: r'removed')
  static const RealtimeResourceChange removed = _$removed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeResourceChange unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<RealtimeResourceChange> get serializer => _$realtimeResourceChangeSerializer;

  const RealtimeResourceChange._(String name): super(name);

  static BuiltSet<RealtimeResourceChange> get values => _$values;
  static RealtimeResourceChange valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class RealtimeResourceChangeMixin = Object with _$RealtimeResourceChangeMixin;

