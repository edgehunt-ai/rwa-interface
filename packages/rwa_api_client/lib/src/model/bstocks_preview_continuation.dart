//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_preview_continuation.g.dart';

/// BstocksPreviewContinuation
///
/// Properties:
/// * [action] 
/// * [orderId] - 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
/// * [step] 
/// * [requiresNewBusinessObject] 
@BuiltValue()
abstract class BstocksPreviewContinuation implements Built<BstocksPreviewContinuation, BstocksPreviewContinuationBuilder> {
  @BuiltValueField(wireName: r'action')
  BstocksPreviewContinuationActionEnum get action;
  // enum actionEnum {  preview_bstocks_order,  };

  /// 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  @BuiltValueField(wireName: r'step')
  BstocksPreviewContinuationStepEnum get step;
  // enum stepEnum {  order_preview,  };

  @BuiltValueField(wireName: r'requires_new_business_object')
  bool get requiresNewBusinessObject;

  BstocksPreviewContinuation._();

  factory BstocksPreviewContinuation([void updates(BstocksPreviewContinuationBuilder b)]) = _$BstocksPreviewContinuation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksPreviewContinuationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksPreviewContinuation> get serializer => _$BstocksPreviewContinuationSerializer();
}

class _$BstocksPreviewContinuationSerializer implements PrimitiveSerializer<BstocksPreviewContinuation> {
  @override
  final Iterable<Type> types = const [BstocksPreviewContinuation, _$BstocksPreviewContinuation];

  @override
  final String wireName = r'BstocksPreviewContinuation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksPreviewContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'action';
    yield serializers.serialize(
      object.action,
      specifiedType: const FullType(BstocksPreviewContinuationActionEnum),
    );
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    yield r'step';
    yield serializers.serialize(
      object.step,
      specifiedType: const FullType(BstocksPreviewContinuationStepEnum),
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
    BstocksPreviewContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksPreviewContinuationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'action':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewContinuationActionEnum),
          ) as BstocksPreviewContinuationActionEnum;
          result.action = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        case r'step':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BstocksPreviewContinuationStepEnum),
          ) as BstocksPreviewContinuationStepEnum;
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
  BstocksPreviewContinuation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksPreviewContinuationBuilder();
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

class BstocksPreviewContinuationActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'preview_bstocks_order')
  static const BstocksPreviewContinuationActionEnum previewBstocksOrder = _$bstocksPreviewContinuationActionEnum_previewBstocksOrder;

  static Serializer<BstocksPreviewContinuationActionEnum> get serializer => _$bstocksPreviewContinuationActionEnumSerializer;

  const BstocksPreviewContinuationActionEnum._(String name): super(name);

  static BuiltSet<BstocksPreviewContinuationActionEnum> get values => _$bstocksPreviewContinuationActionEnumValues;
  static BstocksPreviewContinuationActionEnum valueOf(String name) => _$bstocksPreviewContinuationActionEnumValueOf(name);
}

class BstocksPreviewContinuationStepEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'order_preview')
  static const BstocksPreviewContinuationStepEnum orderPreview = _$bstocksPreviewContinuationStepEnum_orderPreview;

  static Serializer<BstocksPreviewContinuationStepEnum> get serializer => _$bstocksPreviewContinuationStepEnumSerializer;

  const BstocksPreviewContinuationStepEnum._(String name): super(name);

  static BuiltSet<BstocksPreviewContinuationStepEnum> get values => _$bstocksPreviewContinuationStepEnumValues;
  static BstocksPreviewContinuationStepEnum valueOf(String name) => _$bstocksPreviewContinuationStepEnumValueOf(name);
}

