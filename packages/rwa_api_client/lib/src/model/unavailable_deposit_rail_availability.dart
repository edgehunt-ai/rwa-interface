//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/deposit_rail_blocker.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'unavailable_deposit_rail_availability.g.dart';

/// UnavailableDepositRailAvailability
///
/// Properties:
/// * [status] 
/// * [blockers] 
@BuiltValue()
abstract class UnavailableDepositRailAvailability implements Built<UnavailableDepositRailAvailability, UnavailableDepositRailAvailabilityBuilder> {
  @BuiltValueField(wireName: r'status')
  UnavailableDepositRailAvailabilityStatusEnum get status;
  // enum statusEnum {  unavailable,  };

  @BuiltValueField(wireName: r'blockers')
  BuiltList<DepositRailBlocker> get blockers;

  UnavailableDepositRailAvailability._();

  factory UnavailableDepositRailAvailability([void updates(UnavailableDepositRailAvailabilityBuilder b)]) = _$UnavailableDepositRailAvailability;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UnavailableDepositRailAvailabilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UnavailableDepositRailAvailability> get serializer => _$UnavailableDepositRailAvailabilitySerializer();
}

class _$UnavailableDepositRailAvailabilitySerializer implements PrimitiveSerializer<UnavailableDepositRailAvailability> {
  @override
  final Iterable<Type> types = const [UnavailableDepositRailAvailability, _$UnavailableDepositRailAvailability];

  @override
  final String wireName = r'UnavailableDepositRailAvailability';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UnavailableDepositRailAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(UnavailableDepositRailAvailabilityStatusEnum),
    );
    yield r'blockers';
    yield serializers.serialize(
      object.blockers,
      specifiedType: const FullType(BuiltList, [FullType(DepositRailBlocker)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    UnavailableDepositRailAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required UnavailableDepositRailAvailabilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(UnavailableDepositRailAvailabilityStatusEnum),
          ) as UnavailableDepositRailAvailabilityStatusEnum;
          result.status = valueDes;
          break;
        case r'blockers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(DepositRailBlocker)]),
          ) as BuiltList<DepositRailBlocker>;
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
  UnavailableDepositRailAvailability deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UnavailableDepositRailAvailabilityBuilder();
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

class UnavailableDepositRailAvailabilityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unavailable')
  static const UnavailableDepositRailAvailabilityStatusEnum unavailable = _$unavailableDepositRailAvailabilityStatusEnum_unavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const UnavailableDepositRailAvailabilityStatusEnum unknownDefaultOpenApi = _$unavailableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi;

  static Serializer<UnavailableDepositRailAvailabilityStatusEnum> get serializer => _$unavailableDepositRailAvailabilityStatusEnumSerializer;

  const UnavailableDepositRailAvailabilityStatusEnum._(String name): super(name);

  static BuiltSet<UnavailableDepositRailAvailabilityStatusEnum> get values => _$unavailableDepositRailAvailabilityStatusEnumValues;
  static UnavailableDepositRailAvailabilityStatusEnum valueOf(String name) => _$unavailableDepositRailAvailabilityStatusEnumValueOf(name);
}

