//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'activity_status.g.dart';

class ActivityStatus extends EnumClass {

  /// `pending` 进行中 · `success` 已完成 · `failed` 失败 · `cancelled` 已取消
  @BuiltValueEnumConst(wireName: r'pending')
  static const ActivityStatus pending = _$pending;
  /// `pending` 进行中 · `success` 已完成 · `failed` 失败 · `cancelled` 已取消
  @BuiltValueEnumConst(wireName: r'success')
  static const ActivityStatus success = _$success;
  /// `pending` 进行中 · `success` 已完成 · `failed` 失败 · `cancelled` 已取消
  @BuiltValueEnumConst(wireName: r'failed')
  static const ActivityStatus failed = _$failed;
  /// `pending` 进行中 · `success` 已完成 · `failed` 失败 · `cancelled` 已取消
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const ActivityStatus cancelled = _$cancelled;
  /// `pending` 进行中 · `success` 已完成 · `failed` 失败 · `cancelled` 已取消
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const ActivityStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<ActivityStatus> get serializer => _$activityStatusSerializer;

  const ActivityStatus._(String name): super(name);

  static BuiltSet<ActivityStatus> get values => _$values;
  static ActivityStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ActivityStatusMixin = Object with _$ActivityStatusMixin;

