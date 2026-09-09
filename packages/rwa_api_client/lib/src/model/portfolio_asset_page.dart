//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/portfolio_asset.dart';
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:rwa_api_client/src/model/portfolio_source_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_data_status.dart';
import 'package:rwa_api_client/src/model/page.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'portfolio_asset_page.g.dart';

/// 分页资产余额及其已估值小计、未估值数量、来源状态和缓存时间。 `valued_total_usd` 与 `unvalued_asset_count` 是同一 immutable snapshot 下对 完整资产集合计算的全局聚合值，会在每一页重复；客户端不得跨页累加。
///
/// Properties:
/// * [nextCursor] - 为 `null` 表示没有更多数据
/// * [hasMore]
/// * [items]
/// * [valuedTotalUsd] - 同一 immutable snapshot 范围内全部已成功估值资产的全局 subtotal， 不代表全部资产价值；该值会在每页重复，客户端不得跨页累加。
/// * [unvaluedAssetCount] - 同一 immutable snapshot 范围内完整资产集合的全局未估值数量；该值会 在每页重复，客户端不得跨页累加。
/// * [dataStatus] - 当 `unvalued_asset_count > 0` 时必须为 `partial`。
/// * [freshness]
/// * [calculatedAt]
/// * [oldestObservationAt]
/// * [warnings]
/// * [sources]
@BuiltValue()
abstract class PortfolioAssetPage
    implements Page, Built<PortfolioAssetPage, PortfolioAssetPageBuilder> {
  /// 同一 immutable snapshot 范围内完整资产集合的全局未估值数量；该值会 在每页重复，客户端不得跨页累加。
  @BuiltValueField(wireName: r'unvalued_asset_count')
  int get unvaluedAssetCount;

  @BuiltValueField(wireName: r'sources')
  BuiltList<PortfolioSourceSummary> get sources;

  @BuiltValueField(wireName: r'oldest_observation_at')
  DateTime? get oldestObservationAt;

  @BuiltValueField(wireName: r'warnings')
  BuiltList<PortfolioNotice> get warnings;

  /// 当 `unvalued_asset_count > 0` 时必须为 `partial`。
  @BuiltValueField(wireName: r'data_status')
  PortfolioDataStatus get dataStatus;
  // enum dataStatusEnum {  complete,  partial,  empty,  };

  /// 同一 immutable snapshot 范围内全部已成功估值资产的全局 subtotal， 不代表全部资产价值；该值会在每页重复，客户端不得跨页累加。
  @BuiltValueField(wireName: r'valued_total_usd')
  String get valuedTotalUsd;

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'items')
  BuiltList<PortfolioAsset> get items;

  @BuiltValueField(wireName: r'calculated_at')
  DateTime get calculatedAt;

  PortfolioAssetPage._();

  factory PortfolioAssetPage([void updates(PortfolioAssetPageBuilder b)]) =
      _$PortfolioAssetPage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAssetPageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAssetPage> get serializer =>
      _$PortfolioAssetPageSerializer();
}

class _$PortfolioAssetPageSerializer
    implements PrimitiveSerializer<PortfolioAssetPage> {
  @override
  final Iterable<Type> types = const [PortfolioAssetPage, _$PortfolioAssetPage];

  @override
  final String wireName = r'PortfolioAssetPage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioAssetPage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'next_cursor';
    yield object.nextCursor == null
        ? null
        : serializers.serialize(
            object.nextCursor,
            specifiedType: const FullType.nullable(String),
          );
    yield r'unvalued_asset_count';
    yield serializers.serialize(
      object.unvaluedAssetCount,
      specifiedType: const FullType(int),
    );
    yield r'sources';
    yield serializers.serialize(
      object.sources,
      specifiedType:
          const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
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
    yield r'valued_total_usd';
    yield serializers.serialize(
      object.valuedTotalUsd,
      specifiedType: const FullType(String),
    );
    yield r'freshness';
    yield serializers.serialize(
      object.freshness,
      specifiedType: const FullType(PortfolioFreshness),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(PortfolioAsset)]),
    );
    yield r'calculated_at';
    yield serializers.serialize(
      object.calculatedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAssetPage object, {
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
    required PortfolioAssetPageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'next_cursor':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.nextCursor = valueDes;
          break;
        case r'unvalued_asset_count':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.unvaluedAssetCount = valueDes;
          break;
        case r'sources':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(PortfolioSourceSummary)]),
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
            specifiedType:
                const FullType(BuiltList, [FullType(PortfolioNotice)]),
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
        case r'valued_total_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.valuedTotalUsd = valueDes;
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
            specifiedType:
                const FullType(BuiltList, [FullType(PortfolioAsset)]),
          ) as BuiltList<PortfolioAsset>;
          result.items.replace(valueDes);
          break;
        case r'calculated_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.calculatedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  PortfolioAssetPage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioAssetPageBuilder();
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
