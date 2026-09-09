//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_rail_circuit_open.dart';
import 'package:rwa_api_client/src/model/funding_rail_circuit_closed.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_rail_circuit.g.dart';

/// FundingRailCircuit
///
/// Properties:
/// * [scope]
/// * [state]
/// * [generation]
/// * [reason]
/// * [trippedAt]
@BuiltValue()
abstract class FundingRailCircuit
    implements Built<FundingRailCircuit, FundingRailCircuitBuilder> {
  /// One Of [FundingRailCircuitClosed], [FundingRailCircuitOpen]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'state';

  static const Map<String, Type> discriminatorMapping = {
    r'closed': FundingRailCircuitClosed,
    r'open': FundingRailCircuitOpen,
  };

  FundingRailCircuit._();

  factory FundingRailCircuit([void updates(FundingRailCircuitBuilder b)]) =
      _$FundingRailCircuit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRailCircuitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRailCircuit> get serializer =>
      _$FundingRailCircuitSerializer();
}

extension FundingRailCircuitDiscriminatorExt on FundingRailCircuit {
  String? get discriminatorValue {
    if (this is FundingRailCircuitClosed) {
      return r'closed';
    }
    if (this is FundingRailCircuitOpen) {
      return r'open';
    }
    return null;
  }
}

extension FundingRailCircuitBuilderDiscriminatorExt
    on FundingRailCircuitBuilder {
  String? get discriminatorValue {
    if (this is FundingRailCircuitClosedBuilder) {
      return r'closed';
    }
    if (this is FundingRailCircuitOpenBuilder) {
      return r'open';
    }
    return null;
  }
}

class _$FundingRailCircuitSerializer
    implements PrimitiveSerializer<FundingRailCircuit> {
  @override
  final Iterable<Type> types = const [FundingRailCircuit, _$FundingRailCircuit];

  @override
  final String wireName = r'FundingRailCircuit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRailCircuit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    FundingRailCircuit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingRailCircuit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRailCircuitBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex =
        serializedList.indexOf(FundingRailCircuit.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex],
        specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [
      FundingRailCircuitClosed,
      FundingRailCircuitOpen,
    ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'closed':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(FundingRailCircuitClosed),
        ) as FundingRailCircuitClosed;
        oneOfType = FundingRailCircuitClosed;
        break;
      case r'open':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(FundingRailCircuitOpen),
        ) as FundingRailCircuitOpen;
        oneOfType = FundingRailCircuitOpen;
        break;
      default:
        throw UnsupportedError(
            "Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(
        typeIndex: oneOfTypes.indexOf(oneOfType),
        types: oneOfTypes,
        value: oneOfResult);
    return result.build();
  }
}

class FundingRailCircuitScopeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'hip3')
  static const FundingRailCircuitScopeEnum hip3 =
      _$fundingRailCircuitScopeEnum_hip3;
  @BuiltValueEnumConst(wireName: r'bstocks')
  static const FundingRailCircuitScopeEnum bstocks =
      _$fundingRailCircuitScopeEnum_bstocks;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailCircuitScopeEnum unknownDefaultOpenApi =
      _$fundingRailCircuitScopeEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailCircuitScopeEnum> get serializer =>
      _$fundingRailCircuitScopeEnumSerializer;

  const FundingRailCircuitScopeEnum._(String name) : super(name);

  static BuiltSet<FundingRailCircuitScopeEnum> get values =>
      _$fundingRailCircuitScopeEnumValues;
  static FundingRailCircuitScopeEnum valueOf(String name) =>
      _$fundingRailCircuitScopeEnumValueOf(name);
}

class FundingRailCircuitStateEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'open')
  static const FundingRailCircuitStateEnum open =
      _$fundingRailCircuitStateEnum_open;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailCircuitStateEnum unknownDefaultOpenApi =
      _$fundingRailCircuitStateEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailCircuitStateEnum> get serializer =>
      _$fundingRailCircuitStateEnumSerializer;

  const FundingRailCircuitStateEnum._(String name) : super(name);

  static BuiltSet<FundingRailCircuitStateEnum> get values =>
      _$fundingRailCircuitStateEnumValues;
  static FundingRailCircuitStateEnum valueOf(String name) =>
      _$fundingRailCircuitStateEnumValueOf(name);
}
