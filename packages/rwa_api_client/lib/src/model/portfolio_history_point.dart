//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_history_point.g.dart';

/// PortfolioHistoryPoint
///
/// Properties:
/// * [timestamp] 
/// * [totalValueUsd] - 该采样点已成功估值且去重后的资产 subtotal。
/// * [netExternalCashFlowUsd] - 从本响应 baseline（不含 baseline 时刻）到该点（含该点时刻）的已确认外部净现金流： confirmed deposits minus confirmed withdrawals。现金流证据完整时 baseline 点必须为 `0`； 证据缺失时必须为 `null`，同时 `pnl_usd` / `pnl_percent` 也必须为 `null`，不能编造零值。 pending observation、hold、内部账户转移和未独立核验的交易不能进入该值。 
/// * [pnlUsd] - Range-to-date cash-flow-adjusted PnL. For every returned point the exact formula is `point NAV - baseline NAV - net external cash flow`, where baseline is the first returned point and net external cash flow is the difference between cumulative confirmed external deposits minus withdrawals at this point and at the baseline. The baseline point is `0`. Missing baseline, valuation, or confirmed cash-flow evidence makes this field null; it must never be fabricated as zero. 
/// * [pnlPercent] - Exact `pnl_usd / baseline NAV * 100` for this range. It is null when `pnl_usd` is null, baseline NAV is zero, or the baseline/valuation/cash-flow evidence is incomplete; clients must not derive it from partial values. 
@BuiltValue()
abstract class PortfolioHistoryPoint implements Built<PortfolioHistoryPoint, PortfolioHistoryPointBuilder> {
  @BuiltValueField(wireName: r'timestamp')
  DateTime get timestamp;

  /// 该采样点已成功估值且去重后的资产 subtotal。
  @BuiltValueField(wireName: r'total_value_usd')
  String get totalValueUsd;

  /// 从本响应 baseline（不含 baseline 时刻）到该点（含该点时刻）的已确认外部净现金流： confirmed deposits minus confirmed withdrawals。现金流证据完整时 baseline 点必须为 `0`； 证据缺失时必须为 `null`，同时 `pnl_usd` / `pnl_percent` 也必须为 `null`，不能编造零值。 pending observation、hold、内部账户转移和未独立核验的交易不能进入该值。 
  @BuiltValueField(wireName: r'net_external_cash_flow_usd')
  String? get netExternalCashFlowUsd;

  /// Range-to-date cash-flow-adjusted PnL. For every returned point the exact formula is `point NAV - baseline NAV - net external cash flow`, where baseline is the first returned point and net external cash flow is the difference between cumulative confirmed external deposits minus withdrawals at this point and at the baseline. The baseline point is `0`. Missing baseline, valuation, or confirmed cash-flow evidence makes this field null; it must never be fabricated as zero. 
  @BuiltValueField(wireName: r'pnl_usd')
  String? get pnlUsd;

  /// Exact `pnl_usd / baseline NAV * 100` for this range. It is null when `pnl_usd` is null, baseline NAV is zero, or the baseline/valuation/cash-flow evidence is incomplete; clients must not derive it from partial values. 
  @BuiltValueField(wireName: r'pnl_percent')
  String? get pnlPercent;

  PortfolioHistoryPoint._();

  factory PortfolioHistoryPoint([void updates(PortfolioHistoryPointBuilder b)]) = _$PortfolioHistoryPoint;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioHistoryPointBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioHistoryPoint> get serializer => _$PortfolioHistoryPointSerializer();
}

class _$PortfolioHistoryPointSerializer implements PrimitiveSerializer<PortfolioHistoryPoint> {
  @override
  final Iterable<Type> types = const [PortfolioHistoryPoint, _$PortfolioHistoryPoint];

  @override
  final String wireName = r'PortfolioHistoryPoint';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioHistoryPoint object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'timestamp';
    yield serializers.serialize(
      object.timestamp,
      specifiedType: const FullType(DateTime),
    );
    yield r'total_value_usd';
    yield serializers.serialize(
      object.totalValueUsd,
      specifiedType: const FullType(String),
    );
    yield r'net_external_cash_flow_usd';
    yield object.netExternalCashFlowUsd == null ? null : serializers.serialize(
      object.netExternalCashFlowUsd,
      specifiedType: const FullType.nullable(String),
    );
    yield r'pnl_usd';
    yield object.pnlUsd == null ? null : serializers.serialize(
      object.pnlUsd,
      specifiedType: const FullType.nullable(String),
    );
    yield r'pnl_percent';
    yield object.pnlPercent == null ? null : serializers.serialize(
      object.pnlPercent,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioHistoryPoint object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioHistoryPointBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'timestamp':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.timestamp = valueDes;
          break;
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalValueUsd = valueDes;
          break;
        case r'net_external_cash_flow_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.netExternalCashFlowUsd = valueDes;
          break;
        case r'pnl_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pnlUsd = valueDes;
          break;
        case r'pnl_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pnlPercent = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioHistoryPoint deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioHistoryPointBuilder();
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

