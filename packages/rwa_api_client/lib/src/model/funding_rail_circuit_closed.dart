//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_rail_circuit_closed.g.dart';

/// FundingRailCircuitClosed
///
/// Properties:
/// * [scope] 
/// * [state] 
/// * [generation] 
@BuiltValue()
abstract class FundingRailCircuitClosed implements Built<FundingRailCircuitClosed, FundingRailCircuitClosedBuilder> {
  @BuiltValueField(wireName: r'scope')
  FundingRailCircuitClosedScopeEnum get scope;
  // enum scopeEnum {  hip3,  bstocks,  };

  @BuiltValueField(wireName: r'state')
  FundingRailCircuitClosedStateEnum get state;
  // enum stateEnum {  closed,  };

  @BuiltValueField(wireName: r'generation')
  int get generation;

  FundingRailCircuitClosed._();

  factory FundingRailCircuitClosed([void updates(FundingRailCircuitClosedBuilder b)]) = _$FundingRailCircuitClosed;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRailCircuitClosedBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRailCircuitClosed> get serializer => _$FundingRailCircuitClosedSerializer();
}

class _$FundingRailCircuitClosedSerializer implements PrimitiveSerializer<FundingRailCircuitClosed> {
  @override
  final Iterable<Type> types = const [FundingRailCircuitClosed, _$FundingRailCircuitClosed];

  @override
  final String wireName = r'FundingRailCircuitClosed';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRailCircuitClosed object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(FundingRailCircuitClosedScopeEnum),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(FundingRailCircuitClosedStateEnum),
    );
    yield r'generation';
    yield serializers.serialize(
      object.generation,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRailCircuitClosed object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingRailCircuitClosedBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRailCircuitClosedScopeEnum),
          ) as FundingRailCircuitClosedScopeEnum;
          result.scope = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRailCircuitClosedStateEnum),
          ) as FundingRailCircuitClosedStateEnum;
          result.state = valueDes;
          break;
        case r'generation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.generation = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingRailCircuitClosed deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRailCircuitClosedBuilder();
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

class FundingRailCircuitClosedScopeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'hip3')
  static const FundingRailCircuitClosedScopeEnum hip3 = _$fundingRailCircuitClosedScopeEnum_hip3;
  @BuiltValueEnumConst(wireName: r'bstocks')
  static const FundingRailCircuitClosedScopeEnum bstocks = _$fundingRailCircuitClosedScopeEnum_bstocks;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailCircuitClosedScopeEnum unknownDefaultOpenApi = _$fundingRailCircuitClosedScopeEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailCircuitClosedScopeEnum> get serializer => _$fundingRailCircuitClosedScopeEnumSerializer;

  const FundingRailCircuitClosedScopeEnum._(String name): super(name);

  static BuiltSet<FundingRailCircuitClosedScopeEnum> get values => _$fundingRailCircuitClosedScopeEnumValues;
  static FundingRailCircuitClosedScopeEnum valueOf(String name) => _$fundingRailCircuitClosedScopeEnumValueOf(name);
}

class FundingRailCircuitClosedStateEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'closed')
  static const FundingRailCircuitClosedStateEnum closed = _$fundingRailCircuitClosedStateEnum_closed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailCircuitClosedStateEnum unknownDefaultOpenApi = _$fundingRailCircuitClosedStateEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailCircuitClosedStateEnum> get serializer => _$fundingRailCircuitClosedStateEnumSerializer;

  const FundingRailCircuitClosedStateEnum._(String name): super(name);

  static BuiltSet<FundingRailCircuitClosedStateEnum> get values => _$fundingRailCircuitClosedStateEnumValues;
  static FundingRailCircuitClosedStateEnum valueOf(String name) => _$fundingRailCircuitClosedStateEnumValueOf(name);
}

