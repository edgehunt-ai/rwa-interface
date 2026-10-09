//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_preview.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'bstocks_order_continuation_preview.g.dart';

/// 新冻结预览只能继续其绑定的原订单；不能用于创建另一张订单。
///
/// Properties:
/// * [boundOrderId] - 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
/// * [preview] 
@BuiltValue()
abstract class BstocksOrderContinuationPreview implements Built<BstocksOrderContinuationPreview, BstocksOrderContinuationPreviewBuilder> {
  /// 创建时分配、整个生命周期不变的业务订单标识；不是 action UUID、链上订单号或交易哈希。
  @BuiltValueField(wireName: r'bound_order_id')
  String get boundOrderId;

  @BuiltValueField(wireName: r'preview')
  OrderPreview get preview;

  BstocksOrderContinuationPreview._();

  factory BstocksOrderContinuationPreview([void updates(BstocksOrderContinuationPreviewBuilder b)]) = _$BstocksOrderContinuationPreview;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(BstocksOrderContinuationPreviewBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<BstocksOrderContinuationPreview> get serializer => _$BstocksOrderContinuationPreviewSerializer();
}

class _$BstocksOrderContinuationPreviewSerializer implements PrimitiveSerializer<BstocksOrderContinuationPreview> {
  @override
  final Iterable<Type> types = const [BstocksOrderContinuationPreview, _$BstocksOrderContinuationPreview];

  @override
  final String wireName = r'BstocksOrderContinuationPreview';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    BstocksOrderContinuationPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'bound_order_id';
    yield serializers.serialize(
      object.boundOrderId,
      specifiedType: const FullType(String),
    );
    yield r'preview';
    yield serializers.serialize(
      object.preview,
      specifiedType: const FullType(OrderPreview),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    BstocksOrderContinuationPreview object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required BstocksOrderContinuationPreviewBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'bound_order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.boundOrderId = valueDes;
          break;
        case r'preview':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(OrderPreview),
          ) as OrderPreview;
          result.preview.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  BstocksOrderContinuationPreview deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = BstocksOrderContinuationPreviewBuilder();
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

