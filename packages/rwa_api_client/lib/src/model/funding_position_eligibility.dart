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

  static const String discriminatorFieldName = r'status';

  static const Map<String, Type> discriminatorMapping = {
    r'eligible': EligibleFundingPositionEligibility,
    r'ineligible': IneligibleFundingPositionEligibility,
  };

  FundingPositionEligibility._();

  factory FundingPositionEligibility([void updates(FundingPositionEligibilityBuilder b)]) = _$FundingPositionEligibility;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingPositionEligibilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingPositionEligibility> get serializer => _$FundingPositionEligibilitySerializer();
}

extension FundingPositionEligibilityDiscriminatorExt on FundingPositionEligibility {
    String? get discriminatorValue {
        if (this is EligibleFundingPositionEligibility) {
            return r'eligible';
        }
        if (this is IneligibleFundingPositionEligibility) {
            return r'ineligible';
        }
        return null;
    }
}
extension FundingPositionEligibilityBuilderDiscriminatorExt on FundingPositionEligibilityBuilder {
    String? get discriminatorValue {
        if (this is EligibleFundingPositionEligibilityBuilder) {
            return r'eligible';
        }
        if (this is IneligibleFundingPositionEligibilityBuilder) {
            return r'ineligible';
        }
        return null;
    }
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
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(FundingPositionEligibility.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [EligibleFundingPositionEligibility, IneligibleFundingPositionEligibility, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'eligible':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(EligibleFundingPositionEligibility),
        ) as EligibleFundingPositionEligibility;
        oneOfType = EligibleFundingPositionEligibility;
        break;
      case r'ineligible':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(IneligibleFundingPositionEligibility),
        ) as IneligibleFundingPositionEligibility;
        oneOfType = IneligibleFundingPositionEligibility;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
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

