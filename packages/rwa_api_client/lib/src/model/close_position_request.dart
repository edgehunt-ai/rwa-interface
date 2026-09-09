//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/order_type.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'close_position_request.g.dart';

/// ClosePositionRequest
///
/// Properties:
/// * [type] 
/// * [quantity] - 与 `percent` 二选一；均不传表示全部平仓
/// * [percent] - 十进制字符串，避免浮点误差
/// * [limitPrice] - 十进制字符串，避免浮点误差
/// * [slippagePercent] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class ClosePositionRequest implements Built<ClosePositionRequest, ClosePositionRequestBuilder> {
  @BuiltValueField(wireName: r'type')
  OrderType? get type;
  // enum typeEnum {  market,  limit,  };

  /// 与 `percent` 二选一；均不传表示全部平仓
  @BuiltValueField(wireName: r'quantity')
  String? get quantity;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'percent')
  String? get percent;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'limit_price')
  String? get limitPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'slippage_percent')
  String? get slippagePercent;

  ClosePositionRequest._();

  factory ClosePositionRequest([void updates(ClosePositionRequestBuilder b)]) = _$ClosePositionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ClosePositionRequestBuilder b) => b
      ..type = OrderType.market;

  @BuiltValueSerializer(custom: true)
  static Serializer<ClosePositionRequest> get serializer => _$ClosePositionRequestSerializer();
}

class _$ClosePositionRequestSerializer implements PrimitiveSerializer<ClosePositionRequest> {
  @override
  final Iterable<Type> types = const [ClosePositionRequest, _$ClosePositionRequest];

  @override
  final String wireName = r'ClosePositionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ClosePositionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.type != null) {
      yield r'type';
      yield serializers.serialize(
        object.type,
        specifiedType: const FullType(OrderType),
      );
    }
    if (object.quantity != null) {
      yield r'quantity';
      yield serializers.serialize(
        object.quantity,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.percent != null) {
      yield r'percent';
      yield serializers.serialize(
        object.percent,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.limitPrice != null) {
      yield r'limit_price';
      yield serializers.serialize(
        object.limitPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.slippagePercent != null) {
      yield r'slippage_percent';
      yield serializers.serialize(
        object.slippagePercent,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ClosePositionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ClosePositionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(OrderType),
          ) as OrderType?;
          if (valueDes == null) continue;
          result.type = valueDes;
          break;
        case r'quantity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.quantity = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.percent = valueDes;
          break;
        case r'limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.limitPrice = valueDes;
          break;
        case r'slippage_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.slippagePercent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ClosePositionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ClosePositionRequestBuilder();
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

