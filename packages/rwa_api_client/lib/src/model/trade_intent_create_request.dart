//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:rwa_api_client/src/model/auto_multi_source_trade_intent_create_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_id.dart';
import 'package:rwa_api_client/src/model/trade_intent_execution_policy.dart';
import 'package:rwa_api_client/src/model/auto_single_source_trade_intent_create_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:one_of/one_of.dart';

part 'trade_intent_create_request.g.dart';

/// Selects single- or multi-source automatic funding while keeping plan, leg and route selection server-owned.
///
/// Properties:
/// * [previewId] 
/// * [authorizationId] - Order authorization; funding Transfers require a separate authorization for each leg.
/// * [fundingMode] 
/// * [sourceAssetId] 
/// * [executionPolicy] 
@BuiltValue()
abstract class TradeIntentCreateRequest implements Built<TradeIntentCreateRequest, TradeIntentCreateRequestBuilder> {
  /// One Of [AutoMultiSourceTradeIntentCreateRequest], [AutoSingleSourceTradeIntentCreateRequest]
  OneOf get oneOf;

  TradeIntentCreateRequest._();

  factory TradeIntentCreateRequest([void updates(TradeIntentCreateRequestBuilder b)]) = _$TradeIntentCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TradeIntentCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TradeIntentCreateRequest> get serializer => _$TradeIntentCreateRequestSerializer();
}

class _$TradeIntentCreateRequestSerializer implements PrimitiveSerializer<TradeIntentCreateRequest> {
  @override
  final Iterable<Type> types = const [TradeIntentCreateRequest, _$TradeIntentCreateRequest];

  @override
  final String wireName = r'TradeIntentCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TradeIntentCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
  }

  @override
  Object serialize(
    Serializers serializers,
    TradeIntentCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final oneOf = object.oneOf;
    return serializers.serialize(oneOf.value, specifiedType: FullType(oneOf.valueType))!;
  }

  @override
  TradeIntentCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TradeIntentCreateRequestBuilder();
    Object? oneOfDataSrc;
    final targetType = const FullType(OneOf, [FullType(AutoSingleSourceTradeIntentCreateRequest), FullType(AutoMultiSourceTradeIntentCreateRequest), ]);
    oneOfDataSrc = serialized;
    result.oneOf = serializers.deserialize(oneOfDataSrc, specifiedType: targetType) as OneOf;
    return result.build();
  }
}

class TradeIntentCreateRequestFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'auto_multi_source')
  static const TradeIntentCreateRequestFundingModeEnum autoMultiSource = _$tradeIntentCreateRequestFundingModeEnum_autoMultiSource;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TradeIntentCreateRequestFundingModeEnum unknownDefaultOpenApi = _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<TradeIntentCreateRequestFundingModeEnum> get serializer => _$tradeIntentCreateRequestFundingModeEnumSerializer;

  const TradeIntentCreateRequestFundingModeEnum._(String name): super(name);

  static BuiltSet<TradeIntentCreateRequestFundingModeEnum> get values => _$tradeIntentCreateRequestFundingModeEnumValues;
  static TradeIntentCreateRequestFundingModeEnum valueOf(String name) => _$tradeIntentCreateRequestFundingModeEnumValueOf(name);
}

