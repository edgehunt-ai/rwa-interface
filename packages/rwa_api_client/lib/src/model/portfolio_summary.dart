//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:rwa_api_client/src/model/portfolio_source_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_data_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_summary.g.dart';

/// 去重后的只读资产总览；金额字段均使用 Decimal wire string。
///
/// Properties:
/// * [totalValueUsd] - 所有已成功估值且去重资产的 subtotal；未估值资产不作为零计入。 Hyperliquid Unified Account 的抵押物从 spotClearinghouseState 读取且只计一次； 不叠加各 DEX 的 accountValue、仓位名义价值或再次叠加未实现损益。 
/// * [todayPnlUsd] - 首版固定返回 null，不从不完整的缓存或历史估值推导。
/// * [todayPnlPercent] - 首版固定返回 null，不从不完整的缓存或历史估值推导。
/// * [availableToTradeUsd] - 可证明可用的余额子集；普通钱包余额不会自动等于 available to trade。 Hyperliquid Unified Account 使用 USDC spot total 减去 hold，最低为零， 并在上游提供 tokenToAvailableAfterMaintenance 时受该 USDC 上限约束。 过期或不可用来源不计入此金额，调用方必须同时展示 freshness、data_status 和 warnings。 这是只读快照估计值，不是可提款额或下单承诺；具体订单仍需通过实时预览、费用和风险检查。 
/// * [pendingTransferUsd] - 尚未划转到任何交易场所的钱包资产小计（`assets` 中未带 `account_ref` 的条目）， 需要先 Transfer 才能计入 available_to_trade_usd。与 `/v1/portfolio/accounts` 中 `available_requires_transfer: true` 分组的 `available_usd` 之和为同一口径。 
/// * [marginInUseUsd] - Hyperliquid 所覆盖 DEX 持仓报告的 margin used 合计；不表示独立于统一抵押物之外的额外资产。
/// * [stocksValueUsd] - Legacy optional aggregate retained for older clients; new clients use source-aware assets.
/// * [unvaluedAssetCount] 
/// * [dataStatus] - 当 `unvalued_asset_count > 0` 时必须为 `partial`。
/// * [freshness] 
/// * [calculatedAt] 
/// * [updatedAt] - Legacy optional alias retained for older clients; new clients use calculated_at.
/// * [oldestObservationAt] 
/// * [warnings] 
/// * [sources] 
@BuiltValue()
abstract class PortfolioSummary implements Built<PortfolioSummary, PortfolioSummaryBuilder> {
  /// 所有已成功估值且去重资产的 subtotal；未估值资产不作为零计入。 Hyperliquid Unified Account 的抵押物从 spotClearinghouseState 读取且只计一次； 不叠加各 DEX 的 accountValue、仓位名义价值或再次叠加未实现损益。 
  @BuiltValueField(wireName: r'total_value_usd')
  String get totalValueUsd;

  /// 首版固定返回 null，不从不完整的缓存或历史估值推导。
  @BuiltValueField(wireName: r'today_pnl_usd')
  String? get todayPnlUsd;

  /// 首版固定返回 null，不从不完整的缓存或历史估值推导。
  @BuiltValueField(wireName: r'today_pnl_percent')
  String? get todayPnlPercent;

  /// 可证明可用的余额子集；普通钱包余额不会自动等于 available to trade。 Hyperliquid Unified Account 使用 USDC spot total 减去 hold，最低为零， 并在上游提供 tokenToAvailableAfterMaintenance 时受该 USDC 上限约束。 过期或不可用来源不计入此金额，调用方必须同时展示 freshness、data_status 和 warnings。 这是只读快照估计值，不是可提款额或下单承诺；具体订单仍需通过实时预览、费用和风险检查。 
  @BuiltValueField(wireName: r'available_to_trade_usd')
  String get availableToTradeUsd;

  /// 尚未划转到任何交易场所的钱包资产小计（`assets` 中未带 `account_ref` 的条目）， 需要先 Transfer 才能计入 available_to_trade_usd。与 `/v1/portfolio/accounts` 中 `available_requires_transfer: true` 分组的 `available_usd` 之和为同一口径。 
  @BuiltValueField(wireName: r'pending_transfer_usd')
  String? get pendingTransferUsd;

  /// Hyperliquid 所覆盖 DEX 持仓报告的 margin used 合计；不表示独立于统一抵押物之外的额外资产。
  @BuiltValueField(wireName: r'margin_in_use_usd')
  String get marginInUseUsd;

  /// Legacy optional aggregate retained for older clients; new clients use source-aware assets.
  @Deprecated('stocksValueUsd has been deprecated')
  @BuiltValueField(wireName: r'stocks_value_usd')
  String? get stocksValueUsd;

