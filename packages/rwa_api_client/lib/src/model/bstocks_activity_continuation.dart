//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/bstocks_signature_continuation.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/bstocks_preview_continuation.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'bstocks_activity_continuation.g.dart';

/// BstocksActivityContinuation
///
/// Properties:
/// * [action] 
/// * [orderId] - 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
/// * [actionId] 
/// * [step] 
/// * [requiresNewBusinessObject] 
@BuiltValue()
abstract class BstocksActivityContinuation implements Built<BstocksActivityContinuation, BstocksActivityContinuationBuilder> {
  /// One Of [BstocksPreviewContinuation], [BstocksSignatureContinuation]
  OneOf get oneOf;

  static const String discriminatorFieldName = r'action';

  static const Map<String, Type> discriminatorMapping = {
    r'preview_bstocks_order': BstocksPreviewContinuation,
    r'submit_bstocks_action': BstocksSignatureContinuation,
  };

  BstocksActivityContinuation._();

  factory BstocksActivityContinuation([void updates(BstocksActivityContinuationBuilder b)]) = _$BstocksActivityContinuation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksActivityContinuationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksActivityContinuation> get serializer => _$BstocksActivityContinuationSerializer();
}

extension BstocksActivityContinuationDiscriminatorExt on BstocksActivityContinuation {
    String? get discriminatorValue {
        if (this is BstocksPreviewContinuation) {
            return r'preview_bstocks_order';
        }
        if (this is BstocksSignatureContinuation) {
            return r'submit_bstocks_action';
        }
        return null;
    }
}
extension BstocksActivityContinuationBuilderDiscriminatorExt on BstocksActivityContinuationBuilder {
    String? get discriminatorValue {
        if (this is BstocksPreviewContinuationBuilder) {
            return r'preview_bstocks_order';
        }
        if (this is BstocksSignatureContinuationBuilder) {
            return r'submit_bstocks_action';
        }
        return null;
    }
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
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksActivityContinuation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  BstocksActivityContinuation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksActivityContinuationBuilder();
    Object? oneOfDataSrc;
    final serializedList = (serialized as Iterable<Object?>).toList();
    final discIndex = serializedList.indexOf(BstocksActivityContinuation.discriminatorFieldName) + 1;
    final discValue = serializers.deserialize(serializedList[discIndex], specifiedType: FullType(String)) as String;
    oneOfDataSrc = serialized;
    final oneOfTypes = [BstocksPreviewContinuation, BstocksSignatureContinuation, ];
    Object oneOfResult;
    Type oneOfType;
    switch (discValue) {
      case r'preview_bstocks_order':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BstocksPreviewContinuation),
        ) as BstocksPreviewContinuation;
        oneOfType = BstocksPreviewContinuation;
        break;
      case r'submit_bstocks_action':
        oneOfResult = serializers.deserialize(
          oneOfDataSrc,
          specifiedType: FullType(BstocksSignatureContinuation),
        ) as BstocksSignatureContinuation;
        oneOfType = BstocksSignatureContinuation;
        break;
      default:
        throw UnsupportedError("Couldn't deserialize oneOf for the discriminator value: ${discValue}");
    }
    result.oneOf = OneOfDynamic(typeIndex: oneOfTypes.indexOf(oneOfType), types: oneOfTypes, value: oneOfResult);
    return result.build();
  }
}

class BstocksActivityContinuationActionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'preview_bstocks_order')
  static const BstocksActivityContinuationActionEnum previewBstocksOrder = _$bstocksActivityContinuationActionEnum_previewBstocksOrder;

  static Serializer<BstocksActivityContinuationActionEnum> get serializer => _$bstocksActivityContinuationActionEnumSerializer;

  const BstocksActivityContinuationActionEnum._(String name): super(name);

  static BuiltSet<BstocksActivityContinuationActionEnum> get values => _$bstocksActivityContinuationActionEnumValues;
  static BstocksActivityContinuationActionEnum valueOf(String name) => _$bstocksActivityContinuationActionEnumValueOf(name);
}

class BstocksActivityContinuationStepEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'order_preview')
  static const BstocksActivityContinuationStepEnum orderPreview = _$bstocksActivityContinuationStepEnum_orderPreview;

  static Serializer<BstocksActivityContinuationStepEnum> get serializer => _$bstocksActivityContinuationStepEnumSerializer;

  const BstocksActivityContinuationStepEnum._(String name): super(name);

  static BuiltSet<BstocksActivityContinuationStepEnum> get values => _$bstocksActivityContinuationStepEnumValues;
  static BstocksActivityContinuationStepEnum valueOf(String name) => _$bstocksActivityContinuationStepEnumValueOf(name);
}

