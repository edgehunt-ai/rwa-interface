//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_rail_circuit_open.g.dart';

/// FundingRailCircuitOpen
///
/// Properties:
/// * [scope]
/// * [state]
/// * [generation]
/// * [reason]
/// * [trippedAt]
@BuiltValue()
abstract class FundingRailCircuitOpen
    implements Built<FundingRailCircuitOpen, FundingRailCircuitOpenBuilder> {
  @BuiltValueField(wireName: r'scope')
  FundingRailCircuitOpenScopeEnum get scope;
  // enum scopeEnum {  hip3,  bstocks,  };

  @BuiltValueField(wireName: r'state')
  FundingRailCircuitOpenStateEnum get state;
  // enum stateEnum {  open,  };

  @BuiltValueField(wireName: r'generation')
  int get generation;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'tripped_at')
  DateTime get trippedAt;

  FundingRailCircuitOpen._();

  factory FundingRailCircuitOpen(
          [void updates(FundingRailCircuitOpenBuilder b)]) =
      _$FundingRailCircuitOpen;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingRailCircuitOpenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingRailCircuitOpen> get serializer =>
      _$FundingRailCircuitOpenSerializer();
}

class _$FundingRailCircuitOpenSerializer
    implements PrimitiveSerializer<FundingRailCircuitOpen> {
  @override
  final Iterable<Type> types = const [
    FundingRailCircuitOpen,
    _$FundingRailCircuitOpen
  ];

  @override
  final String wireName = r'FundingRailCircuitOpen';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingRailCircuitOpen object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(FundingRailCircuitOpenScopeEnum),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(FundingRailCircuitOpenStateEnum),
    );
    yield r'generation';
    yield serializers.serialize(
      object.generation,
      specifiedType: const FullType(int),
    );
    yield r'reason';
    yield serializers.serialize(
      object.reason,
      specifiedType: const FullType(String),
    );
    yield r'tripped_at';
    yield serializers.serialize(
      object.trippedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    FundingRailCircuitOpen object, {
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
    required FundingRailCircuitOpenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRailCircuitOpenScopeEnum),
          ) as FundingRailCircuitOpenScopeEnum;
          result.scope = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingRailCircuitOpenStateEnum),
          ) as FundingRailCircuitOpenStateEnum;
          result.state = valueDes;
          break;
        case r'generation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.generation = valueDes;
          break;
        case r'reason':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reason = valueDes;
          break;
        case r'tripped_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.trippedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  FundingRailCircuitOpen deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingRailCircuitOpenBuilder();
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

class FundingRailCircuitOpenScopeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'hip3')
  static const FundingRailCircuitOpenScopeEnum hip3 =
      _$fundingRailCircuitOpenScopeEnum_hip3;
  @BuiltValueEnumConst(wireName: r'bstocks')
  static const FundingRailCircuitOpenScopeEnum bstocks =
      _$fundingRailCircuitOpenScopeEnum_bstocks;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailCircuitOpenScopeEnum unknownDefaultOpenApi =
      _$fundingRailCircuitOpenScopeEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailCircuitOpenScopeEnum> get serializer =>
      _$fundingRailCircuitOpenScopeEnumSerializer;

  const FundingRailCircuitOpenScopeEnum._(String name) : super(name);

  static BuiltSet<FundingRailCircuitOpenScopeEnum> get values =>
      _$fundingRailCircuitOpenScopeEnumValues;
  static FundingRailCircuitOpenScopeEnum valueOf(String name) =>
      _$fundingRailCircuitOpenScopeEnumValueOf(name);
}

class FundingRailCircuitOpenStateEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'open')
  static const FundingRailCircuitOpenStateEnum open =
      _$fundingRailCircuitOpenStateEnum_open;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingRailCircuitOpenStateEnum unknownDefaultOpenApi =
      _$fundingRailCircuitOpenStateEnum_unknownDefaultOpenApi;

  static Serializer<FundingRailCircuitOpenStateEnum> get serializer =>
      _$fundingRailCircuitOpenStateEnumSerializer;

  const FundingRailCircuitOpenStateEnum._(String name) : super(name);

  static BuiltSet<FundingRailCircuitOpenStateEnum> get values =>
      _$fundingRailCircuitOpenStateEnumValues;
  static FundingRailCircuitOpenStateEnum valueOf(String name) =>
      _$fundingRailCircuitOpenStateEnumValueOf(name);
}
