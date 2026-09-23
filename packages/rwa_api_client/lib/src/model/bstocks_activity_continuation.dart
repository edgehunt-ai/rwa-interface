//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_activity_continuation.g.dart';

/// BstocksActivityContinuation
///
/// Properties:
/// * [action] 
/// * [actionId] - 已存在的 durable bStocks action ID；继续操作不得创建新的业务对象。
/// * [step] 
/// * [requiresNewBusinessObject] 
@BuiltValue()
abstract class BstocksActivityContinuation implements Built<BstocksActivityContinuation, BstocksActivityContinuationBuilder> {
  @BuiltValueField(wireName: r'action')
  BstocksActivityContinuationActionEnum get action;
  // enum actionEnum {  submit_bstocks_action,  };

  /// 已存在的 durable bStocks action ID；继续操作不得创建新的业务对象。
  @BuiltValueField(wireName: r'action_id')
  String get actionId;

  @BuiltValueField(wireName: r'step')
  BstocksActivityContinuationStepEnum get step;
  // enum stepEnum {  wallet_signature,  };

  @BuiltValueField(wireName: r'requires_new_business_object')
  bool get requiresNewBusinessObject;

  BstocksActivityContinuation._();

  factory BstocksActivityContinuation([void updates(BstocksActivityContinuationBuilder b)]) = _$BstocksActivityContinuation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksActivityContinuationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksActivityContinuation> get serializer => _$BstocksActivityContinuationSerializer();
}

class _$BstocksActivityContinuationSerializer implements PrimitiveSerializer<BstocksActivityContinuation> {
  @override
  final Iterable<Type> types = const [BstocksActivityContinuation, _$BstocksActivityContinuation];

  @override
  final String wireName = r'BstocksActivityContinuation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksActivityContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(BstocksActivityContinuationActionEnum),
    );
    yield r'action_id';
    yield serializers.serialize(
      object.actionId,
      specifiedType: const FullType(String),
    );
    yield r'step';
    yield serializers.serialize(
      object.step,
      specifiedType: const FullType(BstocksActivityContinuationStepEnum),
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
    BstocksActivityContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksActivityContinuationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksActivityContinuationActionEnum),
          ) as BstocksActivityContinuationActionEnum;
          result.action = valueDes;
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
            specifiedType: const FullType(BstocksActivityContinuationStepEnum),
          ) as BstocksActivityContinuationStepEnum;
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
  BstocksActivityContinuation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksActivityContinuationBuilder();
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

class BstocksActivityContinuationActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'submit_bstocks_action')
  static const BstocksActivityContinuationActionEnum submitBstocksAction = _$bstocksActivityContinuationActionEnum_submitBstocksAction;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksActivityContinuationActionEnum unknownDefaultOpenApi = _$bstocksActivityContinuationActionEnum_unknownDefaultOpenApi;

  static Serializer<BstocksActivityContinuationActionEnum> get serializer => _$bstocksActivityContinuationActionEnumSerializer;

  const BstocksActivityContinuationActionEnum._(String name): super(name);

  static BuiltSet<BstocksActivityContinuationActionEnum> get values => _$bstocksActivityContinuationActionEnumValues;
  static BstocksActivityContinuationActionEnum valueOf(String name) => _$bstocksActivityContinuationActionEnumValueOf(name);
}

class BstocksActivityContinuationStepEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'wallet_signature')
  static const BstocksActivityContinuationStepEnum walletSignature = _$bstocksActivityContinuationStepEnum_walletSignature;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const BstocksActivityContinuationStepEnum unknownDefaultOpenApi = _$bstocksActivityContinuationStepEnum_unknownDefaultOpenApi;

  static Serializer<BstocksActivityContinuationStepEnum> get serializer => _$bstocksActivityContinuationStepEnumSerializer;

  const BstocksActivityContinuationStepEnum._(String name): super(name);

  static BuiltSet<BstocksActivityContinuationStepEnum> get values => _$bstocksActivityContinuationStepEnumValues;
  static BstocksActivityContinuationStepEnum valueOf(String name) => _$bstocksActivityContinuationStepEnumValueOf(name);
}

