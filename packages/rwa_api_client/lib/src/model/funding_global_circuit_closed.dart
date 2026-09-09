//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_global_circuit_closed.g.dart';

/// FundingGlobalCircuitClosed
///
/// Properties:
/// * [scope]
/// * [state]
/// * [generation]
@BuiltValue()
abstract class FundingGlobalCircuitClosed
    implements
        Built<FundingGlobalCircuitClosed, FundingGlobalCircuitClosedBuilder> {
  @BuiltValueField(wireName: r'scope')
  FundingGlobalCircuitClosedScopeEnum get scope;
  // enum scopeEnum {  global,  };

  @BuiltValueField(wireName: r'state')
  FundingGlobalCircuitClosedStateEnum get state;
  // enum stateEnum {  closed,  };

  @BuiltValueField(wireName: r'generation')
  int get generation;

  FundingGlobalCircuitClosed._();

  factory FundingGlobalCircuitClosed(
          [void updates(FundingGlobalCircuitClosedBuilder b)]) =
      _$FundingGlobalCircuitClosed;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingGlobalCircuitClosedBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingGlobalCircuitClosed> get serializer =>
      _$FundingGlobalCircuitClosedSerializer();
}

class _$FundingGlobalCircuitClosedSerializer
    implements PrimitiveSerializer<FundingGlobalCircuitClosed> {
  @override
  final Iterable<Type> types = const [
    FundingGlobalCircuitClosed,
    _$FundingGlobalCircuitClosed
  ];

  @override
  final String wireName = r'FundingGlobalCircuitClosed';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingGlobalCircuitClosed object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(FundingGlobalCircuitClosedScopeEnum),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(FundingGlobalCircuitClosedStateEnum),
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
    FundingGlobalCircuitClosed object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required FundingGlobalCircuitClosedBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingGlobalCircuitClosedScopeEnum),
          ) as FundingGlobalCircuitClosedScopeEnum;
          result.scope = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingGlobalCircuitClosedStateEnum),
          ) as FundingGlobalCircuitClosedStateEnum;
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
  FundingGlobalCircuitClosed deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingGlobalCircuitClosedBuilder();
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

class FundingGlobalCircuitClosedScopeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'global')
  static const FundingGlobalCircuitClosedScopeEnum global =
      _$fundingGlobalCircuitClosedScopeEnum_global;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingGlobalCircuitClosedScopeEnum unknownDefaultOpenApi =
      _$fundingGlobalCircuitClosedScopeEnum_unknownDefaultOpenApi;

  static Serializer<FundingGlobalCircuitClosedScopeEnum> get serializer =>
      _$fundingGlobalCircuitClosedScopeEnumSerializer;

  const FundingGlobalCircuitClosedScopeEnum._(String name) : super(name);

  static BuiltSet<FundingGlobalCircuitClosedScopeEnum> get values =>
      _$fundingGlobalCircuitClosedScopeEnumValues;
  static FundingGlobalCircuitClosedScopeEnum valueOf(String name) =>
      _$fundingGlobalCircuitClosedScopeEnumValueOf(name);
}

class FundingGlobalCircuitClosedStateEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'closed')
  static const FundingGlobalCircuitClosedStateEnum closed =
      _$fundingGlobalCircuitClosedStateEnum_closed;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingGlobalCircuitClosedStateEnum unknownDefaultOpenApi =
      _$fundingGlobalCircuitClosedStateEnum_unknownDefaultOpenApi;

  static Serializer<FundingGlobalCircuitClosedStateEnum> get serializer =>
      _$fundingGlobalCircuitClosedStateEnumSerializer;

  const FundingGlobalCircuitClosedStateEnum._(String name) : super(name);

  static BuiltSet<FundingGlobalCircuitClosedStateEnum> get values =>
      _$fundingGlobalCircuitClosedStateEnumValues;
  static FundingGlobalCircuitClosedStateEnum valueOf(String name) =>
      _$fundingGlobalCircuitClosedStateEnumValueOf(name);
}
