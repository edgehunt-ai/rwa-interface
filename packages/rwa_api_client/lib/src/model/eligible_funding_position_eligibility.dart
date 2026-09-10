//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_position_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'eligible_funding_position_eligibility.g.dart';

/// EligibleFundingPositionEligibility
///
/// Properties:
/// * [status] 
/// * [blockers] 
@BuiltValue()
abstract class EligibleFundingPositionEligibility implements Built<EligibleFundingPositionEligibility, EligibleFundingPositionEligibilityBuilder> {
  @BuiltValueField(wireName: r'status')
  EligibleFundingPositionEligibilityStatusEnum get status;
  // enum statusEnum {  eligible,  };

  @BuiltValueField(wireName: r'blockers')
  BuiltList<FundingPositionBlocker> get blockers;

  EligibleFundingPositionEligibility._();

  factory EligibleFundingPositionEligibility([void updates(EligibleFundingPositionEligibilityBuilder b)]) = _$EligibleFundingPositionEligibility;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EligibleFundingPositionEligibilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EligibleFundingPositionEligibility> get serializer => _$EligibleFundingPositionEligibilitySerializer();
}

class _$EligibleFundingPositionEligibilitySerializer implements PrimitiveSerializer<EligibleFundingPositionEligibility> {
  @override
  final Iterable<Type> types = const [EligibleFundingPositionEligibility, _$EligibleFundingPositionEligibility];

  @override
  final String wireName = r'EligibleFundingPositionEligibility';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EligibleFundingPositionEligibility object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(EligibleFundingPositionEligibilityStatusEnum),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltList, [FullType(FundingPositionBlocker)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EligibleFundingPositionEligibility object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required EligibleFundingPositionEligibilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(EligibleFundingPositionEligibilityStatusEnum),
          ) as EligibleFundingPositionEligibilityStatusEnum;
          result.status = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(FundingPositionBlocker)]),
          ) as BuiltList<FundingPositionBlocker>;
          result.blockers.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EligibleFundingPositionEligibility deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EligibleFundingPositionEligibilityBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

class EligibleFundingPositionEligibilityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eligible')
  static const EligibleFundingPositionEligibilityStatusEnum eligible = _$eligibleFundingPositionEligibilityStatusEnum_eligible;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const EligibleFundingPositionEligibilityStatusEnum unknownDefaultOpenApi = _$eligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;

  static Serializer<EligibleFundingPositionEligibilityStatusEnum> get serializer => _$eligibleFundingPositionEligibilityStatusEnumSerializer;

  const EligibleFundingPositionEligibilityStatusEnum._(String name): super(name);

  static BuiltSet<EligibleFundingPositionEligibilityStatusEnum> get values => _$eligibleFundingPositionEligibilityStatusEnumValues;
  static EligibleFundingPositionEligibilityStatusEnum valueOf(String name) => _$eligibleFundingPositionEligibilityStatusEnumValueOf(name);
}

