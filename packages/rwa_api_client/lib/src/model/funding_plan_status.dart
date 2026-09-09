//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_plan_status.g.dart';

class FundingPlanStatus extends EnumClass {
  @BuiltValueEnumConst(wireName: r'ready')
  static const FundingPlanStatus ready = _$ready;
  @BuiltValueEnumConst(wireName: r'already_funded')
  static const FundingPlanStatus alreadyFunded = _$alreadyFunded;
  @BuiltValueEnumConst(wireName: r'blocked')
  static const FundingPlanStatus blocked = _$blocked;
  @BuiltValueEnumConst(wireName: r'expired')
  static const FundingPlanStatus expired = _$expired;
  @BuiltValueEnumConst(wireName: r'consumed')
  static const FundingPlanStatus consumed = _$consumed;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const FundingPlanStatus cancelled = _$cancelled;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanStatus unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<FundingPlanStatus> get serializer =>
      _$fundingPlanStatusSerializer;

  const FundingPlanStatus._(String name) : super(name);

  static BuiltSet<FundingPlanStatus> get values => _$values;
  static FundingPlanStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FundingPlanStatusMixin = Object with _$FundingPlanStatusMixin;
