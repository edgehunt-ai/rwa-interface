//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'realtime_resource_type.g.dart';

class RealtimeResourceType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'order')
  static const RealtimeResourceType order = _$order;
  @BuiltValueEnumConst(wireName: r'position')
  static const RealtimeResourceType position = _$position;
  @BuiltValueEnumConst(wireName: r'transfer')
  static const RealtimeResourceType transfer = _$transfer;
  @BuiltValueEnumConst(wireName: r'claim')
  static const RealtimeResourceType claim = _$claim;
  @BuiltValueEnumConst(wireName: r'deposit')
  static const RealtimeResourceType deposit = _$deposit;
  @BuiltValueEnumConst(wireName: r'withdrawal')
  static const RealtimeResourceType withdrawal = _$withdrawal;
  @BuiltValueEnumConst(wireName: r'balance')
  static const RealtimeResourceType balance = _$balance;
  @BuiltValueEnumConst(wireName: r'activity')
  static const RealtimeResourceType activity = _$activity;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RealtimeResourceType unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<RealtimeResourceType> get serializer => _$realtimeResourceTypeSerializer;

  const RealtimeResourceType._(String name): super(name);

  static BuiltSet<RealtimeResourceType> get values => _$values;
  static RealtimeResourceType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class RealtimeResourceTypeMixin = Object with _$RealtimeResourceTypeMixin;

