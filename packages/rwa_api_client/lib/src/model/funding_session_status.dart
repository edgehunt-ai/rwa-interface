//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_session_status.g.dart';

class FundingSessionStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'editing')
  static const FundingSessionStatus editing = _$editing;
  @BuiltValueEnumConst(wireName: r'ready_to_confirm')
  static const FundingSessionStatus readyToConfirm = _$readyToConfirm;
  @BuiltValueEnumConst(wireName: r'transferring')
  static const FundingSessionStatus transferring = _$transferring;
  @BuiltValueEnumConst(wireName: r'funded')
  static const FundingSessionStatus funded = _$funded;
  @BuiltValueEnumConst(wireName: r'expired')
  static const FundingSessionStatus expired = _$expired;
  @BuiltValueEnumConst(wireName: r'cancelled')
  static const FundingSessionStatus cancelled = _$cancelled;
  @BuiltValueEnumConst(wireName: r'manual_review')
  static const FundingSessionStatus manualReview = _$manualReview;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingSessionStatus unknownDefaultOpenApi = _$unknownDefaultOpenApi;

  static Serializer<FundingSessionStatus> get serializer => _$fundingSessionStatusSerializer;

  const FundingSessionStatus._(String name): super(name);

  static BuiltSet<FundingSessionStatus> get values => _$values;
  static FundingSessionStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FundingSessionStatusMixin = Object with _$FundingSessionStatusMixin;