  @BuiltValueField(wireName: r'unvalued_asset_count')
  int get unvaluedAssetCount;

  /// 当 `unvalued_asset_count > 0` 时必须为 `partial`。
  @BuiltValueField(wireName: r'data_status')
  PortfolioDataStatus get dataStatus;
  // enum dataStatusEnum {  complete,  partial,  empty,  };

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'calculated_at')
  DateTime get calculatedAt;

  /// Legacy optional alias retained for older clients; new clients use calculated_at.
  @Deprecated('updatedAt has been deprecated')
  @BuiltValueField(wireName: r'updated_at')
  DateTime? get updatedAt;

  @BuiltValueField(wireName: r'oldest_observation_at')
  DateTime? get oldestObservationAt;

  @BuiltValueField(wireName: r'warnings')
  BuiltList<PortfolioNotice> get warnings;

  @BuiltValueField(wireName: r'sources')
  BuiltList<PortfolioSourceSummary> get sources;

  PortfolioSummary._();

  factory PortfolioSummary([void updates(PortfolioSummaryBuilder b)]) = _$PortfolioSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioSummary> get serializer => _$PortfolioSummarySerializer();
}

class _$PortfolioSummarySerializer implements PrimitiveSerializer<PortfolioSummary> {
  @override
  final Iterable<Type> types = const [PortfolioSummary, _$PortfolioSummary];

  @override
  final String wireName = r'PortfolioSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'total_value_usd';
    yield serializers.serialize(
      object.totalValueUsd,
      specifiedType: const FullType(String),
    );
    if (object.todayPnlUsd != null) {
      yield r'today_pnl_usd';
      yield serializers.serialize(
        object.todayPnlUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.todayPnlPercent != null) {
      yield r'today_pnl_percent';
      yield serializers.serialize(
        object.todayPnlPercent,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'available_to_trade_usd';
    yield serializers.serialize(
      object.availableToTradeUsd,
      specifiedType: const FullType(String),
    );
    if (object.pendingTransferUsd != null) {
      yield r'pending_transfer_usd';
      yield serializers.serialize(
        object.pendingTransferUsd,
        specifiedType: const FullType(String),
      );
    }
    yield r'margin_in_use_usd';
    yield serializers.serialize(
      object.marginInUseUsd,
      specifiedType: const FullType(String),
    );
    if (object.stocksValueUsd != null) {
      yield r'stocks_value_usd';
      yield serializers.serialize(
        object.stocksValueUsd,
        specifiedType: const FullType(String),
      );
    }
    yield r'unvalued_asset_count';
    yield serializers.serialize(
      object.unvaluedAssetCount,
      specifiedType: const FullType(int),
    );
    yield r'data_status';
    yield serializers.serialize(
      object.dataStatus,
      specifiedType: const FullType(PortfolioDataStatus),
    );
    yield r'freshness';
    yield serializers.serialize(
      object.freshness,
      specifiedType: const FullType(PortfolioFreshness),
    );
    yield r'calculated_at';
    yield serializers.serialize(
      object.calculatedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.updatedAt != null) {
      yield r'updated_at';
      yield serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(DateTime),
      );
    }
    if (object.oldestObservationAt != null) {
      yield r'oldest_observation_at';
      yield serializers.serialize(
        object.oldestObservationAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    yield r'warnings';
    yield serializers.serialize(
      object.warnings,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioNotice)]),
    );
    yield r'sources';
    yield serializers.serialize(
      object.sources,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalValueUsd = valueDes;
          break;
        case r'today_pnl_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.todayPnlUsd = valueDes;
          break;
        case r'today_pnl_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.todayPnlPercent = valueDes;
          break;
        case r'available_to_trade_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.availableToTradeUsd = valueDes;
          break;
        case r'pending_transfer_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.pendingTransferUsd = valueDes;
          break;
        case r'margin_in_use_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.marginInUseUsd = valueDes;
          break;
        case r'stocks_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.stocksValueUsd = valueDes;
          break;
        case r'unvalued_asset_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unvaluedAssetCount = valueDes;
          break;
        case r'data_status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioDataStatus),
          ) as PortfolioDataStatus;
          result.dataStatus = valueDes;
          break;
        case r'freshness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(PortfolioFreshness),
          ) as PortfolioFreshness;
          result.freshness = valueDes;
          break;
        case r'calculated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.calculatedAt = valueDes;
          break;
        case r'updated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.updatedAt = valueDes;
          break;
        case r'oldest_observation_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.oldestObservationAt = valueDes;
          break;
        case r'warnings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioNotice)]),
          ) as BuiltList<PortfolioNotice>;
          result.warnings.replace(valueDes);
          break;
        case r'sources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
          ) as BuiltList<PortfolioSourceSummary>;
          result.sources.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioSummaryBuilder();
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

