//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_holding_return.g.dart';

/// TODO(bstocks) 后续接入有成本证据的持仓收益；当前两个字段固定为 null，禁止按现价推测成本。
///
/// Properties:
/// * [amountUsd] - 十进制字符串，避免浮点误差
/// * [percent] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class PortfolioHoldingReturn implements Built<PortfolioHoldingReturn, PortfolioHoldingReturnBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'amount_usd')
  String? get amountUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'percent')
  String? get percent;

  PortfolioHoldingReturn._();

  factory PortfolioHoldingReturn([void updates(PortfolioHoldingReturnBuilder b)]) = _$PortfolioHoldingReturn;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioHoldingReturnBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioHoldingReturn> get serializer => _$PortfolioHoldingReturnSerializer();
}

class _$PortfolioHoldingReturnSerializer implements PrimitiveSerializer<PortfolioHoldingReturn> {
  @override
  final Iterable<Type> types = const [PortfolioHoldingReturn, _$PortfolioHoldingReturn];

  @override
  final String wireName = r'PortfolioHoldingReturn';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioHoldingReturn object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'amount_usd';
    yield object.amountUsd == null ? null : serializers.serialize(
      object.amountUsd,
      specifiedType: const FullType.nullable(String),
    );
    yield r'percent';
    yield object.percent == null ? null : serializers.serialize(
      object.percent,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioHoldingReturn object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioHoldingReturnBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'amount_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.amountUsd = valueDes;
          break;
        case r'percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.percent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioHoldingReturn deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioHoldingReturnBuilder();
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

