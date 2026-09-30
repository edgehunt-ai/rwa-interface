//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_cross_liquidation_risk.dart';
import 'package:rwa_api_client/src/model/portfolio_open_order_margin_estimate.dart';
import 'package:rwa_api_client/src/model/portfolio_allocation_value.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_account_allocation_breakdown.g.dart';

/// 可选的展开分组。字段取决于父项 account；尚不可计算的独立分组可省略或返回 null。
///
/// Properties:
/// * [cash] 
/// * [bstocks] 
/// * [crossMarginUsedUsd] - 所有 HIP-3 Cross 仓位 position.marginUsed 之和。
/// * [isolatedMarginUsedUsd] - 所有 HIP-3 Isolated 仓位 position.marginUsed 之和。
/// * [openOrderMarginEstimate] 
/// * [estimatedWithdrawableUsd] - 估算可转出金额：当前 HL 维持保证金后可用抵押额度减去未成交开仓单保证金估算值，最低为0。 挂单保证金使用剩余数量、挂单价格及当前杠杆估算；HL 不提供逐单保证金字段，故不得作为转账承诺。 
/// * [crossLiquidationRisk] 
@BuiltValue()
abstract class PortfolioAccountAllocationBreakdown implements Built<PortfolioAccountAllocationBreakdown, PortfolioAccountAllocationBreakdownBuilder> {
  @BuiltValueField(wireName: r'cash')
  PortfolioAllocationValue? get cash;

  @BuiltValueField(wireName: r'bstocks')
  PortfolioAllocationValue? get bstocks;

  /// 所有 HIP-3 Cross 仓位 position.marginUsed 之和。
  @BuiltValueField(wireName: r'cross_margin_used_usd')
  String? get crossMarginUsedUsd;

  /// 所有 HIP-3 Isolated 仓位 position.marginUsed 之和。
  @BuiltValueField(wireName: r'isolated_margin_used_usd')
  String? get isolatedMarginUsedUsd;

  @BuiltValueField(wireName: r'open_order_margin_estimate')
  PortfolioOpenOrderMarginEstimate? get openOrderMarginEstimate;

  /// 估算可转出金额：当前 HL 维持保证金后可用抵押额度减去未成交开仓单保证金估算值，最低为0。 挂单保证金使用剩余数量、挂单价格及当前杠杆估算；HL 不提供逐单保证金字段，故不得作为转账承诺。 
  @BuiltValueField(wireName: r'estimated_withdrawable_usd')
  String? get estimatedWithdrawableUsd;

  @BuiltValueField(wireName: r'cross_liquidation_risk')
  PortfolioCrossLiquidationRisk? get crossLiquidationRisk;

  PortfolioAccountAllocationBreakdown._();

  factory PortfolioAccountAllocationBreakdown([void updates(PortfolioAccountAllocationBreakdownBuilder b)]) = _$PortfolioAccountAllocationBreakdown;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAccountAllocationBreakdownBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAccountAllocationBreakdown> get serializer => _$PortfolioAccountAllocationBreakdownSerializer();
}

class _$PortfolioAccountAllocationBreakdownSerializer implements PrimitiveSerializer<PortfolioAccountAllocationBreakdown> {
  @override
  final Iterable<Type> types = const [PortfolioAccountAllocationBreakdown, _$PortfolioAccountAllocationBreakdown];

  @override
  final String wireName = r'PortfolioAccountAllocationBreakdown';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioAccountAllocationBreakdown object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.cash != null) {
      yield r'cash';
      yield serializers.serialize(
        object.cash,
        specifiedType: const FullType(PortfolioAllocationValue),
      );
    }
    if (object.bstocks != null) {
      yield r'bstocks';
      yield serializers.serialize(
        object.bstocks,
        specifiedType: const FullType(PortfolioAllocationValue),
      );
    }
    if (object.crossMarginUsedUsd != null) {
      yield r'cross_margin_used_usd';
      yield serializers.serialize(
        object.crossMarginUsedUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.isolatedMarginUsedUsd != null) {
      yield r'isolated_margin_used_usd';
      yield serializers.serialize(
        object.isolatedMarginUsedUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.openOrderMarginEstimate != null) {
      yield r'open_order_margin_estimate';
      yield serializers.serialize(
        object.openOrderMarginEstimate,
        specifiedType: const FullType(PortfolioOpenOrderMarginEstimate),
      );
    }
    if (object.estimatedWithdrawableUsd != null) {
      yield r'estimated_withdrawable_usd';
      yield serializers.serialize(
        object.estimatedWithdrawableUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.crossLiquidationRisk != null) {
      yield r'cross_liquidation_risk';
      yield serializers.serialize(
        object.crossLiquidationRisk,
        specifiedType: const FullType(PortfolioCrossLiquidationRisk),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAccountAllocationBreakdown object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioAccountAllocationBreakdownBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'cash':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioAllocationValue),
          ) as PortfolioAllocationValue?;
          if (valueDes == null) continue;
          result.cash.replace(valueDes);
          break;
        case r'bstocks':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioAllocationValue),
          ) as PortfolioAllocationValue?;
          if (valueDes == null) continue;
          result.bstocks.replace(valueDes);
          break;
        case r'cross_margin_used_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.crossMarginUsedUsd = valueDes;
          break;
        case r'isolated_margin_used_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.isolatedMarginUsedUsd = valueDes;
          break;
        case r'open_order_margin_estimate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioOpenOrderMarginEstimate),
          ) as PortfolioOpenOrderMarginEstimate?;
          if (valueDes == null) continue;
          result.openOrderMarginEstimate.replace(valueDes);
          break;
        case r'estimated_withdrawable_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.estimatedWithdrawableUsd = valueDes;
          break;
        case r'cross_liquidation_risk':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioCrossLiquidationRisk),
          ) as PortfolioCrossLiquidationRisk?;
          if (valueDes == null) continue;
          result.crossLiquidationRisk.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioAccountAllocationBreakdown deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioAccountAllocationBreakdownBuilder();
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

