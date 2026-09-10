//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_global_circuit_closed.dart';
import 'package:rwa_api_client/src/model/funding_global_circuit_open.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_global_circuit.g.dart';

/// Structural union; each variant requires its own singleton `state`.
///
/// Properties:
/// * [scope] 
/// * [state] 
/// * [generation] 
/// * [reason] 
/// * [trippedAt] 
@BuiltValue()
abstract class FundingGlobalCircuit implements Built<FundingGlobalCircuit, FundingGlobalCircuitBuilder> {
  /// One Of [FundingGlobalCircuitClosed], [FundingGlobalCircuitOpen]
  OneOf get oneOf;

  FundingGlobalCircuit._();

  factory FundingGlobalCircuit([void updates(FundingGlobalCircuitBuilder b)]) = _$FundingGlobalCircuit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingGlobalCircuitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingGlobalCircuit> get serializer => _$FundingGlobalCircuitSerializer();
}

class _$FundingGlobalCircuitSerializer implements PrimitiveSerializer<FundingGlobalCircuit> {
  @override
  final Iterable<Type> types = const [FundingGlobalCircuit, _$FundingGlobalCircuit];

  @override
  final String wireName = r'FundingGlobalCircuit';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingGlobalCircuit object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingGlobalCircuit object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingGlobalCircuit deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingGlobalCircuitBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(FundingGlobalCircuitClosed), FullType(FundingGlobalCircuitOpen), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class FundingGlobalCircuitScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'global')
  static const FundingGlobalCircuitScopeEnum global = _$fundingGlobalCircuitScopeEnum_global;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingGlobalCircuitScopeEnum unknownDefaultOpenApi = _$fundingGlobalCircuitScopeEnum_unknownDefaultOpenApi;

  static Serializer<FundingGlobalCircuitScopeEnum> get serializer => _$fundingGlobalCircuitScopeEnumSerializer;

  const FundingGlobalCircuitScopeEnum._(String name): super(name);

  static BuiltSet<FundingGlobalCircuitScopeEnum> get values => _$fundingGlobalCircuitScopeEnumValues;
  static FundingGlobalCircuitScopeEnum valueOf(String name) => _$fundingGlobalCircuitScopeEnumValueOf(name);
}

class FundingGlobalCircuitStateEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'open')
  static const FundingGlobalCircuitStateEnum open = _$fundingGlobalCircuitStateEnum_open;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingGlobalCircuitStateEnum unknownDefaultOpenApi = _$fundingGlobalCircuitStateEnum_unknownDefaultOpenApi;

  static Serializer<FundingGlobalCircuitStateEnum> get serializer => _$fundingGlobalCircuitStateEnumSerializer;

  const FundingGlobalCircuitStateEnum._(String name): super(name);

  static BuiltSet<FundingGlobalCircuitStateEnum> get values => _$fundingGlobalCircuitStateEnumValues;
  static FundingGlobalCircuitStateEnum valueOf(String name) => _$fundingGlobalCircuitStateEnumValueOf(name);
}

