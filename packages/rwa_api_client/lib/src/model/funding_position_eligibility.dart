//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_position_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/eligible_funding_position_eligibility.dart';
import 'package:rwa_api_client/src/model/ineligible_funding_position_eligibility.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_position_eligibility.g.dart';

/// Structural eligible/ineligible union for one exact source position. Each child requires a singleton `status`; keeping it in the child makes generated clients retain the status value. 
///
/// Properties:
/// * [status] 
/// * [blockers] 
@BuiltValue()
abstract class FundingPositionEligibility implements Built<FundingPositionEligibility, FundingPositionEligibilityBuilder> {
  /// One Of [EligibleFundingPositionEligibility], [IneligibleFundingPositionEligibility]
  OneOf get oneOf;

  FundingPositionEligibility._();

  factory FundingPositionEligibility([void updates(FundingPositionEligibilityBuilder b)]) = _$FundingPositionEligibility;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingPositionEligibilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingPositionEligibility> get serializer => _$FundingPositionEligibilitySerializer();
}

class _$FundingPositionEligibilitySerializer implements PrimitiveSerializer<FundingPositionEligibility> {
  @override
  final Iterable<Type> types = const [FundingPositionEligibility, _$FundingPositionEligibility];

  @override
  final String wireName = r'FundingPositionEligibility';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingPositionEligibility object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingPositionEligibility object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingPositionEligibility deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingPositionEligibilityBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(EligibleFundingPositionEligibility), FullType(IneligibleFundingPositionEligibility), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class FundingPositionEligibilityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ineligible')
  static const FundingPositionEligibilityStatusEnum ineligible = _$fundingPositionEligibilityStatusEnum_ineligible;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPositionEligibilityStatusEnum unknownDefaultOpenApi = _$fundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;

  static Serializer<FundingPositionEligibilityStatusEnum> get serializer => _$fundingPositionEligibilityStatusEnumSerializer;

  const FundingPositionEligibilityStatusEnum._(String name): super(name);

  static BuiltSet<FundingPositionEligibilityStatusEnum> get values => _$fundingPositionEligibilityStatusEnumValues;
  static FundingPositionEligibilityStatusEnum valueOf(String name) => _$fundingPositionEligibilityStatusEnumValueOf(name);
}

