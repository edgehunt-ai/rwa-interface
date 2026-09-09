//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/funding_plan_mode.dart';
import 'package:rwa_api_client/src/model/auto_single_source_funding_plan_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/product_kind.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_id.dart';
import 'package:rwa_api_client/src/model/legacy_funding_plan_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'funding_plan_request.g.dart';

/// Accepts the current immutable preview request or the deprecated v1.0 request during migration.
///
/// Properties:
/// * [tradePreviewId] - Immutable trade preview from which purpose, target identity and required target amount are derived.
/// * [mode]
/// * [sourceAssetId] - Optional exact canonical source asset constraint. If supplied, planning must not quote or select any other source.
/// * [rail]
/// * [asset]
/// * [amount] - 十进制字符串，避免浮点误差
@BuiltValue()
abstract class FundingPlanRequest
    implements Built<FundingPlanRequest, FundingPlanRequestBuilder> {
  /// One Of [AutoSingleSourceFundingPlanRequest], [LegacyFundingPlanRequest]
  OneOf get oneOf;

  FundingPlanRequest._();

  factory FundingPlanRequest([void updates(FundingPlanRequestBuilder b)]) =
      _$FundingPlanRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(FundingPlanRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<FundingPlanRequest> get serializer =>
      _$FundingPlanRequestSerializer();
}

class _$FundingPlanRequestSerializer
    implements PrimitiveSerializer<FundingPlanRequest> {
  @override
  final Iterable<Type> types = const [FundingPlanRequest, _$FundingPlanRequest];

  @override
  final String wireName = r'FundingPlanRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    FundingPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {}

  @override
  Object serialize(
    Serializers serializers,
    FundingPlanRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value,
        specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  FundingPlanRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = FundingPlanRequestBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [
      FullType(AutoSingleSourceFundingPlanRequest),
      FullType(LegacyFundingPlanRequest),
    ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc,
        specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class FundingPlanRequestAssetEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'USDC')
  static const FundingPlanRequestAssetEnum USDC =
      _$fundingPlanRequestAssetEnum_USDC;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const FundingPlanRequestAssetEnum unknownDefaultOpenApi =
      _$fundingPlanRequestAssetEnum_unknownDefaultOpenApi;

  static Serializer<FundingPlanRequestAssetEnum> get serializer =>
      _$fundingPlanRequestAssetEnumSerializer;

  const FundingPlanRequestAssetEnum._(String name) : super(name);

  static BuiltSet<FundingPlanRequestAssetEnum> get values =>
      _$fundingPlanRequestAssetEnumValues;
  static FundingPlanRequestAssetEnum valueOf(String name) =>
      _$fundingPlanRequestAssetEnumValueOf(name);
}
