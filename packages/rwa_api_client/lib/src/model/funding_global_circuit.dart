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

/// FundingGlobalCircuit
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

  static const String discriminatorFieldName = r'state';

  static const Map<String, Type> discriminatorMapping = {
    r'closed': FundingGlobalCircuitClosed,
    r'open': FundingGlobalCircuitOpen,
  };

  FundingGlobalCircuit._();

  factory FundingGlobalCircuit([void updates(FundingGlobalCircuitBuilder b)]) = _$FundingGlobalCircuit;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingGlobalCircuitBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingGlobalCircuit> get serializer => _$FundingGlobalCircuitSerializer();
}

extension FundingGlobalCircuitDiscriminatorExt on FundingGlobalCircuit {
    String? get discriminatorValue {
        if (this is FundingGlobalCircuitClosed) {
            return r'closed';
        }
        if (this is FundingGlobalCircuitOpen) {
            return r'open';
        }
        return null;
    }
}
extension FundingGlobalCircuitBuilderDiscriminatorExt on FundingGlobalCircuitBuilder {
    String? get discriminatorValue {
        if (this is FundingGlobalCircuitClosedBuilder) {
            return r'closed';
        }
        if (this is FundingGlobalCircuitOpenBuilder) {
            return r'open';
        }
        return null;
    }
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
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(FundingGlobalCircuit.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [FundingGlobalCircuitClosed, FundingGlobalCircuitOpen, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'closed':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(FundingGlobalCircuitClosed),
        ) as FundingGlobalCircuitClosed;
        oneOfType = FundingGlobalCircuitClosed;
        break;
      case r'open':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(FundingGlobalCircuitOpen),
        ) as FundingGlobalCircuitOpen;
        oneOfType = FundingGlobalCircuitOpen;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
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

