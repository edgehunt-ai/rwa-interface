//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_position_blocker.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ineligible_funding_position_eligibility.g.dart';

/// IneligibleFundingPositionEligibility
///
/// Properties:
/// * [status] 
/// * [blockers] 
@BuiltValue()
abstract class IneligibleFundingPositionEligibility implements Built<IneligibleFundingPositionEligibility, IneligibleFundingPositionEligibilityBuilder> {
  @BuiltValueField(wireName: r'status')
  IneligibleFundingPositionEligibilityStatusEnum get status;
  // enum statusEnum {  ineligible,  };

  @BuiltValueField(wireName: r'blockers')
  BuiltSet<FundingPositionBlocker> get blockers;

  IneligibleFundingPositionEligibility._();

  factory IneligibleFundingPositionEligibility([void updates(IneligibleFundingPositionEligibilityBuilder b)]) = _$IneligibleFundingPositionEligibility;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IneligibleFundingPositionEligibilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IneligibleFundingPositionEligibility> get serializer => _$IneligibleFundingPositionEligibilitySerializer();
}

class _$IneligibleFundingPositionEligibilitySerializer implements PrimitiveSerializer<IneligibleFundingPositionEligibility> {
  @override
  final Iterable<Type> types = const [IneligibleFundingPositionEligibility, _$IneligibleFundingPositionEligibility];

  @override
  final String wireName = r'IneligibleFundingPositionEligibility';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IneligibleFundingPositionEligibility object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(IneligibleFundingPositionEligibilityStatusEnum),
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
    IneligibleFundingPositionEligibility object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IneligibleFundingPositionEligibilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IneligibleFundingPositionEligibilityStatusEnum),
          ) as IneligibleFundingPositionEligibilityStatusEnum;
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
  IneligibleFundingPositionEligibility deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IneligibleFundingPositionEligibilityBuilder();
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

class IneligibleFundingPositionEligibilityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'ineligible')
  static const IneligibleFundingPositionEligibilityStatusEnum ineligible = _$ineligibleFundingPositionEligibilityStatusEnum_ineligible;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const IneligibleFundingPositionEligibilityStatusEnum unknownDefaultOpenApi = _$ineligibleFundingPositionEligibilityStatusEnum_unknownDefaultOpenApi;

  static Serializer<IneligibleFundingPositionEligibilityStatusEnum> get serializer => _$ineligibleFundingPositionEligibilityStatusEnumSerializer;

  const IneligibleFundingPositionEligibilityStatusEnum._(String name): super(name);

  static BuiltSet<IneligibleFundingPositionEligibilityStatusEnum> get values => _$ineligibleFundingPositionEligibilityStatusEnumValues;
  static IneligibleFundingPositionEligibilityStatusEnum valueOf(String name) => _$ineligibleFundingPositionEligibilityStatusEnumValueOf(name);
}

