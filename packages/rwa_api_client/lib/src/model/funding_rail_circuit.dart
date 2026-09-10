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

/// Structural union; each variant requires its own singleton `state`.
///
/// Properties:
/// * [scope] 
/// * [state] 
/// * [generation] 
/// * [reason] 
/// * [trippedAt] 
@BuiltValue()
abstract class FundingRailCircuit implements Built<FundingRailCircuit, FundingRailCircuitBuilder> {
  /// One Of [FundingRailCircuitClosed], [FundingRailCircuitOpen]
  OneOf get oneOf;

  FundingRailCircuit._();

  factory FundingRailCircuit([void updates(FundingRailCircuitBuilder b)]) = _$FundingRailCircuit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRailCircuitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRailCircuit> get serializer => _$FundingRailCircuitSerializer();
}

class _$FundingRailCircuitSerializer implements PrimitiveSerializer<FundingRailCircuit> {
  @override
  final Iterable<Type> types = const [FundingRailCircuit, _$FundingRailCircuit];

  @override
  final String wireName = r'FundingRailCircuit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRailCircuit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRailCircuit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingRailCircuit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRailCircuitBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(FundingRailCircuitClosed), FullType(FundingRailCircuitOpen), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class FundingRailCircuitScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3')
  static const FundingRailCircuitScopeEnum hip3 = _$fundingRailCircuitScopeEnum_hip3;
  @BuiltValueEnumConst(wireName: r'bstocks')
  static const FundingRailCircuitScopeEnum bstocks = _$fundingRailCircuitScopeEnum_bstocks;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailCircuitScopeEnum unknownDefaultOpenApi = _$fundingRailCircuitScopeEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailCircuitScopeEnum> get serializer => _$fundingRailCircuitScopeEnumSerializer;

  const FundingRailCircuitScopeEnum._(String name): super(name);

  static BuiltSet<FundingRailCircuitScopeEnum> get values => _$fundingRailCircuitScopeEnumValues;
  static FundingRailCircuitScopeEnum valueOf(String name) => _$fundingRailCircuitScopeEnumValueOf(name);
}

class FundingRailCircuitStateEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'open')
  static const FundingRailCircuitStateEnum open = _$fundingRailCircuitStateEnum_open;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailCircuitStateEnum unknownDefaultOpenApi = _$fundingRailCircuitStateEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailCircuitStateEnum> get serializer => _$fundingRailCircuitStateEnumSerializer;

  const FundingRailCircuitStateEnum._(String name): super(name);

  static BuiltSet<FundingRailCircuitStateEnum> get values => _$fundingRailCircuitStateEnumValues;
  static FundingRailCircuitStateEnum valueOf(String name) => _$fundingRailCircuitStateEnumValueOf(name);
}

