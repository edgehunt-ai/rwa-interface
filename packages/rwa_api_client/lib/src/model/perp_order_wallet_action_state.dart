//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_time_in_force.dart';
import 'package:rwa_api_client/src/model/order_status.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'perp_order_wallet_action_state.g.dart';

/// PerpOrderWalletActionState
///
/// Properties:
/// * [orderId] 
/// * [timeInForce] 
/// * [status] 
/// * [quantity] - 十进制字符串，避免浮点误差
/// * [kind] 
/// * [nextAction] 
/// * [walletActionBlocker] 
@BuiltValue(instantiable: false)
abstract class PerpOrderWalletActionState  {
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'time_in_force')
  Hip3TimeInForce? get timeInForce;
  // enum timeInForceEnum {  gtc,  ioc,  alo,  };

  @BuiltValueField(wireName: r'status')
  OrderStatus get status;
  // enum statusEnum {  pending_signature,  submitted,  open,  partially_filled,  filled,  cancelled,  failed,  ambiguous,  manual_review,  };

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  @BuiltValueField(wireName: r'kind')
  PerpOrderWalletActionStateKindEnum get kind;
  // enum kindEnum {  perp,  };

  @BuiltValueField(wireName: r'next_action')
  JsonObject? get nextAction;

  @BuiltValueField(wireName: r'wallet_action_blocker')
  PerpOrderWalletActionStateWalletActionBlockerEnum get walletActionBlocker;
  // enum walletActionBlockerEnum {  not_applicable,  };

  @BuiltValueSerializer(custom: true)
  static Serializer<PerpOrderWalletActionState> get serializer => _$PerpOrderWalletActionStateSerializer();
}

class _$PerpOrderWalletActionStateSerializer implements PrimitiveSerializer<PerpOrderWalletActionState> {
  @override
  final Iterable<Type> types = const [PerpOrderWalletActionState];

  @override
  final String wireName = r'PerpOrderWalletActionState';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PerpOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    if (object.timeInForce != null) {
      yield r'time_in_force';
      yield serializers.serialize(
        object.timeInForce,
        specifiedType: const FullType(Hip3TimeInForce),
      );
    }
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(OrderStatus),
    );
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType(String),
      );
    }
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

  @override
  PerpOrderWalletActionState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.deserialize(serialized, specifiedType: FullType($PerpOrderWalletActionState)) as $PerpOrderWalletActionState;
  }
}

/// a concrete implementation of [PerpOrderWalletActionState], since [PerpOrderWalletActionState] is not instantiable
@BuiltValue(instantiable: true)
abstract class $PerpOrderWalletActionState implements PerpOrderWalletActionState, Built<$PerpOrderWalletActionState, $PerpOrderWalletActionStateBuilder> {
  $PerpOrderWalletActionState._();

  factory $PerpOrderWalletActionState([void Function($PerpOrderWalletActionStateBuilder)? updates]) = _$$PerpOrderWalletActionState;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults($PerpOrderWalletActionStateBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<$PerpOrderWalletActionState> get serializer => _$$PerpOrderWalletActionStateSerializer();
}

class _$$PerpOrderWalletActionStateSerializer implements PrimitiveSerializer<$PerpOrderWalletActionState> {
  @override
  final Iterable<Type> types = const [$PerpOrderWalletActionState, _$$PerpOrderWalletActionState];

  @override
  final String wireName = r'$PerpOrderWalletActionState';

  @override
  Object serialize(
    Serializers serializers,
    $PerpOrderWalletActionState object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return serializers.serialize(object, specifiedType: FullType(PerpOrderWalletActionState))!;
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
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'time_in_force':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Hip3TimeInForce),
          ) as Hip3TimeInForce?;
          if (valueDes == null) continue;
          result.timeInForce = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderStatus),
          ) as OrderStatus;
          result.status = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
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
  $PerpOrderWalletActionState deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = $PerpOrderWalletActionStateBuilder();
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

  static Serializer<PerpOrderWalletActionStateKindEnum> get serializer => _$perpOrderWalletActionStateKindEnumSerializer;

  const PerpOrderWalletActionStateKindEnum._(String name): super(name);

  static BuiltSet<PerpOrderWalletActionStateKindEnum> get values => _$perpOrderWalletActionStateKindEnumValues;
  static PerpOrderWalletActionStateKindEnum valueOf(String name) => _$perpOrderWalletActionStateKindEnumValueOf(name);
}

class PerpOrderWalletActionStateWalletActionBlockerEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'not_applicable')
  static const PerpOrderWalletActionStateWalletActionBlockerEnum notApplicable = _$perpOrderWalletActionStateWalletActionBlockerEnum_notApplicable;

  static Serializer<PerpOrderWalletActionStateWalletActionBlockerEnum> get serializer => _$perpOrderWalletActionStateWalletActionBlockerEnumSerializer;

  const PerpOrderWalletActionStateWalletActionBlockerEnum._(String name): super(name);

  static BuiltSet<PerpOrderWalletActionStateWalletActionBlockerEnum> get values => _$perpOrderWalletActionStateWalletActionBlockerEnumValues;
  static PerpOrderWalletActionStateWalletActionBlockerEnum valueOf(String name) => _$perpOrderWalletActionStateWalletActionBlockerEnumValueOf(name);
}

