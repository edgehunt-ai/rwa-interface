//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_category.g.dart';

class ActivityCategory extends EnumClass {

  @BuiltValueEnumConst(wireName: r'orders')
  static const ActivityCategory orders = _$orders;
  @BuiltValueEnumConst(wireName: r'funds')
  static const ActivityCategory funds = _$funds;
  @BuiltValueEnumConst(wireName: r'signatures')
  static const ActivityCategory signatures = _$signatures;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ActivityCategory unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<ActivityCategory> get serializer => _$activityCategorySerializer;

  const ActivityCategory._(String name): super(name);

  static BuiltSet<ActivityCategory> get values => _$values;
  static ActivityCategory valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ActivityCategoryMixin = Object with _$ActivityCategoryMixin;

