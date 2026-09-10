//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/multi_source_funding_leg.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'multi_source_funding_plan_details.g.dart';

/// Server-owned deterministic allocation for `auto_multi_source`. The server fixes the maximum at three legs, freezes the source snapshots and Provider routes, and permits Transfer creation only for the next eligible leg in ordinal order. `funded` and `blocked` plans can contain zero legs because they require no executable allocation; executable plan states contain one to three. 
///
/// Properties:
/// * [allocationPolicyVersion] 
/// * [maxLegs] - Server-owned upper bound; clients cannot submit or override it.
/// * [excludedSourcePositionIds] - Account-scoped opaque positions excluded by the accepted planning request.
/// * [allocatedOutputAmount] - 十进制字符串，避免浮点误差
/// * [legs] 
@BuiltValue()
abstract class MultiSourceFundingPlanDetails implements Built<MultiSourceFundingPlanDetails, MultiSourceFundingPlanDetailsBuilder> {
  @BuiltValueField(wireName: r'allocation_policy_version')
  String get allocationPolicyVersion;

  /// Server-owned upper bound; clients cannot submit or override it.
  @BuiltValueField(wireName: r'max_legs')
  MultiSourceFundingPlanDetailsMaxLegsEnum get maxLegs;
  // enum maxLegsEnum {  3,  };

  /// Account-scoped opaque positions excluded by the accepted planning request.
  @BuiltValueField(wireName: r'excluded_source_position_ids')
  BuiltSet<String> get excludedSourcePositionIds;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'allocated_output_amount')
  String get allocatedOutputAmount;

  @BuiltValueField(wireName: r'legs')
  BuiltList<MultiSourceFundingLeg> get legs;

  MultiSourceFundingPlanDetails._();

  factory MultiSourceFundingPlanDetails([void updates(MultiSourceFundingPlanDetailsBuilder b)]) = _$MultiSourceFundingPlanDetails;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MultiSourceFundingPlanDetailsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MultiSourceFundingPlanDetails> get serializer => _$MultiSourceFundingPlanDetailsSerializer();
}

class _$MultiSourceFundingPlanDetailsSerializer implements PrimitiveSerializer<MultiSourceFundingPlanDetails> {
  @override
  final Iterable<Type> types = const [MultiSourceFundingPlanDetails, _$MultiSourceFundingPlanDetails];

  @override
  final String wireName = r'MultiSourceFundingPlanDetails';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MultiSourceFundingPlanDetails object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'allocation_policy_version';
    yield serializers.serialize(
      object.allocationPolicyVersion,
      specifiedType: const FullType(String),
    );
    yield r'max_legs';
    yield serializers.serialize(
      object.maxLegs,
      specifiedType: const FullType(MultiSourceFundingPlanDetailsMaxLegsEnum),
    );
    yield r'excluded_source_position_ids';
    yield serializers.serialize(
      object.excludedSourcePositionIds,
      specifiedType: const FullType(BuiltSet, [FullType(String)]),
    );
    yield r'allocated_output_amount';
    yield serializers.serialize(
      object.allocatedOutputAmount,
      specifiedType: const FullType(String),
    );
    yield r'legs';
    yield serializers.serialize(
      object.legs,
      specifiedType: const FullType(BuiltList, [FullType(MultiSourceFundingLeg)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    MultiSourceFundingPlanDetails object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MultiSourceFundingPlanDetailsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'allocation_policy_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.allocationPolicyVersion = valueDes;
          break;
        case r'max_legs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(MultiSourceFundingPlanDetailsMaxLegsEnum),
          ) as MultiSourceFundingPlanDetailsMaxLegsEnum;
          result.maxLegs = valueDes;
          break;
        case r'excluded_source_position_ids':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltSet, [FullType(String)]),
          ) as BuiltSet<String>;
          result.excludedSourcePositionIds.replace(valueDes);
          break;
        case r'allocated_output_amount':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.allocatedOutputAmount = valueDes;
          break;
        case r'legs':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(MultiSourceFundingLeg)]),
          ) as BuiltList<MultiSourceFundingLeg>;
          result.legs.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MultiSourceFundingPlanDetails deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MultiSourceFundingPlanDetailsBuilder();
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

class MultiSourceFundingPlanDetailsMaxLegsEnum extends EnumClass {

  /// Server-owned upper bound; clients cannot submit or override it.
  @BuiltValueEnumConst(wireNumber: 3)
  static const MultiSourceFundingPlanDetailsMaxLegsEnum number3 = _$multiSourceFundingPlanDetailsMaxLegsEnum_number3;
  /// Server-owned upper bound; clients cannot submit or override it.
  @BuiltValueEnumConst(wireNumber: 11184809, fallback: true)
  static const MultiSourceFundingPlanDetailsMaxLegsEnum unknownDefaultOpenApi = _$multiSourceFundingPlanDetailsMaxLegsEnum_unknownDefaultOpenApi;

  static Serializer<MultiSourceFundingPlanDetailsMaxLegsEnum> get serializer => _$multiSourceFundingPlanDetailsMaxLegsEnumSerializer;

  const MultiSourceFundingPlanDetailsMaxLegsEnum._(String name): super(name);

  static BuiltSet<MultiSourceFundingPlanDetailsMaxLegsEnum> get values => _$multiSourceFundingPlanDetailsMaxLegsEnumValues;
  static MultiSourceFundingPlanDetailsMaxLegsEnum valueOf(String name) => _$multiSourceFundingPlanDetailsMaxLegsEnumValueOf(name);
}

