//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_holding_page_all_of_coverage.dart';
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:rwa_api_client/src/model/portfolio_source_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/holding_group.dart';
import 'package:rwa_api_client/src/model/portfolio_data_status.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_holding_page.g.dart';

/// 分页 HIP-3 position 展示。position notional 只用于展示，不再累加进 summary； total equity 采用 Hyperliquid account equity，避免对同一 venue 资产双计。 
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore] 
/// * [coverage] 
/// * [items] 
/// * [totalEquityUsd] - Hyperliquid account equity；不以 position notional 求和。
/// * [totalValueUsd] - Legacy optional alias retained for clients pinned to v1.0.0.
/// * [dataStatus] 
/// * [freshness] 
/// * [calculatedAt] 
/// * [oldestObservationAt] 
/// * [warnings] 
/// * [sources] 
@BuiltValue()
abstract class PortfolioHoldingPage implements Page, Built<PortfolioHoldingPage, PortfolioHoldingPageBuilder> {
  @BuiltValueField(wireName: r'coverage')
  PortfolioHoldingPageAllOfCoverage? get coverage;

  /// Hyperliquid account equity；不以 position notional 求和。
  @BuiltValueField(wireName: r'total_equity_usd')
  String get totalEquityUsd;

  @BuiltValueField(wireName: r'sources')
  BuiltList<PortfolioSourceSummary> get sources;

  @BuiltValueField(wireName: r'oldest_observation_at')
  DateTime? get oldestObservationAt;

  @BuiltValueField(wireName: r'warnings')
  BuiltList<PortfolioNotice> get warnings;

  @BuiltValueField(wireName: r'data_status')
  PortfolioDataStatus get dataStatus;
  // enum dataStatusEnum {  complete,  partial,  empty,  };

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'items')
  BuiltList<HoldingGroup> get items;

  @BuiltValueField(wireName: r'calculated_at')
  DateTime get calculatedAt;

  /// Legacy optional alias retained for clients pinned to v1.0.0.
  @Deprecated('totalValueUsd has been deprecated')
  @BuiltValueField(wireName: r'total_value_usd')
  String? get totalValueUsd;

  PortfolioHoldingPage._();

  factory PortfolioHoldingPage([void updates(PortfolioHoldingPageBuilder b)]) = _$PortfolioHoldingPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioHoldingPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioHoldingPage> get serializer => _$PortfolioHoldingPageSerializer();
}

class _$PortfolioHoldingPageSerializer implements PrimitiveSerializer<PortfolioHoldingPage> {
  @override
  final Iterable<Type> types = const [PortfolioHoldingPage, _$PortfolioHoldingPage];

  @override
  final String wireName = r'PortfolioHoldingPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioHoldingPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.coverage != null) {
      yield r'coverage';
      yield serializers.serialize(
        object.coverage,
        specifiedType: const FullType(PortfolioHoldingPageAllOfCoverage),
      );
    }
    yield r'next_cursor';
    yield object.nextCursor == null ? null : serializers.serialize(
      object.nextCursor,
      specifiedType: const FullType.nullable(String),
    );
    yield r'total_equity_usd';
    yield serializers.serialize(
      object.totalEquityUsd,
      specifiedType: const FullType(String),
    );
    yield r'sources';
    yield serializers.serialize(
      object.sources,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
    );
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
    yield r'has_more';
    yield serializers.serialize(
      object.hasMore,
      specifiedType: const FullType(bool),
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
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(HoldingGroup)]),
    );
    yield r'calculated_at';
    yield serializers.serialize(
      object.calculatedAt,
      specifiedType: const FullType(DateTime),
    );
    if (object.totalValueUsd != null) {
      yield r'total_value_usd';
      yield serializers.serialize(
        object.totalValueUsd,
        specifiedType: const FullType(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioHoldingPage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required PortfolioHoldingPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'coverage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(PortfolioHoldingPageAllOfCoverage),
          ) as PortfolioHoldingPageAllOfCoverage?;
          if (valueDes == null) continue;
          result.coverage.replace(valueDes);
          break;
        case r'next_cursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextCursor = valueDes;
          break;
        case r'total_equity_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.totalEquityUsd = valueDes;
          break;
        case r'sources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
          ) as BuiltList<PortfolioSourceSummary>;
          result.sources.replace(valueDes);
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
        case r'has_more':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.hasMore = valueDes;
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
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(HoldingGroup)]),
          ) as BuiltList<HoldingGroup>;
          result.items.replace(valueDes);
          break;
        case r'calculated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.calculatedAt = valueDes;
          break;
        case r'total_value_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.totalValueUsd = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioHoldingPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioHoldingPageBuilder();
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

