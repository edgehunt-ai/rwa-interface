//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_holding_return.g.dart';

/// bStocks 剩余持仓的未实现参考收益，沿用持仓接口 reference_only 口径。 以 canonical Router 成交与 ERC20 Transfer 证据计算 FIFO 剩余成本；部分卖出消耗最早买入批次， 买入成本包含已成交的 quote-token 支出，不额外计入原生 Gas。 无法确定成本的外部转入/转出、历史覆盖不足、链重组、剩余数量与余额不符、 估值缺失/stale、查询失败或超时均保留未知，不从现价推测成本。 测试网 TUSDT 仅以相同市场参考单位展示，不代表测试币美元锚定或实际结算收益。 
///
/// Properties:
/// * [amountUsd] - 参考市值减FIFO剩余参考成本；盈利为正、亏损为负，证据完整且盈亏平衡才返回0。未知为null。
/// * [percent] - (参考市值 - FIFO剩余参考成本) / FIFO剩余参考成本 × 100；25表示25%，不是0.25。 18位小数half-even舍入。成本未知/为零、估值缺失/stale或数值越界时为null。 
@BuiltValue()
abstract class PortfolioHoldingReturn implements Built<PortfolioHoldingReturn, PortfolioHoldingReturnBuilder> {
  /// 参考市值减FIFO剩余参考成本；盈利为正、亏损为负，证据完整且盈亏平衡才返回0。未知为null。
  @BuiltValueField(wireName: r'amount_usd')
  String? get amountUsd;

  /// (参考市值 - FIFO剩余参考成本) / FIFO剩余参考成本 × 100；25表示25%，不是0.25。 18位小数half-even舍入。成本未知/为零、估值缺失/stale或数值越界时为null。 
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

