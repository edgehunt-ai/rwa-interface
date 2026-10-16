//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/hip3_conditional_order.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_opening_protection_order.g.dart';

/// Hip3OpeningProtectionOrder
///
/// Properties:
/// * [orderId] - 保护子单 ID，可通过订单详情接口查询。
/// * [limitPrice] - 子单为 limit 执行时的冻结执行价格；market 执行时为空。
/// * [conditional] 
@BuiltValue()
abstract class Hip3OpeningProtectionOrder implements Built<Hip3OpeningProtectionOrder, Hip3OpeningProtectionOrderBuilder> {
  /// 保护子单 ID，可通过订单详情接口查询。
  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  /// 子单为 limit 执行时的冻结执行价格；market 执行时为空。
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  @BuiltValueField(wireName: r'conditional')
  Hip3ConditionalOrder get conditional;

  Hip3OpeningProtectionOrder._();

  factory Hip3OpeningProtectionOrder([void updates(Hip3OpeningProtectionOrderBuilder b)]) = _$Hip3OpeningProtectionOrder;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3OpeningProtectionOrderBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3OpeningProtectionOrder> get serializer => _$Hip3OpeningProtectionOrderSerializer();
}

class _$Hip3OpeningProtectionOrderSerializer implements PrimitiveSerializer<Hip3OpeningProtectionOrder> {
  @override
  final Iterable<Type> types = const [Hip3OpeningProtectionOrder, _$Hip3OpeningProtectionOrder];

  @override
  final String wireName = r'Hip3OpeningProtectionOrder';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3OpeningProtectionOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'conditional';
    yield serializers.serialize(
      object.conditional,
      specifiedType: const FullType(Hip3ConditionalOrder),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3OpeningProtectionOrder object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3OpeningProtectionOrderBuilder result,
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
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'conditional':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3ConditionalOrder),
          ) as Hip3ConditionalOrder;
          result.conditional.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3OpeningProtectionOrder deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3OpeningProtectionOrderBuilder();
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

