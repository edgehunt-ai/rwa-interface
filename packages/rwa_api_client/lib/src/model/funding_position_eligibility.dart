//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_position_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_position_eligibility.g.dart';

/// Eligibility for one exact source position. Eligible positions have no blockers; ineligible positions have at least one blocker. 
///
/// Properties:
/// * [status] 
/// * [blockers] 
@BuiltValue()
abstract class FundingPositionEligibility implements Built<FundingPositionEligibility, FundingPositionEligibilityBuilder> {
  @BuiltValueField(wireName: r'status')
  FundingPositionEligibilityStatusEnum get status;
  // enum statusEnum {  eligible,  ineligible,  };

  @BuiltValueField(wireName: r'blockers')
  BuiltSet<FundingPositionBlocker> get blockers;

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
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(FundingPositionEligibilityStatusEnum),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltSet, [FullType(FundingPositionBlocker)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingPositionEligibility object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingPositionEligibilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingPositionEligibilityStatusEnum),
          ) as FundingPositionEligibilityStatusEnum;
          result.status = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(FundingPositionBlocker)]),
          ) as BuiltSet<FundingPositionBlocker>;
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
  FundingPositionEligibility deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingPositionEligibilityBuilder();
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

class FundingPositionEligibilityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'eligible')
  static const FundingPositionEligibilityStatusEnum eligible = _$fundingPositionEligibilityStatusEnum_eligible;
  @BuiltValueEnumConst(wireName: r'ineligible')
  static const FundingPositionEligibilityStatusEnum ineligible = _$fundingPositionEligibilityStatusEnum_ineligible;

  static Serializer<FundingPositionEligibilityStatusEnum> get serializer => _$fundingPositionEligibilityStatusEnumSerializer;

  const FundingPositionEligibilityStatusEnum._(String name): super(name);

  static BuiltSet<FundingPositionEligibilityStatusEnum> get values => _$fundingPositionEligibilityStatusEnumValues;
  static FundingPositionEligibilityStatusEnum valueOf(String name) => _$fundingPositionEligibilityStatusEnumValueOf(name);
}

