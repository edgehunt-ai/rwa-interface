//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_signature_continuation.g.dart';

/// BstocksSignatureContinuation
///
/// Properties:
/// * [action] 
/// * [orderId] - 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
/// * [actionId] 
/// * [step] 
/// * [requiresNewBusinessObject] 
@BuiltValue()
abstract class BstocksSignatureContinuation implements Built<BstocksSignatureContinuation, BstocksSignatureContinuationBuilder> {
  @BuiltValueField(wireName: r'action')
  BstocksSignatureContinuationActionEnum get action;
  // enum actionEnum {  submit_bstocks_action,  };

  /// 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'step')
  BstocksSignatureContinuationStepEnum get step;
  // enum stepEnum {  wallet_signature,  };

  @BuiltValueField(wireName: r'requires_new_business_object')
  bool get requiresNewBusinessObject;

  BstocksSignatureContinuation._();

  factory BstocksSignatureContinuation([void updates(BstocksSignatureContinuationBuilder b)]) = _$BstocksSignatureContinuation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksSignatureContinuationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksSignatureContinuation> get serializer => _$BstocksSignatureContinuationSerializer();
}

class _$BstocksSignatureContinuationSerializer implements PrimitiveSerializer<BstocksSignatureContinuation> {
  @override
  final Iterable<Type> types = const [BstocksSignatureContinuation, _$BstocksSignatureContinuation];

  @override
  final String wireName = r'BstocksSignatureContinuation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksSignatureContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(BstocksSignatureContinuationActionEnum),
    );
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'step';
    yield serializers.serialize(
      object.step,
      specifiedType: const FullType(BstocksSignatureContinuationStepEnum),
    );
    yield r'requires_new_business_object';
    yield serializers.serialize(
      object.requiresNewBusinessObject,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksSignatureContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksSignatureContinuationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksSignatureContinuationActionEnum),
          ) as BstocksSignatureContinuationActionEnum;
          result.action = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'action_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actionId = valueDes;
          break;
        case r'step':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksSignatureContinuationStepEnum),
          ) as BstocksSignatureContinuationStepEnum;
          result.step = valueDes;
          break;
        case r'requires_new_business_object':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.requiresNewBusinessObject = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksSignatureContinuation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksSignatureContinuationBuilder();
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

class BstocksSignatureContinuationActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'submit_bstocks_action')
  static const BstocksSignatureContinuationActionEnum submitBstocksAction = _$bstocksSignatureContinuationActionEnum_submitBstocksAction;

  static Serializer<BstocksSignatureContinuationActionEnum> get serializer => _$bstocksSignatureContinuationActionEnumSerializer;

  const BstocksSignatureContinuationActionEnum._(String name): super(name);

  static BuiltSet<BstocksSignatureContinuationActionEnum> get values => _$bstocksSignatureContinuationActionEnumValues;
  static BstocksSignatureContinuationActionEnum valueOf(String name) => _$bstocksSignatureContinuationActionEnumValueOf(name);
}

class BstocksSignatureContinuationStepEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'wallet_signature')
  static const BstocksSignatureContinuationStepEnum walletSignature = _$bstocksSignatureContinuationStepEnum_walletSignature;

  static Serializer<BstocksSignatureContinuationStepEnum> get serializer => _$bstocksSignatureContinuationStepEnumSerializer;

  const BstocksSignatureContinuationStepEnum._(String name): super(name);

  static BuiltSet<BstocksSignatureContinuationStepEnum> get values => _$bstocksSignatureContinuationStepEnumValues;
  static BstocksSignatureContinuationStepEnum valueOf(String name) => _$bstocksSignatureContinuationStepEnumValueOf(name);
}

