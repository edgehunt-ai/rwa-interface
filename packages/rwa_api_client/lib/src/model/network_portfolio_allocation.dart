//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/network_portfolio_allocation_item.dart';
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:rwa_api_client/src/model/portfolio_source_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_data_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'network_portfolio_allocation.g.dart';

/// NetworkPortfolioAllocation
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
abstract class NetworkPortfolioAllocation implements Built<NetworkPortfolioAllocation, NetworkPortfolioAllocationBuilder> {
  @BuiltValueField(wireName: r'dimension')
  NetworkPortfolioAllocationDimensionEnum get dimension;
  // enum dimensionEnum {  network,  };

  @BuiltValueField(wireName: r'items')
  BuiltList<NetworkPortfolioAllocationItem> get items;

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

  NetworkPortfolioAllocation._();

  factory NetworkPortfolioAllocation([void updates(NetworkPortfolioAllocationBuilder b)]) = _$NetworkPortfolioAllocation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(NetworkPortfolioAllocationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<NetworkPortfolioAllocation> get serializer => _$NetworkPortfolioAllocationSerializer();
}

class _$NetworkPortfolioAllocationSerializer implements PrimitiveSerializer<NetworkPortfolioAllocation> {
  @override
  final Iterable<Type> types = const [NetworkPortfolioAllocation, _$NetworkPortfolioAllocation];

  @override
  final String wireName = r'NetworkPortfolioAllocation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    NetworkPortfolioAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'dimension';
    yield serializers.serialize(
      object.dimension,
      specifiedType: const FullType(NetworkPortfolioAllocationDimensionEnum),
    );
    yield r'items';
    yield serializers.serialize(
      object.items,
      specifiedType: const FullType(BuiltList, [FullType(NetworkPortfolioAllocationItem)]),
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
    NetworkPortfolioAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required NetworkPortfolioAllocationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'dimension':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(NetworkPortfolioAllocationDimensionEnum),
          ) as NetworkPortfolioAllocationDimensionEnum;
          result.dimension = valueDes;
          break;
        case r'items':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(NetworkPortfolioAllocationItem)]),
          ) as BuiltList<NetworkPortfolioAllocationItem>;
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
  NetworkPortfolioAllocation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NetworkPortfolioAllocationBuilder();
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

class NetworkPortfolioAllocationDimensionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'network')
  static const NetworkPortfolioAllocationDimensionEnum network = _$networkPortfolioAllocationDimensionEnum_network;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const NetworkPortfolioAllocationDimensionEnum unknownDefaultOpenApi = _$networkPortfolioAllocationDimensionEnum_unknownDefaultOpenApi;

  static Serializer<NetworkPortfolioAllocationDimensionEnum> get serializer => _$networkPortfolioAllocationDimensionEnumSerializer;

  const NetworkPortfolioAllocationDimensionEnum._(String name): super(name);

  static BuiltSet<NetworkPortfolioAllocationDimensionEnum> get values => _$networkPortfolioAllocationDimensionEnumValues;
  static NetworkPortfolioAllocationDimensionEnum valueOf(String name) => _$networkPortfolioAllocationDimensionEnumValueOf(name);
}

