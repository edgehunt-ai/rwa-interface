//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_id.dart';
import 'package:rwa_api_client/src/model/trade_intent_execution_policy.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'trade_intent_create_request.g.dart';

/// TradeIntentCreateRequest
///
/// Properties:
/// * [previewId]
/// * [authorizationId]
/// * [fundingMode]
/// * [sourceAssetId]
/// * [executionPolicy]
@BuiltValue()
abstract class TradeIntentCreateRequest
    implements
        Built<TradeIntentCreateRequest, TradeIntentCreateRequestBuilder> {
  @BuiltValueField(wireName: r'preview_id')
  String get previewId;

  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  @BuiltValueField(wireName: r'funding_mode')
  TradeIntentCreateRequestFundingModeEnum get fundingMode;
  // enum fundingModeEnum {  auto_single_source,  };

  @BuiltValueField(wireName: r'source_asset_id')
  FundingSourceAssetId? get sourceAssetId;
  // enum sourceAssetIdEnum {  eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48,  eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7,  eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831,  eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9,  eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913,  eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2,  eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d,  eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955,  };

  @BuiltValueField(wireName: r'execution_policy')
  TradeIntentExecutionPolicy get executionPolicy;

  TradeIntentCreateRequest._();

  factory TradeIntentCreateRequest(
          [void updates(TradeIntentCreateRequestBuilder b)]) =
      _$TradeIntentCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TradeIntentCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TradeIntentCreateRequest> get serializer =>
      _$TradeIntentCreateRequestSerializer();
}

class _$TradeIntentCreateRequestSerializer
    implements PrimitiveSerializer<TradeIntentCreateRequest> {
  @override
  final Iterable<Type> types = const [
    TradeIntentCreateRequest,
    _$TradeIntentCreateRequest
  ];

  @override
  final String wireName = r'TradeIntentCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TradeIntentCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'preview_id';
    yield serializers.serialize(
      object.previewId,
      specifiedType: const FullType(String),
    );
    yield r'authorization_id';
    yield serializers.serialize(
      object.authorizationId,
      specifiedType: const FullType(String),
    );
    yield r'funding_mode';
    yield serializers.serialize(
      object.fundingMode,
      specifiedType: const FullType(TradeIntentCreateRequestFundingModeEnum),
    );
    if (object.sourceAssetId != null) {
      yield r'source_asset_id';
      yield serializers.serialize(
        object.sourceAssetId,
        specifiedType: const FullType(FundingSourceAssetId),
      );
    }
    yield r'execution_policy';
    yield serializers.serialize(
      object.executionPolicy,
      specifiedType: const FullType(TradeIntentExecutionPolicy),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TradeIntentCreateRequest object, {
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
    required TradeIntentCreateRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'preview_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.previewId = valueDes;
          break;
        case r'authorization_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.authorizationId = valueDes;
          break;
        case r'funding_mode':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(TradeIntentCreateRequestFundingModeEnum),
          ) as TradeIntentCreateRequestFundingModeEnum;
          result.fundingMode = valueDes;
          break;
        case r'source_asset_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(FundingSourceAssetId),
          ) as FundingSourceAssetId?;
          if (valueDes == null) continue;
          result.sourceAssetId = valueDes;
          break;
        case r'execution_policy':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(TradeIntentExecutionPolicy),
          ) as TradeIntentExecutionPolicy;
          result.executionPolicy.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TradeIntentCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TradeIntentCreateRequestBuilder();
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

class TradeIntentCreateRequestFundingModeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'auto_single_source')
  static const TradeIntentCreateRequestFundingModeEnum autoSingleSource =
      _$tradeIntentCreateRequestFundingModeEnum_autoSingleSource;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const TradeIntentCreateRequestFundingModeEnum unknownDefaultOpenApi =
      _$tradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<TradeIntentCreateRequestFundingModeEnum> get serializer =>
      _$tradeIntentCreateRequestFundingModeEnumSerializer;

  const TradeIntentCreateRequestFundingModeEnum._(String name) : super(name);

  static BuiltSet<TradeIntentCreateRequestFundingModeEnum> get values =>
      _$tradeIntentCreateRequestFundingModeEnumValues;
  static TradeIntentCreateRequestFundingModeEnum valueOf(String name) =>
      _$tradeIntentCreateRequestFundingModeEnumValueOf(name);
}
