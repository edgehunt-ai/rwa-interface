//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'multi_source_funding_leg_status.g.dart';

class MultiSourceFundingLegStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'planned')
  static const MultiSourceFundingLegStatus planned = _$planned;
  @BuiltValueEnumConst(wireName: r'action_released')
  static const MultiSourceFundingLegStatus actionReleased = _$actionReleased;
  @BuiltValueEnumConst(wireName: r'submitted')
  static const MultiSourceFundingLegStatus submitted = _$submitted;
  @BuiltValueEnumConst(wireName: r'origin_confirmed')
  static const MultiSourceFundingLegStatus originConfirmed = _$originConfirmed;
  @BuiltValueEnumConst(wireName: r'provider_confirmed')
  static const MultiSourceFundingLegStatus providerConfirmed = _$providerConfirmed;
  @BuiltValueEnumConst(wireName: r'target_confirmed')
  static const MultiSourceFundingLegStatus targetConfirmed = _$targetConfirmed;
  @BuiltValueEnumConst(wireName: r'completed')
  static const MultiSourceFundingLegStatus completed = _$completed;
  @BuiltValueEnumConst(wireName: r'cancelled_as_unneeded')
  static const MultiSourceFundingLegStatus cancelledAsUnneeded = _$cancelledAsUnneeded;
  @BuiltValueEnumConst(wireName: r'failed')
  static const MultiSourceFundingLegStatus failed = _$failed;
  @BuiltValueEnumConst(wireName: r'ambiguous')
  static const MultiSourceFundingLegStatus ambiguous = _$ambiguous;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const MultiSourceFundingLegStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const MultiSourceFundingLegStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<MultiSourceFundingLegStatus> get serializer => _$multiSourceFundingLegStatusSerializer;

  const MultiSourceFundingLegStatus._(String name): super(name);

  static BuiltSet<MultiSourceFundingLegStatus> get values => _$values;
  static MultiSourceFundingLegStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class MultiSourceFundingLegStatusMixin = Object with _$MultiSourceFundingLegStatusMixin;

