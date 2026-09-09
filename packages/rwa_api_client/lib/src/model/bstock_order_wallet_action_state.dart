//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_evm_action.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstock_order_wallet_action_state.g.dart';

/// BstockOrderWalletActionState
///
/// Properties:
/// * [kind] 
/// * [nextAction] 
/// * [walletActionBlocker] - Must be null when `next_action` is present; enforced by server validation.
@BuiltValue()
abstract class BstockOrderWalletActionState implements Built<BstockOrderWalletActionState, BstockOrderWalletActionStateBuilder> {
  @BuiltValueField(wireName: r'kind')
  BstockOrderWalletActionStateKindEnum get kind;
  // enum kindEnum {  bstock,  };

  @BuiltValueField(wireName: r'next_action')
  OrderEvmAction? get nextAction;

  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueField(wireName: r'wallet_action_blocker')
  BstockOrderWalletActionStateWalletActionBlockerEnum? get walletActionBlocker;
  // enum walletActionBlockerEnum {  provider_unavailable,  action_not_ready,  capability_disabled,  };

  BstockOrderWalletActionState._();

  factory BstockOrderWalletActionState([void updates(BstockOrderWalletActionStateBuilder b)]) = _$BstockOrderWalletActionState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstockOrderWalletActionStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstockOrderWalletActionState> get serializer => _$BstockOrderWalletActionStateSerializer();
}

class _$BstockOrderWalletActionStateSerializer implements PrimitiveSerializer<BstockOrderWalletActionState> {
  @override
  final Iterable<Type> types = const [BstockOrderWalletActionState, _$BstockOrderWalletActionState];

  @override
  final String wireName = r'BstockOrderWalletActionState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstockOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'kind';
    yield serializers.serialize(
      object.kind,
      specifiedType: const FullType(BstockOrderWalletActionStateKindEnum),
    );
    yield r'next_action';
    yield object.nextAction == null ? null : serializers.serialize(
      object.nextAction,
      specifiedType: const FullType.nullable(OrderEvmAction),
    );
    yield r'wallet_action_blocker';
    yield object.walletActionBlocker == null ? null : serializers.serialize(
      object.walletActionBlocker,
      specifiedType: const FullType.nullable(BstockOrderWalletActionStateWalletActionBlockerEnum),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstockOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstockOrderWalletActionStateBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'kind':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstockOrderWalletActionStateKindEnum),
          ) as BstockOrderWalletActionStateKindEnum;
          result.kind = valueDes;
          break;
        case r'next_action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderEvmAction),
          ) as OrderEvmAction?;
          if (valueDes == null) continue;
          result.nextAction.replace(valueDes);
          break;
        case r'wallet_action_blocker':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(BstockOrderWalletActionStateWalletActionBlockerEnum),
          ) as BstockOrderWalletActionStateWalletActionBlockerEnum?;
          if (valueDes == null) continue;
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
  BstockOrderWalletActionState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstockOrderWalletActionStateBuilder();
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

class BstockOrderWalletActionStateKindEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'bstock')
  static const BstockOrderWalletActionStateKindEnum bstock = _$bstockOrderWalletActionStateKindEnum_bstock;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderWalletActionStateKindEnum unknownDefaultOpenApi = _$bstockOrderWalletActionStateKindEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderWalletActionStateKindEnum> get serializer => _$bstockOrderWalletActionStateKindEnumSerializer;

  const BstockOrderWalletActionStateKindEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateKindEnum> get values => _$bstockOrderWalletActionStateKindEnumValues;
  static BstockOrderWalletActionStateKindEnum valueOf(String name) => _$bstockOrderWalletActionStateKindEnumValueOf(name);
}

class BstockOrderWalletActionStateWalletActionBlockerEnum extends EnumClass {

  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueEnumConst(wireName: r'provider_unavailable')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum providerUnavailable = _$bstockOrderWalletActionStateWalletActionBlockerEnum_providerUnavailable;
  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueEnumConst(wireName: r'action_not_ready')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum actionNotReady = _$bstockOrderWalletActionStateWalletActionBlockerEnum_actionNotReady;
  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueEnumConst(wireName: r'capability_disabled')
  static const BstockOrderWalletActionStateWalletActionBlockerEnum capabilityDisabled = _$bstockOrderWalletActionStateWalletActionBlockerEnum_capabilityDisabled;
  /// Must be null when `next_action` is present; enforced by server validation.
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstockOrderWalletActionStateWalletActionBlockerEnum unknownDefaultOpenApi = _$bstockOrderWalletActionStateWalletActionBlockerEnum_unknownDefaultOpenApi;

  static Serializer<BstockOrderWalletActionStateWalletActionBlockerEnum> get serializer => _$bstockOrderWalletActionStateWalletActionBlockerEnumSerializer;

  const BstockOrderWalletActionStateWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<BstockOrderWalletActionStateWalletActionBlockerEnum> get values => _$bstockOrderWalletActionStateWalletActionBlockerEnumValues;
  static BstockOrderWalletActionStateWalletActionBlockerEnum valueOf(String name) => _$bstockOrderWalletActionStateWalletActionBlockerEnumValueOf(name);
}

