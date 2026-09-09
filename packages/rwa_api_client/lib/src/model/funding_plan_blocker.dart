//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_plan_blocker.g.dart';

class FundingPlanBlocker extends EnumClass {
  @BuiltValueEnumConst(wireName: r'target_balance_unavailable')
  static const FundingPlanBlocker targetBalanceUnavailable =
      _$targetBalanceUnavailable;
  @BuiltValueEnumConst(wireName: r'target_balance_stale')
  static const FundingPlanBlocker targetBalanceStale = _$targetBalanceStale;
  @BuiltValueEnumConst(wireName: r'source_balance_unavailable')
  static const FundingPlanBlocker sourceBalanceUnavailable =
      _$sourceBalanceUnavailable;
  @BuiltValueEnumConst(wireName: r'source_balance_stale')
  static const FundingPlanBlocker sourceBalanceStale = _$sourceBalanceStale;
  @BuiltValueEnumConst(wireName: r'source_balance_invalid')
  static const FundingPlanBlocker sourceBalanceInvalid = _$sourceBalanceInvalid;
  @BuiltValueEnumConst(wireName: r'single_source_insufficient')
  static const FundingPlanBlocker singleSourceInsufficient =
      _$singleSourceInsufficient;
  @BuiltValueEnumConst(wireName: r'no_safe_route')
  static const FundingPlanBlocker noSafeRoute = _$noSafeRoute;
  @BuiltValueEnumConst(wireName: r'provider_unavailable')
  static const FundingPlanBlocker providerUnavailable = _$providerUnavailable;
  @BuiltValueEnumConst(wireName: r'quote_expired')
  static const FundingPlanBlocker quoteExpired = _$quoteExpired;
  @BuiltValueEnumConst(wireName: r'route_disabled')
  static const FundingPlanBlocker routeDisabled = _$routeDisabled;
  @BuiltValueEnumConst(wireName: r'manual_review_required')
  static const FundingPlanBlocker manualReviewRequired = _$manualReviewRequired;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanBlocker unknownDefaultOpenApi =
      _$unknownDefaultOpenApi;

  static Serializer<FundingPlanBlocker> get serializer =>
      _$fundingPlanBlockerSerializer;

  const FundingPlanBlocker._(String name) : super(name);

  static BuiltSet<FundingPlanBlocker> get values => _$values;
  static FundingPlanBlocker valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FundingPlanBlockerMixin = Object with _$FundingPlanBlockerMixin;
