//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'tp_sl_spec.g.dart';

/// 止盈止损。市价单只需 `stop_loss_price`（UI 上显示为 Stop Loss）；限价单额外可设 `stop_limit_price`，此时 `stop_loss_price` 对应 UI 上的 Stop Trigger Price。 Long / buy：TP 需高于入场价，SL 需低于入场价；Short / sell 反之。
///
/// Properties:
/// * [enabled]
/// * [takeProfitPrice] - 十进制字符串，避免浮点误差
/// * [stopLossPrice] - 十进制字符串，避免浮点误差
/// * [stopLimitPrice] - 仅限价单
/// * [takeProfitPercent] - 与价格互算，二者传其一即可
/// * [stopLossPercent] - 十进制字符串，避免浮点误差
/// * [stopLimitPercent] - 与 `stop_limit_price` 互算，二者传其一即可
@BuiltValue()
abstract class TpSlSpec implements Built<TpSlSpec, TpSlSpecBuilder> {
  @BuiltValueField(wireName: r'enabled')
  bool? get enabled;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'take_profit_price')
  String? get takeProfitPrice;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'stop_loss_price')
  String? get stopLossPrice;

  /// 仅限价单
  @BuiltValueField(wireName: r'stop_limit_price')
  String? get stopLimitPrice;

  /// 与价格互算，二者传其一即可
  @BuiltValueField(wireName: r'take_profit_percent')
  String? get takeProfitPercent;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'stop_loss_percent')
  String? get stopLossPercent;

  /// 与 `stop_limit_price` 互算，二者传其一即可
  @BuiltValueField(wireName: r'stop_limit_percent')
  String? get stopLimitPercent;

  TpSlSpec._();

  factory TpSlSpec([void updates(TpSlSpecBuilder b)]) = _$TpSlSpec;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TpSlSpecBuilder b) => b..enabled = false;

  @BuiltValueSerializer(custom: true)
  static Serializer<TpSlSpec> get serializer => _$TpSlSpecSerializer();
}

class _$TpSlSpecSerializer implements PrimitiveSerializer<TpSlSpec> {
  @override
  final Iterable<Type> types = const [TpSlSpec, _$TpSlSpec];

  @override
  final String wireName = r'TpSlSpec';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TpSlSpec object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.enabled != null) {
      yield r'enabled';
      yield serializers.serialize(
        object.enabled,
        specifiedType: const FullType(bool),
      );
    }
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
    if (object.takeProfitPercent != null) {
      yield r'take_profit_percent';
      yield serializers.serialize(
        object.takeProfitPercent,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.stopLossPercent != null) {
      yield r'stop_loss_percent';
      yield serializers.serialize(
        object.stopLossPercent,
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
    TpSlSpec object, {
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
    required TpSlSpecBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'enabled':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(bool),
          ) as bool?;
          if (valueDes == null) continue;
          result.enabled = valueDes;
          break;
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
        case r'take_profit_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.takeProfitPercent = valueDes;
          break;
        case r'stop_loss_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.stopLossPercent = valueDes;
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
  TpSlSpec deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TpSlSpecBuilder();
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
