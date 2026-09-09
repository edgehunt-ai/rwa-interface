//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_order_wallet_action_state.g.dart';

/// PerpOrderWalletActionState
///
/// Properties:
/// * [kind] 
/// * [nextAction] 
/// * [walletActionBlocker] 
@BuiltValue()
abstract class PerpOrderWalletActionState implements Built<PerpOrderWalletActionState, PerpOrderWalletActionStateBuilder> {
  @BuiltValueField(wireName: r'kind')
  PerpOrderWalletActionStateKindEnum get kind;
  // enum kindEnum {  perp,  };

  @BuiltValueField(wireName: r'next_action')
  JsonObject? get nextAction;

  @BuiltValueField(wireName: r'wallet_action_blocker')
  PerpOrderWalletActionStateWalletActionBlockerEnum get walletActionBlocker;
  // enum walletActionBlockerEnum {  not_applicable,  };

  PerpOrderWalletActionState._();

  factory PerpOrderWalletActionState([void updates(PerpOrderWalletActionStateBuilder b)]) = _$PerpOrderWalletActionState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PerpOrderWalletActionStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpOrderWalletActionState> get serializer => _$PerpOrderWalletActionStateSerializer();
}

class _$PerpOrderWalletActionStateSerializer implements PrimitiveSerializer<PerpOrderWalletActionState> {
  @override
  final Iterable<Type> types = const [PerpOrderWalletActionState, _$PerpOrderWalletActionState];

  @override
  final String wireName = r'PerpOrderWalletActionState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(PerpOrderWalletActionStateKindEnum),
    );
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(JsonObject),
    );
    yield r'wallet_action_blocker';
    yield serializers.serialize(
      object.walletActionBlocker,
      specifiedType: const FullType(PerpOrderWalletActionStateWalletActionBlockerEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PerpOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PerpOrderWalletActionStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpOrderWalletActionStateKindEnum),
          ) as PerpOrderWalletActionStateKindEnum;
          result.kind = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(JsonObject),
          ) as JsonObject?;
          if (valueDes == null) continue;
          result.nextAction = valueDes;
          break;
        case r'wallet_action_blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PerpOrderWalletActionStateWalletActionBlockerEnum),
          ) as PerpOrderWalletActionStateWalletActionBlockerEnum;
          result.walletActionBlocker = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PerpOrderWalletActionState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PerpOrderWalletActionStateBuilder();
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

class PerpOrderWalletActionStateKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'perp')
  static const PerpOrderWalletActionStateKindEnum perp = _$perpOrderWalletActionStateKindEnum_perp;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpOrderWalletActionStateKindEnum unknownDefaultOpenApi = _$perpOrderWalletActionStateKindEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderWalletActionStateKindEnum> get serializer => _$perpOrderWalletActionStateKindEnumSerializer;

  const PerpOrderWalletActionStateKindEnum._(String name): super(name);

  static BuiltSet<PerpOrderWalletActionStateKindEnum> get values => _$perpOrderWalletActionStateKindEnumValues;
  static PerpOrderWalletActionStateKindEnum valueOf(String name) => _$perpOrderWalletActionStateKindEnumValueOf(name);
}

class PerpOrderWalletActionStateWalletActionBlockerEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'not_applicable')
  static const PerpOrderWalletActionStateWalletActionBlockerEnum notApplicable = _$perpOrderWalletActionStateWalletActionBlockerEnum_notApplicable;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PerpOrderWalletActionStateWalletActionBlockerEnum unknownDefaultOpenApi = _$perpOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi;

  static Serializer<PerpOrderWalletActionStateWalletActionBlockerEnum> get serializer => _$perpOrderWalletActionStateWalletActionBlockerEnumSerializer;

  const PerpOrderWalletActionStateWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<PerpOrderWalletActionStateWalletActionBlockerEnum> get values => _$perpOrderWalletActionStateWalletActionBlockerEnumValues;
  static PerpOrderWalletActionStateWalletActionBlockerEnum valueOf(String name) => _$perpOrderWalletActionStateWalletActionBlockerEnumValueOf(name);
}

