//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'multi_source_funding_plan_status.g.dart';

class MultiSourceFundingPlanStatus extends EnumClass {

  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'ready')
  static const MultiSourceFundingPlanStatus ready = _$ready;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'executing')
  static const MultiSourceFundingPlanStatus executing = _$executing;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'partially_funded')
  static const MultiSourceFundingPlanStatus partiallyFunded = _$partiallyFunded;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'funded')
  static const MultiSourceFundingPlanStatus funded = _$funded;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'blocked')
  static const MultiSourceFundingPlanStatus blocked = _$blocked;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'failed')
  static const MultiSourceFundingPlanStatus failed = _$failed;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'expired')
  static const MultiSourceFundingPlanStatus expired = _$expired;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const MultiSourceFundingPlanStatus cancelled = _$cancelled;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const MultiSourceFundingPlanStatus manualReview = _$manualReview;
  /// Aggregate execution status for a server-allocated multi-source funding plan.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MultiSourceFundingPlanStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<MultiSourceFundingPlanStatus> get serializer => _$multiSourceFundingPlanStatusSerializer;

  const MultiSourceFundingPlanStatus._(String name): super(name);

  static BuiltSet<MultiSourceFundingPlanStatus> get values => _$values;
  static MultiSourceFundingPlanStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class MultiSourceFundingPlanStatusMixin = Object with _$MultiSourceFundingPlanStatusMixin;

