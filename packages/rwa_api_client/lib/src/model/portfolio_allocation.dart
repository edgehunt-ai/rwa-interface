//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/product_portfolio_allocation.dart';
import 'package:rwa_api_client/src/model/rail_portfolio_allocation.dart';
import 'package:rwa_api_client/src/model/network_portfolio_allocation.dart';
import 'package:rwa_api_client/src/model/network_portfolio_allocation_item.dart';
import 'package:rwa_api_client/src/model/portfolio_notice.dart';
import 'package:rwa_api_client/src/model/portfolio_source_summary.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/asset_portfolio_allocation.dart';
import 'package:rwa_api_client/src/model/portfolio_freshness.dart';
import 'package:rwa_api_client/src/model/portfolio_data_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'portfolio_allocation.g.dart';

/// 由请求的 dimension 决定且互斥的配置响应；每个 variant 要求 singleton dimension， 因而一个 wire response 不能同时作为两个维度解释。为保证 Rust、Dart 与 TypeScript 生成客户端都能按 wire 中保留的 `dimension` round-trip，variant 选择完全由各分支自身 required singleton 字段决定，不使用会吞掉内层 `dimension` 的 OpenAPI discriminator。 
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
abstract class PortfolioAllocation implements Built<PortfolioAllocation, PortfolioAllocationBuilder> {
  /// One Of [AssetPortfolioAllocation], [NetworkPortfolioAllocation], [ProductPortfolioAllocation], [RailPortfolioAllocation]
  OneOf get oneOf;

  PortfolioAllocation._();

  factory PortfolioAllocation([void updates(PortfolioAllocationBuilder b)]) = _$PortfolioAllocation;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(PortfolioAllocationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<PortfolioAllocation> get serializer => _$PortfolioAllocationSerializer();
}

class _$PortfolioAllocationSerializer implements PrimitiveSerializer<PortfolioAllocation> {
  @override
  final Iterable<Type> types = const [PortfolioAllocation, _$PortfolioAllocation];

  @override
  final String wireName = r'PortfolioAllocation';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    PortfolioAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    PortfolioAllocation object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  PortfolioAllocation deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = PortfolioAllocationBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(AssetPortfolioAllocation), FullType(ProductPortfolioAllocation), FullType(RailPortfolioAllocation), FullType(NetworkPortfolioAllocation), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class PortfolioAllocationDimensionEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'network')
  static const PortfolioAllocationDimensionEnum network = _$portfolioAllocationDimensionEnum_network;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const PortfolioAllocationDimensionEnum unknownDefaultOpenApi = _$portfolioAllocationDimensionEnum_unknownDefaultOpenApi;

  static Serializer<PortfolioAllocationDimensionEnum> get serializer => _$portfolioAllocationDimensionEnumSerializer;

  const PortfolioAllocationDimensionEnum._(String name): super(name);

  static BuiltSet<PortfolioAllocationDimensionEnum> get values => _$portfolioAllocationDimensionEnumValues;
  static PortfolioAllocationDimensionEnum valueOf(String name) => _$portfolioAllocationDimensionEnumValueOf(name);
}

