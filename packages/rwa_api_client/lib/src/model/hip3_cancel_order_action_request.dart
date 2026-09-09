//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'hip3_cancel_order_action_request.g.dart';

/// 撤销已在交易所存在的订单或独立 TP/SL 子订单。原订单在撤单确认前仍可能成交；already_filled 等结果必须反映真实订单状态。
///
/// Properties:
/// * [operation] 
/// * [orderId] 
@BuiltValue()
abstract class Hip3CancelOrderActionRequest implements Built<Hip3CancelOrderActionRequest, Hip3CancelOrderActionRequestBuilder> {
  @BuiltValueField(wireName: r'operation')
  Hip3CancelOrderActionRequestOperationEnum get operation;
  // enum operationEnum {  cancel_order,  };

  @BuiltValueField(wireName: r'order_id')
  String get orderId;

  Hip3CancelOrderActionRequest._();

  factory Hip3CancelOrderActionRequest([void updates(Hip3CancelOrderActionRequestBuilder b)]) = _$Hip3CancelOrderActionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(Hip3CancelOrderActionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Hip3CancelOrderActionRequest> get serializer => _$Hip3CancelOrderActionRequestSerializer();
}

class _$Hip3CancelOrderActionRequestSerializer implements PrimitiveSerializer<Hip3CancelOrderActionRequest> {
  @override
  final Iterable<Type> types = const [Hip3CancelOrderActionRequest, _$Hip3CancelOrderActionRequest];

  @override
  final String wireName = r'Hip3CancelOrderActionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Hip3CancelOrderActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'operation';
    yield serializers.serialize(
      object.operation,
      specifiedType: const FullType(Hip3CancelOrderActionRequestOperationEnum),
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
    Hip3CancelOrderActionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required Hip3CancelOrderActionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'operation':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Hip3CancelOrderActionRequestOperationEnum),
          ) as Hip3CancelOrderActionRequestOperationEnum;
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
  Hip3CancelOrderActionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = Hip3CancelOrderActionRequestBuilder();
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

class Hip3CancelOrderActionRequestOperationEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'cancel_order')
  static const Hip3CancelOrderActionRequestOperationEnum cancelOrder = _$hip3CancelOrderActionRequestOperationEnum_cancelOrder;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const Hip3CancelOrderActionRequestOperationEnum unknownDefaultOpenApi = _$hip3CancelOrderActionRequestOperationEnum_unknownDefaultOpenApi;

  static Serializer<Hip3CancelOrderActionRequestOperationEnum> get serializer => _$hip3CancelOrderActionRequestOperationEnumSerializer;

  const Hip3CancelOrderActionRequestOperationEnum._(String name): super(name);

  static BuiltSet<Hip3CancelOrderActionRequestOperationEnum> get values => _$hip3CancelOrderActionRequestOperationEnumValues;
  static Hip3CancelOrderActionRequestOperationEnum valueOf(String name) => _$hip3CancelOrderActionRequestOperationEnumValueOf(name);
}

