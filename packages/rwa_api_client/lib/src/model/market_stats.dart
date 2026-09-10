//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'market_stats.g.dart';

/// HIP-3 成交量/成交额与前日基准来自同场所 asset context；高低价按最近24小时的一分钟成交K线聚合， 边界按分钟包含，可能包含当前未收盘的一根；没有成交K线时省略高低字段，不填零。 HIP-3 reference_price 为该场所 oracle，reference_label 必须明确其来源，不冒充美股报价。 盘口缺少一侧时省略相应最优价和 spread；上游请求失败不是空盘口。 next_funding_at 没有已验证来源时为空。可选统计缺失不代表数值为零。 
///
/// Properties:
/// * [high24h] - 十进制字符串，避免浮点误差
/// * [low24h] - 十进制字符串，避免浮点误差
/// * [turnover24hUsd] - 十进制字符串，避免浮点误差
/// * [volume24h] - 十进制字符串，避免浮点误差
/// * [volume24hUnit] 
/// * [referenceLabel] - bStocks 为 `US Stock Reference`；HIP-3 为 `Spot / Reference Price`
/// * [referencePrice] - 十进制字符串，避免浮点误差
/// * [relativeLabel] - bStocks 为 `Premium`；HIP-3 为 `Basis`
/// * [relativePercent] - 十进制字符串，避免浮点误差
/// * [spreadPercent] - 十进制字符串，避免浮点误差
/// * [bestBid] - 十进制字符串，避免浮点误差
/// * [bestAsk] - 十进制字符串，避免浮点误差
/// * [fundingRate] - 仅 HIP-3，原始小数费率（如 0.0001 表示 0.01%），不是用户已支付的美元金额。正费率多头付空头，负费率反向。
/// * [nextFundingAt] 
/// * [openInterestUsd] - 仅 HIP-3
@BuiltValue()
abstract class MarketStats implements Built<MarketStats, MarketStatsBuilder> {
  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'high_24h')
  String? get high24h;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'low_24h')
  String? get low24h;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'turnover_24h_usd')
  String? get turnover24hUsd;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'volume_24h')
  String? get volume24h;

  @BuiltValueField(wireName: r'volume_24h_unit')
  String? get volume24hUnit;

  /// bStocks 为 `US Stock Reference`；HIP-3 为 `Spot / Reference Price`
  @BuiltValueField(wireName: r'reference_label')
  String? get referenceLabel;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'reference_price')
  String? get referencePrice;

  /// bStocks 为 `Premium`；HIP-3 为 `Basis`
  @BuiltValueField(wireName: r'relative_label')
  String? get relativeLabel;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'relative_percent')
  String? get relativePercent;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'spread_percent')
  String? get spreadPercent;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'best_bid')
  String? get bestBid;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'best_ask')
  String? get bestAsk;

  /// 仅 HIP-3，原始小数费率（如 0.0001 表示 0.01%），不是用户已支付的美元金额。正费率多头付空头，负费率反向。
  @BuiltValueField(wireName: r'funding_rate')
  String? get fundingRate;

  @BuiltValueField(wireName: r'next_funding_at')
  DateTime? get nextFundingAt;

  /// 仅 HIP-3
  @BuiltValueField(wireName: r'open_interest_usd')
  String? get openInterestUsd;

  MarketStats._();

  factory MarketStats([void updates(MarketStatsBuilder b)]) = _$MarketStats;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MarketStatsBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<MarketStats> get serializer => _$MarketStatsSerializer();
}

class _$MarketStatsSerializer implements PrimitiveSerializer<MarketStats> {
  @override
  final Iterable<Type> types = const [MarketStats, _$MarketStats];

  @override
  final String wireName = r'MarketStats';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    MarketStats object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.high24h != null) {
      yield r'high_24h';
      yield serializers.serialize(
        object.high24h,
        specifiedType: const FullType(String),
      );
    }
    if (object.low24h != null) {
      yield r'low_24h';
      yield serializers.serialize(
        object.low24h,
        specifiedType: const FullType(String),
      );
    }
    if (object.turnover24hUsd != null) {
      yield r'turnover_24h_usd';
      yield serializers.serialize(
        object.turnover24hUsd,
        specifiedType: const FullType(String),
      );
    }
    if (object.volume24h != null) {
      yield r'volume_24h';
      yield serializers.serialize(
        object.volume24h,
        specifiedType: const FullType(String),
      );
    }
    if (object.volume24hUnit != null) {
      yield r'volume_24h_unit';
      yield serializers.serialize(
        object.volume24hUnit,
        specifiedType: const FullType(String),
      );
    }
    if (object.referenceLabel != null) {
      yield r'reference_label';
      yield serializers.serialize(
        object.referenceLabel,
        specifiedType: const FullType(String),
      );
    }
    if (object.referencePrice != null) {
      yield r'reference_price';
      yield serializers.serialize(
        object.referencePrice,
        specifiedType: const FullType(String),
      );
    }
    if (object.relativeLabel != null) {
      yield r'relative_label';
      yield serializers.serialize(
        object.relativeLabel,
        specifiedType: const FullType(String),
      );
    }
    if (object.relativePercent != null) {
      yield r'relative_percent';
      yield serializers.serialize(
        object.relativePercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.spreadPercent != null) {
      yield r'spread_percent';
      yield serializers.serialize(
        object.spreadPercent,
        specifiedType: const FullType(String),
      );
    }
    if (object.bestBid != null) {
      yield r'best_bid';
      yield serializers.serialize(
        object.bestBid,
        specifiedType: const FullType(String),
      );
    }
    if (object.bestAsk != null) {
      yield r'best_ask';
      yield serializers.serialize(
        object.bestAsk,
        specifiedType: const FullType(String),
      );
    }
    if (object.fundingRate != null) {
      yield r'funding_rate';
      yield serializers.serialize(
        object.fundingRate,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.nextFundingAt != null) {
      yield r'next_funding_at';
      yield serializers.serialize(
        object.nextFundingAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.openInterestUsd != null) {
      yield r'open_interest_usd';
      yield serializers.serialize(
        object.openInterestUsd,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    MarketStats object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required MarketStatsBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'high_24h':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.high24h = valueDes;
          break;
        case r'low_24h':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.low24h = valueDes;
          break;
        case r'turnover_24h_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.turnover24hUsd = valueDes;
          break;
        case r'volume_24h':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.volume24h = valueDes;
          break;
        case r'volume_24h_unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.volume24hUnit = valueDes;
          break;
        case r'reference_label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.referenceLabel = valueDes;
          break;
        case r'reference_price':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.referencePrice = valueDes;
          break;
        case r'relative_label':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.relativeLabel = valueDes;
          break;
        case r'relative_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.relativePercent = valueDes;
          break;
        case r'spread_percent':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.spreadPercent = valueDes;
          break;
        case r'best_bid':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bestBid = valueDes;
          break;
        case r'best_ask':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.bestAsk = valueDes;
          break;
        case r'funding_rate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.fundingRate = valueDes;
          break;
        case r'next_funding_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.nextFundingAt = valueDes;
          break;
        case r'open_interest_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.openInterestUsd = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  MarketStats deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MarketStatsBuilder();
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

