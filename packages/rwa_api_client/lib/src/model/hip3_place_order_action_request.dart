//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_place_order_action_request.g.dart';

/// order_id 引用 POST /orders 创建并冻结的当前账户 HIP3 订单；不允许覆写委托。 后端必要时先准备杠杆步骤，再释放开仓步骤。每步使用独立冻结 nonce。 成交和后续 TP/SL 使用真实仓位及成交事实校验，不能承诺尚未提交的保护已生效。 切换前尚未提交的旧 action 明确失效，不迁移或复用旧签名。客户端取消原未提交订单后重新预览。 已提交的历史 action 保留对账事实；旧提交路由已移除，不提供兼容入口。 已提交或结果不明的订单不能通过本接口再次创建开仓动作。 
///
/// Properties:
/// * [operation] 
/// * [orderId] 
@BuiltValue()
abstract class Hip3PlaceOrderActionRequest implements Built<Hip3PlaceOrderActionRequest, Hip3PlaceOrderActionRequestBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3PlaceOrderActionRequestOperationEnum get operation;
  // enum operationEnum {  place_order,  };

  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  Hip3PlaceOrderActionRequest._();

  factory Hip3PlaceOrderActionRequest([void updates(Hip3PlaceOrderActionRequestBuilder b)]) = _$Hip3PlaceOrderActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3PlaceOrderActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3PlaceOrderActionRequest> get serializer => _$Hip3PlaceOrderActionRequestSerializer();
}

class _$Hip3PlaceOrderActionRequestSerializer implements PrimitiveSerializer<Hip3PlaceOrderActionRequest> {
  @override
  final Iterable<Type> types = const [Hip3PlaceOrderActionRequest, _$Hip3PlaceOrderActionRequest];

  @override
  final String wireName = r'Hip3PlaceOrderActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3PlaceOrderActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3PlaceOrderActionRequestOperationEnum),
    );
    yield r'order_id';
    yield serializers.serialize(
      object.orderId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Hip3PlaceOrderActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3PlaceOrderActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3PlaceOrderActionRequestOperationEnum),
          ) as Hip3PlaceOrderActionRequestOperationEnum;
          result.operation = valueDes;
          break;
        case r'order_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.orderId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Hip3PlaceOrderActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3PlaceOrderActionRequestBuilder();
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

class Hip3PlaceOrderActionRequestOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'place_order')
  static const Hip3PlaceOrderActionRequestOperationEnum placeOrder = _$hip3PlaceOrderActionRequestOperationEnum_placeOrder;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3PlaceOrderActionRequestOperationEnum unknownDefaultOpenApi = _$hip3PlaceOrderActionRequestOperationEnum_unknownDefaultOpenApi;

  static Serializer<Hip3PlaceOrderActionRequestOperationEnum> get serializer => _$hip3PlaceOrderActionRequestOperationEnumSerializer;

  const Hip3PlaceOrderActionRequestOperationEnum._(String name): super(name);

  static BuiltSet<Hip3PlaceOrderActionRequestOperationEnum> get values => _$hip3PlaceOrderActionRequestOperationEnumValues;
  static Hip3PlaceOrderActionRequestOperationEnum valueOf(String name) => _$hip3PlaceOrderActionRequestOperationEnumValueOf(name);
}

