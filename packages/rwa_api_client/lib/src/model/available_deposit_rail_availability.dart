//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/deposit_rail_blocker.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'available_deposit_rail_availability.g.dart';

/// AvailableDepositRailAvailability
///
/// Properties:
/// * [status] 
/// * [blockers] 
@BuiltValue()
abstract class AvailableDepositRailAvailability implements Built<AvailableDepositRailAvailability, AvailableDepositRailAvailabilityBuilder> {
  @BuiltValueField(wireName: r'status')
  AvailableDepositRailAvailabilityStatusEnum get status;
  // enum statusEnum {  available,  };

  @BuiltValueField(wireName: r'blockers')
  BuiltList<DepositRailBlocker> get blockers;

  AvailableDepositRailAvailability._();

  factory AvailableDepositRailAvailability([void updates(AvailableDepositRailAvailabilityBuilder b)]) = _$AvailableDepositRailAvailability;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AvailableDepositRailAvailabilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AvailableDepositRailAvailability> get serializer => _$AvailableDepositRailAvailabilitySerializer();
}

class _$AvailableDepositRailAvailabilitySerializer implements PrimitiveSerializer<AvailableDepositRailAvailability> {
  @override
  final Iterable<Type> types = const [AvailableDepositRailAvailability, _$AvailableDepositRailAvailability];

  @override
  final String wireName = r'AvailableDepositRailAvailability';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AvailableDepositRailAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(AvailableDepositRailAvailabilityStatusEnum),
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
    AvailableDepositRailAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AvailableDepositRailAvailabilityBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AvailableDepositRailAvailabilityStatusEnum),
          ) as AvailableDepositRailAvailabilityStatusEnum;
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
  AvailableDepositRailAvailability deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AvailableDepositRailAvailabilityBuilder();
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

class AvailableDepositRailAvailabilityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'available')
  static const AvailableDepositRailAvailabilityStatusEnum available = _$availableDepositRailAvailabilityStatusEnum_available;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AvailableDepositRailAvailabilityStatusEnum unknownDefaultOpenApi = _$availableDepositRailAvailabilityStatusEnum_unknownDefaultOpenApi;

  static Serializer<AvailableDepositRailAvailabilityStatusEnum> get serializer => _$availableDepositRailAvailabilityStatusEnumSerializer;

  const AvailableDepositRailAvailabilityStatusEnum._(String name): super(name);

  static BuiltSet<AvailableDepositRailAvailabilityStatusEnum> get values => _$availableDepositRailAvailabilityStatusEnumValues;
  static AvailableDepositRailAvailabilityStatusEnum valueOf(String name) => _$availableDepositRailAvailabilityStatusEnumValueOf(name);
}

