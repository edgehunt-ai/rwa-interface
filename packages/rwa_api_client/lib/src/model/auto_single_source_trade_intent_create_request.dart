//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:rwa_api_client/src/model/funding_source_asset_id.dart';
import 'package:rwa_api_client/src/model/trade_intent_execution_policy.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'auto_single_source_trade_intent_create_request.g.dart';

/// AutoSingleSourceTradeIntentCreateRequest
///
/// Properties:
/// * [previewId] 
/// * [authorizationId] - Order authorization; it never authorizes a funding leg or Transfer.
/// * [fundingMode] 
/// * [sourceAssetId] 
/// * [executionPolicy] 
@Deprecated('AutoSingleSourceTradeIntentCreateRequest has been deprecated')
@BuiltValue()
abstract class AutoSingleSourceTradeIntentCreateRequest implements Built<AutoSingleSourceTradeIntentCreateRequest, AutoSingleSourceTradeIntentCreateRequestBuilder> {
  @BuiltValueField(wireName: r'preview_id')
  String get previewId;

  /// Order authorization; it never authorizes a funding leg or Transfer.
  @BuiltValueField(wireName: r'authorization_id')
  String get authorizationId;

  @BuiltValueField(wireName: r'funding_mode')
  AutoSingleSourceTradeIntentCreateRequestFundingModeEnum get fundingMode;
  // enum fundingModeEnum {  auto_single_source,  };

  @BuiltValueField(wireName: r'source_asset_id')
  FundingSourceAssetId? get sourceAssetId;
  // enum sourceAssetIdEnum {  eip155:1/erc20:0xa0b86991c6218b36c1d19d4a2e9eb0ce3606eb48,  eip155:1/erc20:0xdac17f958d2ee523a2206206994597c13d831ec7,  eip155:42161/erc20:0xaf88d065e77c8cc2239327c5edb3a432268e5831,  eip155:42161/erc20:0xfd086bc7cd5c481dcc9c85ebe478a1c0b69fcbb9,  eip155:8453/erc20:0x833589fcd6edb6e08f4c7c32d4f71b54bda02913,  eip155:8453/erc20:0xfde4c96c8593536e31f229ea8f37b2ada2699bb2,  eip155:56/erc20:0x8ac76a51cc950d9822d68b83fe1ad97b32cd580d,  eip155:56/erc20:0x55d398326f99059ff775485246999027b3197955,  eip155:421614/erc20:0x75faf114eafb1bdbe2f0316df893fd58ce46aa4d,  eip155:421614/erc20:0x1baabb04529d43a73232b713c0fe471f7c7334d5,  eip155:97/erc20:0xd7beebb53879df47b5cca32b3680e70c13f093a0,  };

  @BuiltValueField(wireName: r'execution_policy')
  TradeIntentExecutionPolicy get executionPolicy;

  AutoSingleSourceTradeIntentCreateRequest._();

  factory AutoSingleSourceTradeIntentCreateRequest([void updates(AutoSingleSourceTradeIntentCreateRequestBuilder b)]) = _$AutoSingleSourceTradeIntentCreateRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AutoSingleSourceTradeIntentCreateRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AutoSingleSourceTradeIntentCreateRequest> get serializer => _$AutoSingleSourceTradeIntentCreateRequestSerializer();
}

class _$AutoSingleSourceTradeIntentCreateRequestSerializer implements PrimitiveSerializer<AutoSingleSourceTradeIntentCreateRequest> {
  @override
  final Iterable<Type> types = const [AutoSingleSourceTradeIntentCreateRequest, _$AutoSingleSourceTradeIntentCreateRequest];

  @override
  final String wireName = r'AutoSingleSourceTradeIntentCreateRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AutoSingleSourceTradeIntentCreateRequest object, {
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
      specifiedType: const FullType(AutoSingleSourceTradeIntentCreateRequestFundingModeEnum),
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
    AutoSingleSourceTradeIntentCreateRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AutoSingleSourceTradeIntentCreateRequestBuilder result,
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
            specifiedType: const FullType(AutoSingleSourceTradeIntentCreateRequestFundingModeEnum),
          ) as AutoSingleSourceTradeIntentCreateRequestFundingModeEnum;
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
  AutoSingleSourceTradeIntentCreateRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AutoSingleSourceTradeIntentCreateRequestBuilder();
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

@Deprecated('AutoSingleSourceTradeIntentCreateRequestFundingModeEnum has been deprecated')
class AutoSingleSourceTradeIntentCreateRequestFundingModeEnum extends EnumClass {

  @BuiltValueEnumConst(wireName: r'auto_single_source')
  static const AutoSingleSourceTradeIntentCreateRequestFundingModeEnum autoSingleSource = _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_autoSingleSource;
  @BuiltValueEnumConst(wireName: r'unknown_default_open_api', fallback: true)
  static const AutoSingleSourceTradeIntentCreateRequestFundingModeEnum unknownDefaultOpenApi = _$autoSingleSourceTradeIntentCreateRequestFundingModeEnum_unknownDefaultOpenApi;

  static Serializer<AutoSingleSourceTradeIntentCreateRequestFundingModeEnum> get serializer => _$autoSingleSourceTradeIntentCreateRequestFundingModeEnumSerializer;

  const AutoSingleSourceTradeIntentCreateRequestFundingModeEnum._(String name): super(name);

  static BuiltSet<AutoSingleSourceTradeIntentCreateRequestFundingModeEnum> get values => _$autoSingleSourceTradeIntentCreateRequestFundingModeEnumValues;
  static AutoSingleSourceTradeIntentCreateRequestFundingModeEnum valueOf(String name) => _$autoSingleSourceTradeIntentCreateRequestFundingModeEnumValueOf(name);
}

