//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tp_sl_update_request.g.dart';

/// TpSlUpdateRequest
///
/// Properties:
/// * [takeProfitPrice] - 十进制字符串，避免浮点误差
/// * [stopLossPrice] - 十进制字符串，避免浮点误差
/// * [stopLimitPrice] - 十进制字符串，避免浮点误差
/// * [stopLimitPercent] - 与 `stop_limit_price` 互算，二者传其一即可
@BuiltValue()
abstract class TpSlUpdateRequest
    implements Built<TpSlUpdateRequest, TpSlUpdateRequestBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'take_profit_price')
  String? get takeProfitPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'stop_loss_price')
  String? get stopLossPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'stop_limit_price')
  String? get stopLimitPrice;

  /// 与 `stop_limit_price` 互算，二者传其一即可
  @BuiltValueField(wireName: r'stop_limit_percent')
  String? get stopLimitPercent;

  TpSlUpdateRequest._();

  factory TpSlUpdateRequest([void updates(TpSlUpdateRequestBuilder b)]) =
      _$TpSlUpdateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TpSlUpdateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TpSlUpdateRequest> get serializer =>
      _$TpSlUpdateRequestSerializer();
}

class _$TpSlUpdateRequestSerializer
    implements PrimitiveSerializer<TpSlUpdateRequest> {
  @override
  final Iterable<Type> types = const [TpSlUpdateRequest, _$TpSlUpdateRequest];

  @override
  final String wireName = r'TpSlUpdateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TpSlUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.takeProfitPrice != null) {
      yield r'take_profit_price';
      yield serializers.serialize(
        object.takeProfitPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.stopLossPrice != null) {
      yield r'stop_loss_price';
      yield serializers.serialize(
        object.stopLossPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.stopLimitPrice != null) {
      yield r'stop_limit_price';
      yield serializers.serialize(
        object.stopLimitPrice,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.stopLimitPercent != null) {
      yield r'stop_limit_percent';
      yield serializers.serialize(
        object.stopLimitPercent,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TpSlUpdateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TpSlUpdateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'take_profit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.takeProfitPrice = valueDes;
          break;
        case r'stop_loss_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.stopLossPrice = valueDes;
          break;
        case r'stop_limit_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.stopLimitPrice = valueDes;
          break;
        case r'stop_limit_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.stopLimitPercent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TpSlUpdateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TpSlUpdateRequestBuilder();
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
