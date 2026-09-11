//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/rail_portfolio_allocation_item.dart';
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:rwa_api_client/src/model/portfolio_source_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_data_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'rail_portfolio_allocation.g.dart';

/// RailPortfolioAllocation
///
/// Properties:
/// * [dimension] 
/// * [items] 
/// * [valuedTotalUsd] - 十进制字符串，避免浮点误差
/// * [unvaluedAssetCount] 
/// * [dataStatus] 
/// * [freshness] 
/// * [calculatedAt] 
/// * [warnings] 
/// * [sources] 
@BuiltValue()
abstract class RailPortfolioAllocation implements Built<RailPortfolioAllocation, RailPortfolioAllocationBuilder> {
  @BuiltValueField(wireName: r'dimension')
  RailPortfolioAllocationDimensionEnum get dimension;
  // enum dimensionEnum {  rail,  };

  @BuiltValueField(wireName: r'items')
  BuiltList<RailPortfolioAllocationItem> get items;

  /// 十进制字符串，避免浮点误差
  @BuiltValueField(wireName: r'valued_total_usd')
  String get valuedTotalUsd;

  @BuiltValueField(wireName: r'unvalued_asset_count')
  int get unvaluedAssetCount;

  @BuiltValueField(wireName: r'data_status')
  PortfolioDataStatus get dataStatus;
  // enum dataStatusEnum {  complete,  partial,  empty,  };

  @BuiltValueField(wireName: r'freshness')
  PortfolioFreshness get freshness;
  // enum freshnessEnum {  live,  cached,  stale,  };

  @BuiltValueField(wireName: r'calculated_at')
  DateTime get calculatedAt;

  @BuiltValueField(wireName: r'warnings')
  BuiltList<PortfolioNotice> get warnings;

  @BuiltValueField(wireName: r'sources')
  BuiltList<PortfolioSourceSummary> get sources;

  RailPortfolioAllocation._();

  factory RailPortfolioAllocation([void updates(RailPortfolioAllocationBuilder b)]) = _$RailPortfolioAllocation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(RailPortfolioAllocationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<RailPortfolioAllocation> get serializer => _$RailPortfolioAllocationSerializer();
}

class _$RailPortfolioAllocationSerializer implements PrimitiveSerializer<RailPortfolioAllocation> {
  @override
  final Iterable<Type> types = const [RailPortfolioAllocation, _$RailPortfolioAllocation];

  @override
  final String wireName = r'RailPortfolioAllocation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    RailPortfolioAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'dimension';
    yield serializers.serialize(
      object.dimension,
      specifiedType: const FullType(RailPortfolioAllocationDimensionEnum),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(RailPortfolioAllocationItem)]),
    );
    yield r'valued_total_usd';
    yield serializers.serialize(
      object.valuedTotalUsd,
      specifiedType: const FullType(String),
    );
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
    RailPortfolioAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required RailPortfolioAllocationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'dimension':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(RailPortfolioAllocationDimensionEnum),
          ) as RailPortfolioAllocationDimensionEnum;
          result.dimension = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(RailPortfolioAllocationItem)]),
          ) as BuiltList<RailPortfolioAllocationItem>;
          result.items.replace(valueDes);
          break;
        case r'valued_total_usd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.valuedTotalUsd = valueDes;
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
  RailPortfolioAllocation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = RailPortfolioAllocationBuilder();
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

class RailPortfolioAllocationDimensionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'rail')
  static const RailPortfolioAllocationDimensionEnum rail = _$railPortfolioAllocationDimensionEnum_rail;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const RailPortfolioAllocationDimensionEnum unknownDefaultOpenApi = _$railPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;

  static Serializer<RailPortfolioAllocationDimensionEnum> get serializer => _$railPortfolioAllocationDimensionEnumSerializer;

  const RailPortfolioAllocationDimensionEnum._(String name): super(name);

  static BuiltSet<RailPortfolioAllocationDimensionEnum> get values => _$railPortfolioAllocationDimensionEnumValues;
  static RailPortfolioAllocationDimensionEnum valueOf(String name) => _$railPortfolioAllocationDimensionEnumValueOf(name);
}

