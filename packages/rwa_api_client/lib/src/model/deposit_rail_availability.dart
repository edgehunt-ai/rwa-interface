//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/unavailable_deposit_rail_availability.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/available_deposit_rail_availability.dart';
import 'package:rwa_api_client/src/model/deposit_rail_blocker.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'deposit_rail_availability.g.dart';

/// Deposit rail readiness；`available` 必须没有 blocker，`unavailable` 至少一个 blocker。
///
/// Properties:
/// * [status] 
/// * [blockers] 
@BuiltValue()
abstract class DepositRailAvailability implements Built<DepositRailAvailability, DepositRailAvailabilityBuilder> {
  /// One Of [AvailableDepositRailAvailability], [UnavailableDepositRailAvailability]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'status';

  static const Map<String, Type> discriminatorMapping = {
    r'available': AvailableDepositRailAvailability,
    r'unavailable': UnavailableDepositRailAvailability,
  };

  DepositRailAvailability._();

  factory DepositRailAvailability([void updates(DepositRailAvailabilityBuilder b)]) = _$DepositRailAvailability;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DepositRailAvailabilityBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DepositRailAvailability> get serializer => _$DepositRailAvailabilitySerializer();
}

extension DepositRailAvailabilityDiscriminatorExt on DepositRailAvailability {
    String? get discriminatorValue {
        if (this is AvailableDepositRailAvailability) {
            return r'available';
        }
        if (this is UnavailableDepositRailAvailability) {
            return r'unavailable';
        }
        return null;
    }
}
extension DepositRailAvailabilityBuilderDiscriminatorExt on DepositRailAvailabilityBuilder {
    String? get discriminatorValue {
        if (this is AvailableDepositRailAvailabilityBuilder) {
            return r'available';
        }
        if (this is UnavailableDepositRailAvailabilityBuilder) {
            return r'unavailable';
        }
        return null;
    }
}

class _$DepositRailAvailabilitySerializer implements PrimitiveSerializer<DepositRailAvailability> {
  @override
  final Iterable<Type> types = const [DepositRailAvailability, _$DepositRailAvailability];

  @override
  final String wireName = r'DepositRailAvailability';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DepositRailAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    DepositRailAvailability object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  DepositRailAvailability deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DepositRailAvailabilityBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(DepositRailAvailability.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [AvailableDepositRailAvailability, UnavailableDepositRailAvailability, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'available':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(AvailableDepositRailAvailability),
        ) as AvailableDepositRailAvailability;
        oneOfType = AvailableDepositRailAvailability;
        break;
      case r'unavailable':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(UnavailableDepositRailAvailability),
        ) as UnavailableDepositRailAvailability;
        oneOfType = UnavailableDepositRailAvailability;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class DepositRailAvailabilityStatusEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'unavailable')
  static const DepositRailAvailabilityStatusEnum unavailable = _$depositRailAvailabilityStatusEnum_unavailable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const DepositRailAvailabilityStatusEnum unknownDefaultOpenApi = _$depositRailAvailabilityStatusEnum_unknownDefaultOpenApi;

  static Serializer<DepositRailAvailabilityStatusEnum> get serializer => _$depositRailAvailabilityStatusEnumSerializer;

  const DepositRailAvailabilityStatusEnum._(String name): super(name);

  static BuiltSet<DepositRailAvailabilityStatusEnum> get values => _$depositRailAvailabilityStatusEnumValues;
  static DepositRailAvailabilityStatusEnum valueOf(String name) => _$depositRailAvailabilityStatusEnumValueOf(name);
}

