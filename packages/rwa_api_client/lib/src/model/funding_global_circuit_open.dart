//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'funding_global_circuit_open.g.dart';

/// FundingGlobalCircuitOpen
///
/// Properties:
/// * [scope]
/// * [state]
/// * [generation]
/// * [reason]
/// * [trippedAt]
@BuiltValue()
abstract class FundingGlobalCircuitOpen
    implements
        Built<FundingGlobalCircuitOpen, FundingGlobalCircuitOpenBuilder> {
  @BuiltValueField(wireName: r'scope')
  FundingGlobalCircuitOpenScopeEnum get scope;
  // enum scopeEnum {  global,  };

  @BuiltValueField(wireName: r'state')
  FundingGlobalCircuitOpenStateEnum get state;
  // enum stateEnum {  open,  };

  @BuiltValueField(wireName: r'generation')
  int get generation;

  @BuiltValueField(wireName: r'reason')
  String get reason;

  @BuiltValueField(wireName: r'tripped_at')
  DateTime get trippedAt;

  FundingGlobalCircuitOpen._();

  factory FundingGlobalCircuitOpen(
          [void updates(FundingGlobalCircuitOpenBuilder b)]) =
      _$FundingGlobalCircuitOpen;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingGlobalCircuitOpenBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingGlobalCircuitOpen> get serializer =>
      _$FundingGlobalCircuitOpenSerializer();
}

class _$FundingGlobalCircuitOpenSerializer
    implements PrimitiveSerializer<FundingGlobalCircuitOpen> {
  @override
  final Iterable<Type> types = const [
    FundingGlobalCircuitOpen,
    _$FundingGlobalCircuitOpen
  ];

  @override
  final String wireName = r'FundingGlobalCircuitOpen';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingGlobalCircuitOpen object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'scope';
    yield serializers.serialize(
      object.scope,
      specifiedType: const FullType(FundingGlobalCircuitOpenScopeEnum),
    );
    yield r'state';
    yield serializers.serialize(
      object.state,
      specifiedType: const FullType(FundingGlobalCircuitOpenStateEnum),
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
    FundingGlobalCircuitOpen object, {
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
    required FundingGlobalCircuitOpenBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'scope':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingGlobalCircuitOpenScopeEnum),
          ) as FundingGlobalCircuitOpenScopeEnum;
          result.scope = valueDes;
          break;
        case r'state':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(FundingGlobalCircuitOpenStateEnum),
          ) as FundingGlobalCircuitOpenStateEnum;
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
  FundingGlobalCircuitOpen deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingGlobalCircuitOpenBuilder();
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

class FundingGlobalCircuitOpenScopeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'global')
  static const FundingGlobalCircuitOpenScopeEnum global =
      _$fundingGlobalCircuitOpenScopeEnum_global;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingGlobalCircuitOpenScopeEnum unknownDefaultOpenApi =
      _$fundingGlobalCircuitOpenScopeEnum_unknownDefaultOpenApi;

  static Serializer<FundingGlobalCircuitOpenScopeEnum> get serializer =>
      _$fundingGlobalCircuitOpenScopeEnumSerializer;

  const FundingGlobalCircuitOpenScopeEnum._(String name) : super(name);

  static BuiltSet<FundingGlobalCircuitOpenScopeEnum> get values =>
      _$fundingGlobalCircuitOpenScopeEnumValues;
  static FundingGlobalCircuitOpenScopeEnum valueOf(String name) =>
      _$fundingGlobalCircuitOpenScopeEnumValueOf(name);
}

class FundingGlobalCircuitOpenStateEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'open')
  static const FundingGlobalCircuitOpenStateEnum open =
      _$fundingGlobalCircuitOpenStateEnum_open;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingGlobalCircuitOpenStateEnum unknownDefaultOpenApi =
      _$fundingGlobalCircuitOpenStateEnum_unknownDefaultOpenApi;

  static Serializer<FundingGlobalCircuitOpenStateEnum> get serializer =>
      _$fundingGlobalCircuitOpenStateEnumSerializer;

  const FundingGlobalCircuitOpenStateEnum._(String name) : super(name);

  static BuiltSet<FundingGlobalCircuitOpenStateEnum> get values =>
      _$fundingGlobalCircuitOpenStateEnumValues;
  static FundingGlobalCircuitOpenStateEnum valueOf(String name) =>
      _$fundingGlobalCircuitOpenStateEnumValueOf(name);
}
